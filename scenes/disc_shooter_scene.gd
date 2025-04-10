extends Node3D

@export var disc_scene : PackedScene = preload("res://scenes/disc_scene.tscn")
@export var shoot_force : float = 25.0
@export var shoot_angle : float = 100.0

var shoot_timer : Timer

func _ready():
	shoot_timer = $Timer
	shoot_timer.timeout.connect(_on_ShootTimer_timeout)
	shoot_timer.start()

func _on_ShootTimer_timeout():
	shoot_disc()


func shoot_disc():
	print("Disc shot!")
	var disc_instance = disc_scene.instantiate()
	
	var forward_direction = -global_transform.basis.z.normalized()  # Forward is -Z
	var position_offset = forward_direction * 2
	disc_instance.global_transform.origin = global_transform.origin + position_offset
	
	get_parent().add_child(disc_instance)
	
	var angle_radians = deg_to_rad(shoot_angle)
	var launch_velocity = forward_direction * shoot_force
	launch_velocity.y += shoot_force * sin(angle_radians) * randf_range(0.5,1.0)
	
	disc_instance.apply_impulse(launch_velocity, disc_instance.transform.origin)
