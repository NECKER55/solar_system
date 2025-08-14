extends celestialBody

var iron = load("res://asteroid/materials/iron.tres")
var stone = load("res://asteroid/materials/stone.tres")


func _ready():
	Global.connect("change_type", Callable(self, "_on_change_type"))
	$visual.scale = Vector3.ONE
	$visual.material = stone
	$cam.global_transform.origin.z = $visual.scale.z + 3.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotation.y += 3 *delta


func _on_change_type(type):
	if type == 0:
		$visual.material = stone
	elif type == 1:
		$visual.material = iron
