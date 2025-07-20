extends planet


# Called when the node enters the scene tree for the first time.
func _ready():
	
	orbital_verse = -1
	a = 57910000 # Semi-asse maggiore (distanza media dal sole)
	e = 0.2056  # Eccentricità dell'orbita
	T = 4.3985 # Periodo orbitale in secondi (1 giorno = 1 secondo, tot secondi/20)
	inclination_orbit = deg_to_rad(7.01) # Inclinazione orbitale in radianti
	variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	longitudinal_ascendent_node = deg_to_rad(48.331) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita)
	variation_longitudinal_ascendent_node = deg_to_rad(-0.0002299794661191) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	perigee_argument = deg_to_rad(29.124) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	variation_perigee_argument = deg_to_rad(0.00314852840520192) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	time_elapsed = 0.0 # tempo di inizio dell'orbita
	rot_in_one_sec = deg_to_rad(122.770521434) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
	inclination_axis = deg_to_rad(0.034) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(281.01) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(61.45) # inclinazione in radianti asse corpo celeste

	radius = 2439.7
	mass = 3.301 * 1e23

	#$cam.rotation_degrees.x = -90
	
	super._ready()
	$cam.global_transform.origin.y = (radius + 2)

func _process(delta):
	super._process(delta)
	#print(velocity)
	$shape.scale = Vector3.ONE * radius
	$visual.scale = Vector3.ONE * radius
