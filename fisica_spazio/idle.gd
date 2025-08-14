extends celestialBody


# Called when the node enters the scene tree for the first time.
func _ready():
	$visual.scale = Vector3.ONE 
	$cam.global_transform.origin.z = $visual.scale.z + 0.2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation.y += 3 *delta
