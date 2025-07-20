extends planet


# Called when the node enters the scene tree for the first time.
func _ready():
	
	orbital_verse = -1
	a = 4498396441 # Semi-asse maggiore (distanza media dal sole)
	e = 0.0086  # Eccentricità dell'orbita
	T = 3009.66 # Periodo orbitale in secondi (1 giorno = 1 secondo, tot secondi/20)
	inclination_orbit = deg_to_rad(1.77) # Inclinazione orbitale in radianti
	variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	longitudinal_ascendent_node = deg_to_rad(131.784) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita)
	variation_longitudinal_ascendent_node = deg_to_rad(0.0003668720054757) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	perigee_argument = deg_to_rad(276.336) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	variation_perigee_argument = deg_to_rad(-0.00000547570157426) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	time_elapsed = 0.0 # tempo di inizio dell'orbita
	rot_in_one_sec = deg_to_rad(10725.456031578) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
	inclination_axis = deg_to_rad(28.32) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(299.36) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(43.46) # inclinazione in radianti asse corpo celeste
	
	radius = 24622
	mass = 1.024 * 1e26
	
	#$cam.rotation_degrees.x = -90
	super._ready()
	$cam.global_transform.origin.y = (radius + 2)


func _process(delta):
	super._process(delta)
	$shape.scale = Vector3.ONE * radius
	$visual.scale = Vector3.ONE * radius
