extends CharacterBody3D

# ATTENTION! The code related to accelerotmeter and mouse movement is outdated!
# I'm not sure if they work correctly.

var mouse_sensitivity = 0.001

@export var rotation_speed: float = 0.8
@export var camera_max_x: float = 30.0  # Max up/down angle
@export var camera_min_x: float = -10.0 # Min up/down angle
@export var camera_max_y: float = 30.0  # Max left/right angle
@export var camera_min_y: float = -30.0 # Min left/right angle

@onready var camera = $Camera3D
#@onready var collision_ball = $Camera3D/MeshInstance3D
@onready var shoot_animation = $Camera3D/Node3D_gun/MeshInstance3D_gun/AnimationPlayer


var bullet = load("res://scenes/node_3d_bullet.tscn")
var bullet_instance
var use_motion_controls: bool = false
var use_gyro: bool = false
var use_mouse: bool = false
var gyro_reference = Basis.IDENTITY
var current_rotation = Basis.IDENTITY
var accel_reference = Basis.IDENTITY

var shoot_input = "shoot" #shooting logic

@onready var joystick_left : VirtualJoystick = get_node("/root/DiscShooting/CanvasLayer/Virtual Joystick")

func _ready():
	var motion_control_button = $ActivateGyro
	motion_control_button.motion_control_toggled.connect(_on_motion_control_toggled)
	
	var recalibrate_button = $ActivateGyro/MarginContainer/VBoxContainer/HBoxContainer2/Button
	recalibrate_button.pressed.connect(_recalibrate_motion)

func _on_motion_control_toggled(enabled: bool):
	use_motion_controls = enabled
	print("Motion controls:", "ENABlED" if use_motion_controls else "DISABLED")
	if Input.get_gyroscope():
		use_gyro = true
		print("Gyroscope detected; Enabling...")

func _recalibrate_motion():
	if use_gyro:
		gyro_reference = current_rotation.orthonormalized()
		print("Recalibrated Gyroscope:", gyro_reference)
	else:
		accel_reference = Basis.from_euler((Input.get_accelerometer()))
		print("Recalibrated Accelerometer:", accel_reference.get_euler())

func shoot():
	var screen_center = get_viewport().get_visible_rect().size / 2
	
	var origin = camera.project_ray_origin(screen_center)
	var direction = camera.project_ray_normal(screen_center)
	
	var ray_length = 1000.0
	var query = PhysicsRayQueryParameters3D.new()
	query.from = origin
	query.to = origin + direction * ray_length
	query.exclude = [self]  # Optional
	query.collision_mask = 1  # Optional: adjust if you use layers
	
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query)
	
	if result:
		var target = result.collider
		if target and target.is_in_group("discs"):
			target.is_shot()

func _input(event):
	if event is InputEventMouseMotion:
		use_mouse = true
	elif event is InputEventScreenTouch:
		use_mouse = false
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
			#bullet_instance = bullet.instantiate()
			#bullet_instance.position = gun.global_position
			#bullet_instance.transform.basis = gun.global_transform.basis
			#get_parent().add_child(bullet_instance)
			

func _process(delta):
		# If joystick is being used, disable mouse controls.
	if joystick_left != null and joystick_left.is_pressed:
		# Access the joystick output vector
		var joystick_input = joystick_left.output
		var joystick_input_x = -joystick_input.x  # Horizontal (left-right)
		var joystick_input_y = -joystick_input.y  # Vertical (up-down)
		var rotation_speed_joystick : float = 80.0
	
		# Calculate yaw (rotation around Y-axis) and pitch (rotation around X-axis)
		var yaw_delta = joystick_input_x * rotation_speed_joystick * delta  # Horizontal (yaw)
		var pitch_delta = joystick_input_y * rotation_speed_joystick * delta  # Vertical (pitch)
		
		# Apply pitch rotation around the X-axis (vertical)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x + pitch_delta, camera_min_x, camera_max_x)
		# Apply yaw rotation around the Y-axis (horizontal)
		camera.rotation_degrees.y = clamp(camera.rotation_degrees.y + yaw_delta, camera_min_y, camera_max_y)
	elif use_mouse:
		var mouse_delta = Input.get_last_mouse_screen_velocity()
		rotation_degrees.y -= mouse_delta.x * mouse_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x - mouse_delta.y * mouse_sensitivity, camera_min_x, camera_max_x)
		rotation_degrees.y = clamp(rotation_degrees.y, camera_min_y, camera_max_y)  # Clamp horizontal movement
	elif use_motion_controls:
		if use_gyro:
			var raw_gyro = Input.get_gyroscope()
			
			var adjusted_gyro = Vector3(
				raw_gyro.x,
				raw_gyro.y,
				0.0
			)
			
			var delta_rotation = Basis.from_euler(adjusted_gyro * delta)
			
			current_rotation = delta_rotation * current_rotation
			
			var adjusted_rotation = gyro_reference * current_rotation
			
			var euler_rotation = adjusted_rotation.get_euler()
			
			rotation_degrees.y = clamp(rad_to_deg(euler_rotation.y), camera_min_y, camera_max_y)
			camera.rotation_degrees.x = clamp(rad_to_deg(euler_rotation.x), camera_min_x, camera_max_x)
		else:
			var accel_data: Vector3 = Input.get_accelerometer()
			var accel_tilt: Vector3 = Vector3(accel_data.y, accel_data.x, 0) * rotation_speed * delta
			
			rotation_degrees.y = clamp(rotation_degrees.y - accel_tilt.x, camera_min_y, camera_max_y)
			camera.rotation_degrees.x = clamp(camera.rotation_degrees.x + accel_tilt.y, camera_min_x, camera_max_x)
			
	##Movement using Input functions:
	#move_vector = Vector2.ZERO
	#move_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	#position += move_vector * speed * delta

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"): #shooting logic
		if !shoot_animation.is_playing():
			shoot_animation.play("shoot")
			shoot()
