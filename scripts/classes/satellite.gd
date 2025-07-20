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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#
	#if getSpaceRef():
		#var bodies = getSpaceRef().getBodies()
		#for other in bodies:
			#if other != self:
				#if other.is_in_group("planet"):
					##print(other)
					##print(body_ref.global_transform.origin)
					##print(other.global_transform.origin)
					#calculateGravForce(getBodyRef(), other)
					##print(getGravitForce())
	#
	#updatePosition(delta)
	#pass

func setSatelliteRef(s : Node):
	setBodyRef(s)

func initialize(s : satellite):  #si aggiunge al gruppo satelliti
	setSatelliteRef(s)
	setSpaceRef(s.get_parent())
	s.add_to_group("satellite")
	#print("satellite ", previous_position, current_position)
