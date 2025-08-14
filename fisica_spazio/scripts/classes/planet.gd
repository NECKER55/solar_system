extends celestialBody
class_name planet


func set_orbit_color(color : Color):
	orbit_color = color


func _ready():
	initialize(self)
	a *= 4
	super._ready()




func _process(delta):
	super._process(delta)


func setPlanetRef(p : Node):
	setBodyRef(p)

func initialize(p : planet):  #si aggiunge al gruppo pianeti
	setPlanetRef(p)
	setSpaceRef(p.get_parent())
	p.add_to_group("planet")
