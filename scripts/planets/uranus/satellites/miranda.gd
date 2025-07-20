extends satellite


# Called when the node enters the scene tree for the first time.
func _ready():
	
	orbital_verse = -1
	a = 129390 # Semi-asse maggiore (distanza media dal baricentro)
	e = 0.0013  # Eccentricità dell'orbita
	T = 0.07065 # Periodo orbitale in secondi (1 giorno = 1 secondo, tot secondi/20)
	inclination_orbit = deg_to_rad(102) # Inclinazione orbitale in radianti
	variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	longitudinal_ascendent_node = deg_to_rad(326.43) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita)
	variation_longitudinal_ascendent_node = deg_to_rad(-0.00615) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	perigee_argument = deg_to_rad(68.31) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	variation_perigee_argument = deg_to_rad(0.0031) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	time_elapsed = 0.0 # tempo di inizio dell'orbita
	rot_in_one_sec = deg_to_rad(5095.541401274) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
	inclination_axis = deg_to_rad(97.86) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(326.43) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(68.31) # inclinazione in radianti asse corpo celeste
	
	radius = 235.8
	mass = 6.590 * 1e21
	
	#$cam.rotation_degrees.x = -90
	super._ready()
	$cam.global_transform.origin.y = (radius + 0.1)


func _process(delta):
	reference_pos = space_ref.get_node("uranus").global_transform.origin
	super._process(delta)
	$shape.scale = Vector3.ONE * radius
	$visual.scale = Vector3.ONE * radius
