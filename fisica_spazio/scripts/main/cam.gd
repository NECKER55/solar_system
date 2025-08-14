extends Camera3D

signal throw(asteroid)

@export var space : Node3D
@export var target : Node3D

var full_power = true

var sensitivity = 0.1
var vertical_limit = 90
var right_mouse_pressed = false
var middle_mouse_pressed = false
var movement_speed = 0.05


var rotation_speed: float = 0.01  # Velocità di rotazione

var zoom_speed: float = 1.0          # Velocità dello zoom
var min_distance: float        # Distanza minima
var max_distance: float       # Distanza massima

var distance: float = 10.0
var is_rotating: bool = false
var horizontal_angle: float = 0.0  # Angolo orizzontale (radianti)
var vertical_angle: float = 0.0  # Angolo verticale (in radianti)

func _ready():
	Global.connect("change_camera", Callable(self, "_on_change_camera"))
	Global.connect("instantiate_asteroid", Callable(self, "_on_instantiate_asteroid"))
	Global.connect("throw_asteroid", Callable(self, "_on_throw_asteroid"))
	Global.connect("delete_asteroid", Callable(self, "_on_delete_asteroid"))
	Global.principal_cam = self
	
	target = space

func _process(delta):
	
	if target == space:
		full_power = true
	else:
		full_power = false
		min_distance = target.texture.scale.x + 1
		max_distance = target.texture.scale.x + 16
	
	if full_power:
		if right_mouse_pressed:
			var movement = Vector3()
			if Input.is_action_pressed("ui_up"):
				movement -= self.transform.basis.z
			if Input.is_action_pressed("ui_down"):
				movement += self.transform.basis.z
			if Input.is_action_pressed("ui_left"):
				movement -= self.transform.basis.x
			if Input.is_action_pressed("ui_right"):
				movement += self.transform.basis.x
			self.global_translate(movement * movement_speed)
	
	
	Global.set_global_variable("cam_pos", self.global_transform.origin) # per vedere la pos in cui siamo


func _input(event):
	
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_UP:
			Global.TIME_SCALE += 1  
		elif event.pressed and event.keycode == KEY_DOWN:
			if Global.TIME_SCALE > 1:
				Global.TIME_SCALE -= 1 
				
	if event is InputEventMouseButton:
		# Controllo pressione tasto rotellina
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			middle_mouse_pressed = event.pressed
		# Controllo tasto destro per movimento o rotazione
		if event.button_index == MOUSE_BUTTON_RIGHT:
			right_mouse_pressed = event.pressed

	# Rotazione solo se la rotellina è premuta
	if event is InputEventMouseMotion and (middle_mouse_pressed or right_mouse_pressed):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Blocca il mouse al centro
		var mouse_movement = event.relative
		self.rotate_y(-deg_to_rad(mouse_movement.x * sensitivity))
		self.rotation_degrees.x -= mouse_movement.y * sensitivity
		self.rotation_degrees.x = clamp(self.rotation_degrees.x, -vertical_limit, vertical_limit)
	elif not (middle_mouse_pressed or right_mouse_pressed):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Mostra il cursore solo se nessun tasto è premuto

	# aumento/diminuzione velocità movimento
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if movement_speed < 8:
				movement_speed += 0.03  # Incrementa la velocità
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			movement_speed = max(0.01, movement_speed - 0.03)  # Decrementa la velocità, ma non sotto 0.01

	if !full_power:
		if event is InputEventMouseButton:
			# Rileva se la rotella del mouse è premuta
			if event.button_index == MOUSE_BUTTON_MIDDLE:
				is_rotating = event.pressed  # Attiva o disattiva la rotazione

	# Zoom con la rotellina del mouse
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				distance = clamp(distance - zoom_speed, min_distance, max_distance)  # Zoom in
				update_camera_position()
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				distance = clamp(distance + zoom_speed, min_distance, max_distance)   # Zoom out
				update_camera_position()
		
		
		if event is InputEventMouseMotion and is_rotating:
			# Movimento orizzontale (sinistra/destra)
			horizontal_angle -= event.relative.x * rotation_speed 
			
			# Aggiorna l'angolo verticale in base al movimento del mouse
			vertical_angle -= event.relative.y * rotation_speed
			vertical_angle = clamp(vertical_angle, -PI / 2 + 0.1, PI / 2 - 0.1)  # Limita l'angolo verticale
			update_camera_position()

func update_camera_position():
	# Calcola la nuova posizione della telecamera
	var new_position = Vector3(
		distance * cos(vertical_angle) * sin(horizontal_angle),  # X
		distance * sin(vertical_angle),                          # Y
		distance * cos(vertical_angle) * cos(horizontal_angle)   # Z
		)

	# Imposta la posizione della telecamera
	global_transform.origin = target.global_transform.origin + new_position

	# Fai in modo che la telecamera guardi sempre il pianeta
	look_at(target.global_transform.origin, Vector3.UP)
	
	
func _on_change_camera(object):
	for obj in space.celestialBodies:
		if obj.name == object.name:
			target = obj
		
	
	if object == space:
		target = space
	else:
		self.global_transform.origin = target.cam.global_transform.origin
	self.reparent(target)

func _on_instantiate_asteroid(asteroid):
	self.add_child(asteroid)

func _on_throw_asteroid(asteroid):
	for a in self.get_children():
		a.visible = true
		a.reparent(space)
		emit_signal("throw", a)

func _on_delete_asteroid():
	if self.get_child_count() > 0:
		for son in self.get_children():
			son.queue_free()
