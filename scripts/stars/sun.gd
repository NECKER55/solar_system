extends star


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	
	mass = 1.989 * 1e21
	
	initialize(self)
	self.global_transform.origin = Vector3(0,0,0)
	
	inclination_axis = deg_to_rad(7.25) # Inclinazione assiale in radianti
	ascension_rect = deg_to_rad(286.13) # inclinazione in radianti asse corpo celeste
	declination_pole = deg_to_rad(63.87) # inclinazione in radianti asse corpo celeste
	
	radius = 6.9634

	#$cam.rotation_degrees.x = -90
	$cam.global_transform.origin.y = (radius + 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	var distance = self.global_transform.origin.distance_to(Global.principal_cam.global_transform.origin)
	var scale_factor = lerp(1, 10, distance/5000)
	$shape.scale = Vector3.ONE * radius * scale_factor
	$visual.scale = Vector3.ONE * radius * scale_factor
