extends Node

signal  change_camera(object_name)

signal instantiate_asteroid(asteroid)
signal throw_asteroid(asteroid)
signal delete_asteroid()

signal change_mass(mass)
signal change_type(type)
signal change_velocity(velocity)

signal change_gravity_force(f)


var time = 0
var year = 0
var TIME_SCALE =0.000000579  # 1 sec = 1 sec
var cam_pos = Vector3.ZERO

# la camera della freemode principale
var principal_cam : Camera3D

func _process(delta):
	time += delta*TIME_SCALE
	if time >= 18.2625:
		time = fmod(time, 18.2625)
		year += 1

func set_global_variable(key, value):
	set(key, value)

func get_global_variable(key):
	return get(key)
