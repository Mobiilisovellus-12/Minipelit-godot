extends CharacterBody3D

# ATTENTION! The code related to accelerotmeter and mouse movement is outdated!
# I'm not sure if they work correctly.

var mouse_sensitivity = 0.001

@export var rotation_speed: float = 0.8
@export var camera_max_x: float = 30.0  # Max up/down angle
@export var camera_min_x: float = -30.0 # Min up/down angle
@export var camera_max_y: float = 45.0  # Max left/right angle
@export var camera_min_y: float = -45.0 # Min left/right angle

@onready var camera = $Camera3D
#@onready var collision_ball = $Camera3D/MeshInstance3D

var use_motion_controls: bool = false
var use_gyro: bool = false
var use_mouse: bool = false
var gyro_reference = Basis.IDENTITY
var current_rotation = Basis.IDENTITY
var accel_reference = Basis.IDENTITY

func _ready():
	var motion_control_button = $ActivateGyro
	motion_control_button.motion_control_toggled.connect(_on_motion_control_toggled)
	
	var recalibrate_button = $ActivateGyro/MarginContainer/VBoxContainer/HBoxContainer2/Button
	recalibrate_button.pressed.connect(_recalibrate_motion)
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED # Lock mouse for PC

func _on_motion_control_toggled(enabled: bool):
	use_motion_controls = enabled
	print("Motion controls:", "ENABlED" if use_motion_controls else "DISABLED")
	if Input.get_gyroscope():
		use_gyro = true
		print("Gyroscope detected; Enabling...")

func _recalibrate_motion():
	if use_gyro:
		gyro_reference = current_rotation.inverse()
		print("Recalibrated Gyroscope:", gyro_reference)
	else:
		accel_reference = Basis.from_euler((Input.get_accelerometer()))
		print("Recalibrated Accelerometer:", accel_reference.get_euler())

func _input(event):
	if event is InputEventMouseMotion:
		use_mouse = true
	elif event is InputEventScreenTouch:
		use_mouse = false
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(delta):
	if use_mouse:
		var mouse_delta = Input.get_last_mouse_screen_velocity()
		rotation_degrees.y -= mouse_delta.x * mouse_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x - mouse_delta.y * mouse_sensitivity, camera_min_x, camera_max_x)
		rotation_degrees.y = clamp(rotation_degrees.y, camera_min_y, camera_max_y)  # Clamp horizontal movement
	elif use_motion_controls:
		if use_gyro:
			var raw_gyro = Input.get_gyroscope()
			
			var adjusted_gyro = Vector3(
				raw_gyro.x,
				-raw_gyro.y,
				raw_gyro.z
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
