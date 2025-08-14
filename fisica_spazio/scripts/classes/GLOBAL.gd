extends Node

signal  change_camera(object_name)

signal instantiate_asteroid(asteroid)
signal throw_asteroid(asteroid)
signal delete_asteroid()

signal change_mass(mass)
signal change_type(type)
signal change_velocity(velocity)

signal change_gravity_force(f)

var one_day = 0.05
var one_year = 365
var leap_year = 0

var day = 0
var year = 0

var TIME_SCALE =0.000000579  # 1 sec = 1 sec
var cam_pos = Vector3.ZERO

# la camera della freemode principale
var principal_cam : Camera3D

func _process(delta):
	day += delta * TIME_SCALE / one_day
	if leap_year > 3:
		one_year = 366
	else:
		one_year = 365
	
	if day > one_year:
			day = 0
			year += 1
			if one_year == 365:
				leap_year += 1
			else:
				leap_year = 0

func set_global_variable(key, value):
	set(key, value)

func get_global_variable(key):
	return get(key)
