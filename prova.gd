extends Area3D

var a = 149.6 # Semi-asse maggiore (distanza media dal sole)
var e = 0.0167  # Eccentricità dell'orbita
var T = 18.2625 # Periodo orbitale in secondi
var inclination = deg_to_rad(0) # Inclinazione orbitale in radianti
var time_elapsed = 0.0
var rot_in_one_sec = 20


func _ready():
	self.rotation_degrees.z = 23.34



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
	
	var M = (2 * PI / T) * time_elapsed
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
	
	# 6. Applichiamo l'inclinazione dell'orbita
	var pos = Vector3(x, y, z).rotated(Vector3(1, 0, 0), inclination)
	
	# 7. Aggiorniamo la posizione del pianeta
	self.global_transform.origin = pos

func _process(delta):
	delta *= Global.TIME_SCALE
	update_orbit(delta)
	self.rotate_object_local(Vector3(0,1,0), rot_in_one_sec * delta)

