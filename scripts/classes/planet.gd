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



#func _process(delta):
	#
	#if getSpaceRef():
		#var bodies = getSpaceRef().getBodies()
		#for other in bodies:
			#if other != self:
				#if other.is_in_group("star"):
					##print(other)
					##print(body_ref.global_transform.origin)
					##print(other.global_transform.origin)
					#calculateGravForce(getBodyRef(), other)
					##print(getGravitForce())
	#
	#updatePosition(delta)
	#pass

func setPlanetRef(p : Node):
	setBodyRef(p)

func initialize(p : planet):  #si aggiunge al gruppo pianeti
	setPlanetRef(p)
	setSpaceRef(p.get_parent())
	p.add_to_group("planet")

	#print("terra ", previous_position, current_position)
