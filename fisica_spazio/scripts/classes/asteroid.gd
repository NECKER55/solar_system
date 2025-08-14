extends Area3D

var iron = load("res://asteroid/materials/iron.tres")
var stone = load("res://asteroid/materials/stone.tres")

@export var cam : Node3D
@export var space : Node3D
@export var texture : Node3D

@export var material = 0  
var iron_density = 7870 # densità ferro 7870 kg/m3
var stone_density = 1500 # densità pietra 1500 kg/m3

@export var radius = 1 # 1 = 1000 km

@export var mass = 1 # 1 = 1000 kg


@export var direction : Vector3
@export var velocity = Vector3(0,0,0)
@export var gravitational_force = Vector3(0,0,0)
var a = Vector3(0,0,0)

var previous_position = Vector3(0,0,0)
var current_position = Vector3(0,0,0)


var orbit = MultiMeshInstance3D.new()
var trail_points: Array[Vector3] = []  # Lista dei punti della scia
var oldest_index = 0
var index_to_update = 0
var orbit_color = Color("purple")

var time_scale_for_two_days_in_one_sec = 172711.571675302

func _ready():
	Global.connect("change_mass", Callable(self, "_on_change_mass"))
	Global.connect("change_type", Callable(self, "_on_change_type"))
	Global.connect("change_velocity", Callable(self, "_on_change_velocity"))
	
	Global.connect("change_gravity_force", Callable(self, "_on_change_gravity_force"))
	
	space = get_parent().get_parent()
	#self.scale = Vector3.ONE * 4
	
	add_orbit()

func _process(delta):
	
	if get_parent() != space:
		direction = -Global.principal_cam.global_transform.basis.z
	else:
		$visual.rotation_degrees.z +=1
		self.global_translate(velocity * delta * time_scale_for_two_days_in_one_sec)
		draw_orbit()
	
	calculate_velocity(delta)


func setMovement(gravitational_vec: Vector3):
	self.gravitational_force += gravitational_vec

func calculate_radius():
	if material == 0: #stone
		radius = (mass / stone_density)/1e-7
	elif material == 1: #iron
		radius = (mass / iron_density)/1e-7
	
	var distance_min = 1
	
	if radius < 0.07:
		radius = 0.07
		distance_min = 0.3
	if radius > 2:
		radius = 2
	self.scale = Vector3.ONE * radius

	$cam.global_transform.origin.y = (radius + distance_min)
	
func _on_change_mass(m):
	mass = m
	calculate_radius()

func _on_change_type(type):
	material = type
	if type == 0:
		$visual.material = stone
	elif type == 1:
		$visual.material = iron
	calculate_radius()

func _on_change_velocity(v):
	velocity = direction * v


func _on_change_gravity_force(f):
	gravitational_force = f
	#print(gravitational_force)

func calculate_velocity(delta):	
	var a = calculate_aceleration()
	#print(a, "   ", a)
	velocity += a * delta * time_scale_for_two_days_in_one_sec
	
# la adatta al mondo in cui ci troviamo
func calculate_aceleration():
	#print(gravitational_force)
	var a = gravitational_force / mass
	a *= 4
	a /= 1e6
	a /= 1000
	return a


# funzioni per tracciare l'orbita
func add_orbit():
	print(trail_points)
	orbit.multimesh = MultiMesh.new()
	orbit.multimesh.mesh = PointMesh.new()
	orbit.multimesh.transform_format = MultiMesh.TRANSFORM_3D
	orbit.multimesh.instance_count = 50000
	
	var material = StandardMaterial3D.new()
	material.albedo_color = orbit_color
	material.emission_enabled = true
	material.emission = orbit_color
	material.emission_energy_multiplier = 16.0
	
	orbit.multimesh.mesh.surface_set_material(0,material)
	space.add_child(orbit)
	
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

# elimina l'orbita alla sua sparizione
func _on_tree_exiting():
	if get_parent() == space:
		orbit.queue_free()
		orbit = null
		# Svuota l'array dei punti della traccia e resetta oldest_index
		trail_points.clear()

		oldest_index = 0  # Resetta oldest_index a 0
