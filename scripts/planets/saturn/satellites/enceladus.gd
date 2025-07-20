extends satellite


# Called when the node enters the scene tree for the first time.
func _ready():
	
	orbital_verse = -1
	a = 237948 # Semi-asse maggiore (distanza media dal baricentro)
	e = 0.0045  # Eccentricità dell'orbita
	T = 0.0685109 # Periodo orbitale in secondi (1 giorno = 1 secondo, tot secondi/20)
	inclination_orbit = deg_to_rad(26.75) # Inclinazione orbitale in radianti
	variation_inclination_orbit = deg_to_rad(0) # variazione in radianti dell'inclinazione in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	longitudinal_ascendent_node = deg_to_rad(22.38) # longitudine in radianti di dove il pianeta passa da un esmisfero all'altro (indica la direzione dell'orbita)
	variation_longitudinal_ascendent_node = deg_to_rad(-0.00315) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	perigee_argument = deg_to_rad(115.36) # variazione in radianti del nodo longitudinale ascendente in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	variation_perigee_argument = deg_to_rad(0.0016) # variazione in radianti dell'argomento del perigeo in un unità di tempo (un secondo della simulazione) (variazione in un periodo orbitale/periodo orbitale)
	time_elapsed = 0.0 # tempo di inizio dell'orbita
	rot_in_one_sec = deg_to_rad(5254.638313028) # radianti della rotazione in un'unità di tempo (un secondo della simulazione) (rotazioni in un periodo orbitale/periodo orbitale)
	inclination_axis = deg_to_rad(26.709) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(79.5) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(61.5) # inclinazione in radianti asse corpo celeste
	
	radius = 252.1
	mass = 1.080 * 1e20
	
	#$cam.rotation_degrees.x = -90
	super._ready()
	$cam.global_transform.origin.y = (radius + 0.1)


func _process(delta):
	reference_pos = space_ref.get_node("saturn").global_transform.origin
	super._process(delta)
	$shape.scale = Vector3.ONE * radius
	$visual.scale = Vector3.ONE * radius
