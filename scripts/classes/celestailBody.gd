extends Node3D
class_name celestialBody

@export var texture : MeshInstance3D
@export var cam : Node3D


var mass : float = 0
var radius : float = 0

var velocity: Vector3 = Vector3.ZERO
var gravitationalForce: Vector3 = Vector3.ZERO

var space_ref = null
var body_ref = null



var reference_pos : Vector3 # posizione relativa alla stella

var tot_orbits = 0

var orbital_verse = -1
var a = 0 # Semi-asse maggiore (distanza media dal sole)
var e = 0  # Eccentricità dell'orbita
var T = 0 # Periodo orbitale in secondi
var inclination_orbit = deg_to_rad(0) # Inclinazione orbitale in radianti
var variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
var longitudinal_ascendent_node = deg_to_rad(0) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita) (rispetto all'epoca anno 2000)
var variation_longitudinal_ascendent_node = deg_to_rad(0) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
var perigee_argument = deg_to_rad(0) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
var variation_perigee_argument = deg_to_rad(0) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
var time_elapsed = 0.0 # tempo di inizio dell'orbita
var rot_in_one_sec = deg_to_rad(0) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
var inclination_axis = deg_to_rad(0) # Inclinazione assiale in radianti
var ascension_rect = deg_to_rad(0) # inclinazione in radianti asse corpo celeste
var declination_pole = deg_to_rad(0) # inclinazione in radianti asse corpo celeste

var trail_update_timer = 0.0  # Timer per gestire l'aggiornamento
var trail_update_interval = 0.05  # Tempo tra un aggiornamento e l'altro (modificabile)

var orbit = MultiMeshInstance3D.new()
var trail_points: Array[Vector3] = []  # Lista dei punti della scia
var oldest_index = 0
var index_to_update = 0
var orbit_color = Color(1.0, 1.0, 0.0)

var speed = 0

func _ready():
	
	radius /= 1e6
	radius *= 1e2
	radius *= 2 # la scala riduce di metà
	
	a /= 1e6
	#self.transform.basis = self.transform.basis.rotated(Vector3(1, 0, 0), inclination_axis)
	
	var axis_dir = get_axis_direction()

	# Creiamo una Basis (matrice di rotazione)
	var rotation_basis = Basis()
	
	# Allinea l'asse Y del pianeta con axis_dir
	rotation_basis.y = axis_dir
	rotation_basis.x = axis_dir.cross(Vector3(0, 1, 0)).normalized()  # Trova un nuovo asse X ortogonale
	rotation_basis.z = rotation_basis.x.cross(rotation_basis.y).normalized()  # Trova Z ortogonale

	# Ruotiamo il pianeta attorno al suo vero asse per applicare l'inclinazione assiale
	rotation_basis = rotation_basis.rotated(rotation_basis.x, inclination_axis)

	# Applichiamo la trasformazione
	if texture != null:
		texture.transform.basis = rotation_basis
		add_orbit()

func get_axis_direction():
	return Vector3(
		cos(ascension_rect) * cos(declination_pole),
		sin(declination_pole),
		sin(ascension_rect) * cos(declination_pole)
	).normalized()

func _process(delta):
	
	delta *= Global.TIME_SCALE
	
	# aggiorna la variazione dell'orientamento dell'orbita
	longitudinal_ascendent_node += variation_longitudinal_ascendent_node * delta 
	inclination_orbit += variation_inclination_orbit * delta
	perigee_argument += variation_perigee_argument * delta
	
	update_orbit(delta)
	
	 # Gestione della scia con velocità regolabile
	var time_scale : float
	if Global.TIME_SCALE < 1:
		time_scale = Global.TIME_SCALE
	else:
		time_scale = 1/Global.TIME_SCALE
	
	var scaled_trail_update_interval = trail_update_interval * (sqrt(T) * time_scale)  # Scala la durata del timer in base alla velocità del corpo e alla scala del tempo
	trail_update_timer += delta  
	if trail_update_timer >= scaled_trail_update_interval and texture != null:
		draw_orbit()
		trail_update_timer = 0  # Resetta il timer
	
	# rotazione intorno asse pianeta
	if texture != null:
		var local_axis = texture.global_transform.basis.y  # L'asse Y reale del pianeta
		texture.global_transform.basis = texture.global_transform.basis.rotated(local_axis.normalized(), rot_in_one_sec * delta)



func kepler_solve(M, e, tol=1e-6, max_iter=10):
	#Risolve l'anomalia eccentrica E usando il metodo iterativo di Newton-Raphson
	var E = M # Stima iniziale
	for i in range(max_iter):
		var f_E = E - e * sin(E) - M
		var f_prime_E = 1 - e * cos(E)
		var delta = f_E / f_prime_E
		E -= delta
		if abs(delta) < tol:
			break
	return E
	
func update_orbit(dt):
	#Aggiorna la posizione del pianeta in base al tempo trascorso
	time_elapsed += dt
	
	var M = (orbital_verse * 2 * PI / T) * time_elapsed
	
	# aggiorna il numero di rbite (se M raggiunge 2 pi significa che ha completato un giro)
	if M >= 2*PI:
		tot_orbits += 1
	
	M = fmod(M, 2 * PI) # Manteniamo M nell'intervallo 0 - 2π
	
	# 2. Risolve l'anomalia eccentrica E
	var E = kepler_solve(M, e)
	
	# 3. Calcola l'anomalia vera theta
	var theta = 2 * atan(sqrt((1 + e) / (1 - e)) * tan(E / 2))
	
	# 4. Calcola la distanza orbitale r
	var r = a * (1 - e * cos(E))
	
	# 5. Converti in coordinate 3D (prima nel piano xy, poi ruotiamo per inclinare l'orbita)
	var x = r * cos(theta)
	var y = 0 # L'orbita base è nel piano XY, l'inclinazione verrà applicata dopo
	var z = r * sin(theta)
	
	# Creiamo una trasformazione con rotazioni combinate
	var local_pos = Vector3(x,y,z)
	var rotation_basis = Basis()
	rotation_basis = rotation_basis.rotated(Vector3(0, 1, 0), perigee_argument)
	rotation_basis = rotation_basis.rotated(Vector3(0, 0, 1), inclination_orbit)
	rotation_basis = rotation_basis.rotated(Vector3(0, 1, 0), longitudinal_ascendent_node)
	
	var relative_pos = reference_pos - rotation_basis*local_pos
	
	var old_pos = self.global_transform.origin
	# 7. Aggiorniamo la posizione del pianeta
	self.global_transform.origin = relative_pos
	var new_pos = self.global_transform.origin
	
	speed = absf((new_pos-old_pos).length_squared())/dt



func add_orbit():
	orbit.multimesh = MultiMesh.new()
	orbit.multimesh.mesh = PointMesh.new()
	orbit.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	orbit.multimesh.instance_count = 500
	
	var material = StandardMaterial3D.new()
	material.albedo_color = orbit_color
	material.emission_enabled = true
	material.emission = orbit_color
	material.emission_energy_multiplier = 16.0
	
	orbit.multimesh.mesh.surface_set_material(0,material)
	getSpaceRef().add_child(orbit)
	
	orbit.set("multimesh/use_gpu_instance_culling", true)  # Attiva il culling


func draw_orbit():
	
	var new_point = self.global_transform.origin  # Posizione attuale
	
	# aggiunge i punti fino a raggiungere il ilmite massimo
	if trail_points.size() < orbit.multimesh.instance_count:
		trail_points.append(new_point)
		index_to_update = trail_points.size() - 1
	else:
		# Sovrascrive il punto più vecchio
		trail_points[oldest_index] = new_point
		index_to_update = oldest_index
		oldest_index = (oldest_index + 1) % orbit.multimesh.instance_count  # aggiorna l'indice circolare
		
	var transform = Transform3D(Basis(), new_point)
	orbit.multimesh.set_instance_transform(index_to_update, transform)




func setMass(m : int):
	mass = m

func setRadius(r : int):
	radius = r

func getMass():
	return mass
	
func getRadius():
	return radius

func modifyVelocity(v : Vector3):
	velocity += v


func getVelocity():
	return velocity

func getGravitForce():
	return gravitationalForce

func modifyGravForce(f : Vector3):
	gravitationalForce = f

func setSpaceRef(space : Node):
	space_ref = space
	
func getSpaceRef():
	return space_ref

func setBodyRef(body : Node):
	body_ref = body
	
func getBodyRef():
	return body_ref

func calculateGravForce(body : celestialBody, other : celestialBody):
	var distance = distanceBetweenTwoBodies(body, other)
	if distance < 0.01:
		distance = 0.01
	#print(space_ref.getGConst(),"   ",body.getMass() ,"  ", other.getMass(),"  ",distance)
	var force = space_ref.getGConst()*(body.getMass() * other.getMass())/(distance*distance)
	#print(force)
	var direction = (other.global_transform.origin - body.global_transform.origin).normalized()
	var grav_vec = direction * force
	modifyGravForce(grav_vec)

func updatePosition(delta):
	delta *= Global.TIME_SCALE
	var a = calculateNewAcceleration()
	velocity += a
	self.global_transform.origin += velocity*delta
	#print(self.global_transform.origin)
	#delta *= Global.TIME_SCALE

	#var a = calculateNewAcceleration()
	#
## Salviamo la posizione attuale
	#var next_position = 2 * self.global_transform.origin - previous_position + (a/1e9 * delta * delta)
#
## Aggiorniamo la posizione precedent
	#previous_position = self.global_transform.origin
	#self.global_transform.origin = next_position
#
## Aggiorniamo la velocità per altri usi (se necessaria)
	#velocity = (self.global_transform.origin - previous_position) / delta


func calculateNewAcceleration():
	#print(getGravitForce(), getMass())
	return gravitationalForce/mass

func distanceBetweenTwoBodies(body : celestialBody, other : celestialBody):
	#print(body.global_transform.origin.distance_to(other.global_transform.origin))
	return body.global_transform.origin.distance_to(other.global_transform.origin)

