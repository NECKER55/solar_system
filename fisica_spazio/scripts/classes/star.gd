extends celestialBody
class_name star

func _ready():
	pass

func _process(delta):
	pass

func setPlanetRef(p : Node):
	setBodyRef(p)

func initialize(p : star):  #si aggiunge al gruppo stelle
	setPlanetRef(p)
	setSpaceRef(p.get_parent())
	p.add_to_group("star")
