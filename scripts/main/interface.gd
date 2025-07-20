extends Node2D

signal object_changed(object)


var space : Node # nodo di riferimento allo spazio

var asteroid_scene = load("res://scenes/main/asteroid.tscn")


var mercury_scene = load("res://scenes/planets/mercury/mercury.tscn")
var venus_scene = load("res://scenes/planets/venus/venus.tscn")

var earth_scene = load("res://scenes/planets/earth/earth.tscn")
var moon_scene = load("res://scenes/planets/earth/satellites/moon.tscn")


var mars_scene = load("res://scenes/planets/mars/mars.tscn")

var jupiter_scene = load("res://scenes/planets/jupiter/jupiter.tscn")
var io_scene = load("res://scenes/planets/jupiter/satellites/io.tscn")
var europa_scene = load("res://scenes/planets/jupiter/satellites/europa.tscn")
var ganymede_scene = load("res://scenes/planets/jupiter/satellites/ganymede.tscn")
var callisto_scene = load("res://scenes/planets/jupiter/satellites/callisto.tscn")


var saturn_scene = load("res://scenes/planets/saturn/saturn.tscn")
var titan_scene = load("res://scenes/planets/saturn/satellites/titan.tscn")
var enceladus_scene = load("res://scenes/planets/saturn/satellites/enceladus.tscn")
var iapetus_scene = load("res://scenes/planets/saturn/satellites/iapetus.tscn")
var rhea_scene = load("res://scenes/planets/saturn/satellites/rhea.tscn")
var dione_scene = load("res://scenes/planets/saturn/satellites/dione.tscn")
var mimas_scene = load("res://scenes/planets/saturn/satellites/mimas.tscn")



var uranus_scene = load("res://scenes/planets/uranus/uranus.tscn")
var titania_scene = load("res://scenes/planets/uranus/satellites/titania.tscn")
var oberon_scene = load("res://scenes/planets/uranus/satellites/oberon.tscn")
var ariel_scene = load("res://scenes/planets/uranus/satellites/ariel.tscn")
var umbriel_scene = load("res://scenes/planets/uranus/satellites/umbriel.tscn")
var miranda_scene = load("res://scenes/planets/uranus/satellites/miranda.tscn")


var neptune_scene = load("res://scenes/planets/neptune/neptune.tscn")
var triton_scene = load("res://scenes/planets/neptune/satellites/triton.tscn")

var pluto_charonSystem_scene = load("res://scenes/planets/plutoSystem/pluto_charon_system.tscn")
var charon_scene = load("res://scenes/planets/plutoSystem/charon.tscn")
var pluto_scene = load("res://scenes/planets/plutoSystem/pluto.tscn")

var sun_scene = load("res://scenes/stars/sun.tscn")


var celestyal_body_idle = load("res://idle.gd")
var asteroid_idle = load("res://asteroid_idle.gd")

#menu aperti o chiusi verifica
var menu_open_close = false
var asteroid_menu_open_close = false

var screen_size : Vector2

# viewport informazioni pianeti
var viewport : Node
var viewport_son : Node
var screen : Node
var camera: Camera3D #camera della viewport

#planet star or satellite
var target : Node
# nodo asteroide
var asteroid_target : Node

# dati pianeta
var object_name : Label
var object_type : Label
var object_radius : Label
var object_distance : Label
var object_mass : Label

# viewport informazioni asteroide
var asteroid_viewport : Node
var asteroid_viewport_son : Node
var asteroid_camera : Node # camera della viewport
var asteroid_screen : Node


var button_throw : Node
var controller_mass = false
var controller_velocity = false

func _ready():
	
	space = get_parent()
	
	viewport = $SubViewportContainer/SubViewport
	viewport_son = $SubViewportContainer/SubViewport/scene
	screen = $menu_planets/open_close/PanelContainer/celestialBody
	camera = $SubViewportContainer/SubViewport/cam
	
	object_name = $menu_planets/HBoxContainer/VBoxContainer2/name
	object_type = $menu_planets/HBoxContainer/VBoxContainer2/type
	object_radius = $menu_planets/HBoxContainer/VBoxContainer2/radius
	object_distance = $menu_planets/HBoxContainer/VBoxContainer2/distance
	object_mass = $menu_planets/HBoxContainer/VBoxContainer2/mass
	
	asteroid_viewport = $SubViewportContainer2/SubViewport
	asteroid_viewport_son = $SubViewportContainer2/SubViewport/scene
	asteroid_camera = $SubViewportContainer2/SubViewport/cam
	asteroid_screen = $create_body/Panel/scree_asteroid
	
	button_throw = $create_body/Panel/throw

func _process(delta):
	screen_size = get_viewport().size
	
	$margin/container/HBoxContainer/time.text = str(int(Global.year))

	$margin/container/HBoxContainer2/pos_x.text = str(int(Global.get_global_variable("cam_pos").x))
	$margin/container/HBoxContainer2/pos_y.text = str(int(Global.get_global_variable("cam_pos").y))
	$margin/container/HBoxContainer2/pos_z.text = str(int(Global.get_global_variable("cam_pos").z))
	
	# attiva e disattiva il tasto throw
	if controller_mass and controller_velocity:
		button_throw.disabled = false
		button_throw.flat = false
	else:
		button_throw.disabled = true
		button_throw.flat = true
		
func _on_v_slider_value_changed(value):
	if value == 1:
		Global.TIME_SCALE = 0.000000579
	elif value == 2:
		Global.TIME_SCALE = 0.00003474
	elif value == 3:
		Global.TIME_SCALE = 0.0020844
	elif value == 4:
		Global.TIME_SCALE = 0.05
	elif value == 5:
		Global.TIME_SCALE = 0.1
	elif value == 6:
		Global.TIME_SCALE = 0.35
	elif value == 7:
		Global.TIME_SCALE = 0.7
	elif value == 8:
		Global.TIME_SCALE = 1.521875
	elif value == 9:
		Global.TIME_SCALE = 9.13125
	elif value == 10:
		Global.TIME_SCALE = 18.2625
	elif value == 11:
		Global.TIME_SCALE = 36.525
	elif value == 12:
		Global.TIME_SCALE = 91.3125
	elif value == 13:
		Global.TIME_SCALE = 182.625
	elif value == 14:
		Global.TIME_SCALE = 913.125
	elif value == 15:
		Global.TIME_SCALE = 1826.25

func close_all_satellites_menu():
	var menu = $satellites_menu.get_children()
	
	for m in menu:
		m.visible = false


func _on_open_close_pressed():
	$animation.get_animation("open_close_menu").track_set_key_value(0,0, Vector2(screen_size.x, 135))
	$animation.get_animation("open_close_menu").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 135))
	if !menu_open_close:
		$animation.play("open_close_menu")

	else:
		$animation.play_backwards("open_close_menu")
	
	menu_open_close = !menu_open_close
	
	close_all_satellites_menu()
	

func _on_object_changed(object_scene):
	
	var object = object_scene.instantiate()
	object.set_script(celestyal_body_idle)
	viewport_son.add_child(object)
	
	var texture = object.get_node("visual")
	texture.layers = 1 << 9
	for o in texture.get_children():
		o.layers = 1 << 9
	
	print($SubViewportContainer/SubViewport/cam/viewportLight.get_layer_mask_value(10))
	
	var origin_cam = object.get_node("cam")
	camera.global_transform.origin = origin_cam.global_transform.origin
	
	var viewport_texture = viewport.get_texture()
	screen.texture = viewport_texture
	
	target = object

func clean_viewport():
	if viewport_son.get_child_count() != 0:
		for child in viewport_son.get_children():
			viewport_son.remove_child(child)
			child.queue_free()
	

func _on_sun_pressed():
	clean_viewport()
	emit_signal("object_changed", sun_scene)
	
	close_all_satellites_menu()
	
	object_name.text = "sun"
	object_type.text = "star"
	object_radius.text = "696.340 km"
	object_distance.text = "0 km"
	object_mass.text = "2,00502 × 1e30 kg"

func _on_mercury_pressed():
	clean_viewport()
	emit_signal("object_changed", mercury_scene)
	
	close_all_satellites_menu()
	
	object_name.text = "mercury"
	object_type.text = "planet"
	object_radius.text = "2.440 km"
	object_distance.text = "57,91 million km"
	object_mass.text = "3,30 × 1e23 kg"

func _on_venus_pressed():
	clean_viewport()
	emit_signal("object_changed", venus_scene)
	
	close_all_satellites_menu()
	
	object_name.text = "venus"
	object_type.text = "planet"
	object_radius.text = "6.052 km"
	object_distance.text = "108,2 km"
	object_mass.text = "4,87 × 1e24 kg"

func _on_earth_pressed():
	clean_viewport()
	emit_signal("object_changed", earth_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_earth.visible = true
	$animation.get_animation("open_close_earth").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_earth").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_earth")
	
	object_name.text = "earth"
	object_type.text = "planet"
	object_radius.text = "696.340 km"
	object_distance.text = "149,6 milion km"
	object_mass.text = "5,97 × 1e24 kg"

func _on_mars_pressed():
	clean_viewport()
	emit_signal("object_changed", mars_scene)
	
	close_all_satellites_menu()
	
	object_name.text = "mars"
	object_type.text = "planet"
	object_radius.text = "3.390 km"
	object_distance.text = "227,9 milion km"
	object_mass.text = "6,42 × 1e24 kg"

func _on_jupiter_pressed():
	clean_viewport()
	emit_signal("object_changed", jupiter_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_jupiter.visible = true
	$animation.get_animation("open_close_jupiter").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_jupiter").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_jupiter")
	
	object_name.text = "jupiter"
	object_type.text = "planet"
	object_radius.text = "69.911 km"
	object_distance.text = "778,5 milion km"
	object_mass.text = "1,90 × 1e27 kg"

func _on_saturn_pressed():
	clean_viewport()
	emit_signal("object_changed", saturn_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_saturn.visible = true
	$animation.get_animation("open_close_saturn").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_saturn").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_saturn")
	
	object_name.text = "saturn"
	object_type.text = "planet"
	object_radius.text = "58.232 km"
	object_distance.text = "1,429 billion km"
	object_mass.text = "5,68 × 1e26 kg"

func _on_uranus_pressed():
	clean_viewport()
	emit_signal("object_changed", uranus_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_uranus.visible = true
	$animation.get_animation("open_close_uranus").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_uranus").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_uranus")
	
	object_name.text = "uranus"
	object_type.text = "planet"
	object_radius.text = "25.362 km"
	object_distance.text = "2,871 billion km"
	object_mass.text = "8,68 × 1e25 kg"

func _on_neptune_pressed():
	clean_viewport()
	emit_signal("object_changed", neptune_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_neptune.visible = true
	$animation.get_animation("open_close_neptune").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_neptune").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_neptune")
	
	object_name.text = "neptune"
	object_type.text = "planet"
	object_radius.text = "24.622 km"
	object_distance.text = "4,498 billion km"
	object_mass.text = "1,02 × 1e26 kg"

func _on_pluto_pressed():
	clean_viewport()
	emit_signal("object_changed", pluto_scene)
	
	close_all_satellites_menu()
	$satellites_menu/menu_pluto.visible = true
	$animation.get_animation("open_close_pluto").track_set_key_value(0,0, Vector2(screen_size.x, 720))
	$animation.get_animation("open_close_pluto").track_set_key_value(0,1, Vector2(screen_size.x-$menu_planets/open_close/PanelContainer.size.x, 720))
	$animation.play("open_close_pluto")
	
	object_name.text = "pluto"
	object_type.text = "nano planet"
	object_radius.text = "1.188 km"
	object_distance.text = "5,906 billion km"
	object_mass.text = "1,31 × 1e22 kg"





func _on_moon_pressed():
	clean_viewport()
	emit_signal("object_changed", moon_scene)
	
	object_name.text = "moon"
	object_type.text = "satellite of earth"
	object_radius.text = "1.737 km"
	object_distance.text = "384.400 km"
	object_mass.text = "7,34 × 1e22 kg"


func _on_dione_pressed():
	clean_viewport()
	emit_signal("object_changed", dione_scene)
	
	object_name.text = "dione"
	object_type.text = "satellite of saturn"
	object_radius.text = "561 km"
	object_distance.text = "377.420 km"
	object_mass.text = "1,10 × 1e21 kg"

func _on_enceladus_pressed():
	clean_viewport()
	emit_signal("object_changed", enceladus_scene)

	object_name.text = "enceladus"
	object_type.text = "satellite of saturn"
	object_radius.text = "252 km"
	object_distance.text = "237.950 km"
	object_mass.text = "1,08 × 1e20 kg"

func _on_iapetus_pressed():
	clean_viewport()
	emit_signal("object_changed", iapetus_scene)
	
	object_name.text = "iapetus"
	object_type.text = "satellite of saturn"
	object_radius.text = "735 km"
	object_distance.text = "3.561.300 km"
	object_mass.text = "1,81 × 1e21 kg"


func _on_mimas_pressed():
	clean_viewport()
	emit_signal("object_changed", mimas_scene)
	
	object_name.text = "mimas"
	object_type.text = "satellite of saturn"
	object_radius.text = "198 km"
	object_distance.text = "185.540 km"
	object_mass.text = "3,75 × 1e19 kg"


func _on_rhea_pressed():
	clean_viewport()
	emit_signal("object_changed", rhea_scene)
	
	object_name.text = "rhea"
	object_type.text = "satellite of saturn"
	object_radius.text = "764 km"
	object_distance.text = "527.040 km"
	object_mass.text = "2,31 × 1e21 kg"


func _on_titan_pressed():
	clean_viewport()
	emit_signal("object_changed", titan_scene)
	
	object_name.text = "titan"
	object_type.text = "satellite of saturn"
	object_radius.text = "2.575 km"
	object_distance.text = "1.221.870 km"
	object_mass.text = "1,35 × 1e23 kg"


func _on_ariel_pressed():
	clean_viewport()
	emit_signal("object_changed", ariel_scene)
	
	object_name.text = "ariel"
	object_type.text = "satellite of uranus"
	object_radius.text = "579 km"
	object_distance.text = "190.900 km"
	object_mass.text = "1,25  × 1e21 kg"


func _on_miranda_pressed():
	clean_viewport()
	emit_signal("object_changed", miranda_scene)
	
	object_name.text = "miranda"
	object_type.text = "satellite of uranus"
	object_radius.text = "235 km"
	object_distance.text = "129.390 km"
	object_mass.text = "6,59 × 1e19 kg"


func _on_oberon_pressed():
	clean_viewport()
	emit_signal("object_changed", oberon_scene)
	
	object_name.text = "oberon"
	object_type.text = "satellite of uranus"
	object_radius.text = "1.737 km"
	object_distance.text = "384.400 km"
	object_mass.text = "7,34 × 1e22 kg"


func _on_titania_pressed():
	clean_viewport()
	emit_signal("object_changed", titania_scene)
	
	object_name.text = "titania"
	object_type.text = "satellite of uranus"
	object_radius.text = "788 km"
	object_distance.text = "435.910 km"
	object_mass.text = "3,42 × 1e21 kg"

func _on_umbriel_pressed():
	clean_viewport()
	emit_signal("object_changed", umbriel_scene)
	
	object_name.text = "umbriel"
	object_type.text = "satellite of uranus"
	object_radius.text = "585 km"
	object_distance.text = "266.00 km"
	object_mass.text = "1,27 × 1e21 kg"


func _on_triton_pressed():
	clean_viewport()
	emit_signal("object_changed", triton_scene)

	object_name.text = "triton"
	object_type.text = "satellite of neptune"
	object_radius.text = "1.353 km"
	object_distance.text = "354.760 km"
	object_mass.text = "2,14 × 1e22 kg"


func _on_charon_pressed():
	clean_viewport()
	emit_signal("object_changed", charon_scene)
	
	object_name.text = "charon"
	object_type.text = "satellite of pluto"
	object_radius.text = "606 km"
	object_distance.text = "19.640 km"
	object_mass.text = "1,59 × 1e21 kg"


func _on_callisto_pressed():
	clean_viewport()
	emit_signal("object_changed", callisto_scene)
	
	object_name.text = "callisto"
	object_type.text = "satellite of jupiter"
	object_radius.text = "2.410 km"
	object_distance.text = "1.882.700 km"
	object_mass.text = "1,08 × 1e23 kg"


func _on_europa_pressed():
	clean_viewport()
	emit_signal("object_changed", europa_scene)
	
	object_name.text = "europa"
	object_type.text = "satellite of jupiter"
	object_radius.text = "1.561 km"
	object_distance.text = "670.900 km"
	object_mass.text = "4,80 × 1e22 kg"


func _on_ganymede_pressed():
	clean_viewport()
	emit_signal("object_changed", ganymede_scene)
	
	object_name.text = "ganymede"
	object_type.text = "satellite of jupiter"
	object_radius.text = "2.631 km"
	object_distance.text = "1.070.400 km"
	object_mass.text = "1,48 × 1e23 kg"


func _on_io_pressed():
	clean_viewport()
	emit_signal("object_changed", io_scene)
	
	object_name.text = "io"
	object_type.text = "satellite of jupiter"
	object_radius.text = "1.821 km"
	object_distance.text = "421.700 km"
	object_mass.text = "8,93 × 1e22 kg"


#go to planet star or satellite
func _on_go_pressed():
	Global.emit_signal("change_camera", target)


func _on_free_mode_pressed():
	Global.emit_signal("change_camera", space)


func create_asteroid():
	var visual_asteroid = asteroid_scene.instantiate()
	visual_asteroid.set_script(asteroid_idle)
	asteroid_viewport_son.add_child(visual_asteroid)
	
	var texture = visual_asteroid.get_node("visual")
	texture.layers = 1 << 8
	for o in texture.get_children():
		o.layers = 1 << 8
	return visual_asteroid
	
func delete_asteroid():
	# remove from viewport
	for son in asteroid_viewport_son.get_children():
		son.queue_free()
		
	# remove from the space
	Global.emit_signal("delete_asteroid")
	asteroid_target = null
	

func _on_open_close_asteroid_menu_pressed():
	if !asteroid_menu_open_close:
		$animation.play("open_close_asteroid_menu")
	else:
		$animation.play_backwards("open_close_asteroid_menu")
	asteroid_menu_open_close = !asteroid_menu_open_close
	

# controlla che la stringa sia un numero
func is_numeric(s):
	for c in s:
		if not c in "0123456789":
			return false
	return true
	
func _on_mass_text_changed(new_text):
	if is_numeric(new_text) and new_text != "":
		var number = int(new_text)
		controller_mass = true
		Global.emit_signal("change_mass", number)
	else:
		controller_mass = false


func _on_option_button_item_selected(index):
	Global.emit_signal("change_type", index)


func _on_velocity_text_changed(new_text):
	if is_numeric(new_text) and new_text != "":
		var number = float(new_text)
		number /= 1e6
		number *= 4
		controller_velocity = true
		Global.emit_signal("change_velocity", number)
	else:
		controller_velocity = false

func _on_throw_pressed():
	Global.emit_signal("throw_asteroid", asteroid_target)
	
	$create_body/mass.text = ""
	$create_body/velocity.text = ""
	$create_body/mass.editable = false
	$create_body/velocity.editable = false
	$create_body/material.disabled = true
	
	$create_body/go.disabled = false
	
	controller_mass = false
	controller_velocity = false
	

func _on_go_to_asteroid_pressed():
	Global.emit_signal("change_camera", asteroid_target)


func _on_create_delete_pressed():
	if asteroid_target == null:
		# attivale line text mass e velocity
		$create_body/mass.editable = true
		$create_body/velocity.editable = true
		$create_body/material.disabled = false
		
		# the visual asteroid
		var viewport_asteroid = create_asteroid()
		var origin_cam = viewport_asteroid.get_node("cam")
		asteroid_camera.global_transform.origin = origin_cam.global_transform.origin
		
		var viewport_texture = asteroid_viewport.get_texture()
		asteroid_screen.texture = viewport_texture
		
		#the real asteroid
		asteroid_target = asteroid_scene.instantiate()
		asteroid_target.visible = false # lo rende invisibile per non vederlo prima di lanciarlo
		Global.emit_signal("instantiate_asteroid", asteroid_target)
		$create_body/create_delete.text = "DELETE"
	else:
		delete_asteroid()
		controller_mass = false
		controller_velocity = false
		
		$create_body/create_delete.text = "CREATE"
		
		$create_body/mass.text = ""
		$create_body/velocity.text = ""
		$create_body/mass.editable = false
		$create_body/velocity.editable = false
		
		$create_body/material.selected = 0
		$create_body/material.disabled = true
		
		$create_body/go.disabled = true
		
		Global.emit_signal("change_camera", space)
