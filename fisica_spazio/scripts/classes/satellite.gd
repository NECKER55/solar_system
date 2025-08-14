extends celestialBody
class_name satellite


func set_orbit_color(color : Color):
	orbit_color = color


func _ready():
	initialize(self)
	set_orbit_color(Color("green"))
	a *= 1e2
	super._ready()



func _process(delta):
	super._process(delta)

func setSatelliteRef(s : Node):
	setBodyRef(s)

func initialize(s : satellite):  #si aggiunge al gruppo satelliti
	setSatelliteRef(s)
	setSpaceRef(s.get_parent())
	s.add_to_group("satellite")
