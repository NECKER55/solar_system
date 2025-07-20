extends Node3D

# l'asteroide come nodo figlio di space
var asteroid : Node

var interface_scene = load("res://scenes/main/interface.tscn")
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


@export var celestialBodies = []


# Costante gravitazionale scalata (G * 10^12 per compensare 1m = 1000km, dividere per 10^3 per compensare 1kg = 1000kg)
const G = 6.6743e-11


var n = 5

func _ready():
	Global.connect("delete_asteroid", Callable(self, "_on_delete_asteroid"))
	
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
	
	var interface = interface_scene.instantiate()
	get_node("/root/space").add_child(interface)

	var mercury = mercury_scene.instantiate()
	get_node("/root/space").add_child(mercury)
	registerBody(mercury)
	#
	#var venus = venus_scene.instantiate()
	#get_node("/root/space").add_child(venus)
	#registerBody(venus)
	#
	#var earth = earth_scene.instantiate()
	#get_node("/root/space").add_child(earth)
	#registerBody(earth)
	##print("e ", earth.global_transform.origin)
	#
	#var mars = mars_scene.instantiate()
	#get_node("/root/space").add_child(mars)
	#registerBody(mars)
	#
	#var jupiter = jupiter_scene.instantiate()
	#get_node("/root/space").add_child(jupiter)
	#registerBody(jupiter)
	#
#
	#
	#
	#var saturn = saturn_scene.instantiate()
	#get_node("/root/space").add_child(saturn)
	#registerBody(saturn)
	#
	#var uranus = uranus_scene.instantiate()
	#get_node("/root/space").add_child(uranus)
	#registerBody(uranus)
	#
	#var neptune = neptune_scene.instantiate()
	#get_node("/root/space").add_child(neptune)
	#registerBody(neptune)
	#
	#var pluto_charonSystem = pluto_charonSystem_scene.instantiate()
	#get_node("/root/space").add_child(pluto_charonSystem)
	#
	#var pluto = pluto_scene.instantiate()
	#get_node("/root/space").add_child(pluto)
	#registerBody(pluto)
	#
	#var charon = charon_scene.instantiate()
	#get_node("/root/space").add_child(charon)
	#registerBody(charon)
	#
	#var moon = moon_scene.instantiate()
	#get_node("/root/space").add_child(moon)
	#registerBody(moon)
	#
	#
	var sun = sun_scene.instantiate()
	get_node("/root/space").add_child(sun)
	registerBody(sun)
	#
#
#
	#var io = io_scene.instantiate()
	#get_node("/root/space").add_child(io)
	#registerBody(io)
#
	#var europa = europa_scene.instantiate()
	#get_node("/root/space").add_child(europa)
	#registerBody(europa)
#
	#var ganymede = ganymede_scene.instantiate()
	#get_node("/root/space").add_child(ganymede)
	#registerBody(ganymede)
#
	#var callisto = callisto_scene.instantiate()
	#get_node("/root/space").add_child(callisto)
	#registerBody(callisto)
	#
	#
	#
	#var titan = titan_scene.instantiate()
	#get_node("/root/space").add_child(titan)
	#registerBody(titan)
	#
	#var enceladus = enceladus_scene.instantiate()
	#get_node("/root/space").add_child(enceladus)
	#registerBody(enceladus)
	#
	#var iapetus = iapetus_scene.instantiate()
	#get_node("/root/space").add_child(iapetus)
	#registerBody(iapetus)
	#
	#var rhea = rhea_scene.instantiate()
	#get_node("/root/space").add_child(rhea)
	#registerBody(rhea)
	#
	#var mimas = mimas_scene.instantiate()
	#get_node("/root/space").add_child(mimas)
	#registerBody(mimas)
	#
	#var dione = dione_scene.instantiate()
	#get_node("/root/space").add_child(dione)
	#registerBody(dione)
	#
	#var triton = triton_scene.instantiate()
	#get_node("/root/space").add_child(triton)
	#registerBody(triton)
	#
	#
	#var titania = titania_scene.instantiate()
	#get_node("/root/space").add_child(titania)
	#registerBody(titania)
#
	#var oberon = oberon_scene.instantiate()
	#get_node("/root/space").add_child(oberon)
	#registerBody(oberon)
	#
	#var ariel = ariel_scene.instantiate()
	#get_node("/root/space").add_child(ariel)
	#registerBody(ariel)
	#
	#var umbriel = umbriel_scene.instantiate()
	#get_node("/root/space").add_child(umbriel)
	#registerBody(umbriel)
	#
	#var miranda = miranda_scene.instantiate()
	#get_node("/root/space").add_child(miranda)
	#registerBody(miranda)
	
	
func _on_delete_asteroid():
	for son in self.get_children():
		if son == asteroid:
			son.queue_free()
			celestialBodies.erase(asteroid)
			asteroid = null

func registerBody(body : Node):
	celestialBodies.append(body)

func getBodies():
	return celestialBodies
	
func getGConst():
	return G


func _process(delta):
	print(asteroid)
	if asteroid:
		var force = calculate_gravity_force()
		var intensity = force.length()
		var direction = force / intensity
		#print(intensity, "  ", direction)
		Global.emit_signal("change_gravity_force", force)


func calculate_gravity_force():
	var force = Vector3.ZERO
	for body in celestialBodies:
		if body != asteroid:
			force += calculate_single_force(asteroid, body)
	return force

func calculate_single_force(asteroid, body):
	var distance = calculate_distance(asteroid, body)
	var direction = asteroid.global_transform.origin.direction_to(body.global_transform.origin) #(body.global_transform.origin - asteroid.global_transform.origin)/distance non funziona perche scalo la distanza
	var intensity = G * ((asteroid.mass * body.mass) / pow(distance,2))
	#print(asteroid.mass, "  ", body.mass)
	return direction * intensity

func calculate_distance(asteroid, body):
	var distance = asteroid.global_transform.origin.distance_to(body.global_transform.origin)
	distance *= 1e6
	distance /= 4
	
	distance *= 1000 #conversione in metri
	#print(distance)
	return distance

# assegna al riferimento il nodo asteroide
func _on_cam_throw(a):
	asteroid = a
	registerBody(a)
