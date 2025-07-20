extends satellite


# Called when the node enters the scene tree for the first time.
func _ready():
	
	orbital_verse = -1
	a = 354759 # Semi-asse maggiore (distanza media dal sole) 384.400 km
	e = 0.000016  # Eccentricità dell'orbita
	T = 0.29385 # Periodo orbitale in secondi (1 giorno = 1 secondo, tot secondi/20)
	inclination_orbit = deg_to_rad(158.604) # Inclinazione orbitale in radianti
	variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	longitudinal_ascendent_node = deg_to_rad(174.425) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita)
	variation_longitudinal_ascendent_node = deg_to_rad(-0.00015) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	perigee_argument = deg_to_rad(14.459) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	variation_perigee_argument = deg_to_rad(0.000075) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	time_elapsed = 0.0 # tempo di inizio dell'orbita
	rot_in_one_sec = deg_to_rad(1225.114854518) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
	inclination_axis = deg_to_rad(186.878) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(85) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(58) # inclinazione in radianti asse corpo celeste
		
	radius = 1353.4
	mass = 2.139 * 1e22
	
	#$cam.rotation_degrees.x = -90
	super._ready()
	$cam.global_transform.origin.y = (radius + 2)

func _process(delta):
	reference_pos = space_ref.get_node("neptune").global_transform.origin
	super._process(delta)
	$shape.scale = Vector3.ONE * radius
	$visual.scale = Vector3.ONE * radius
