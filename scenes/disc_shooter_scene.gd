extends Node3D

@export var disc_scene : PackedScene = preload("res://scenes/disc_scene.tscn")
@export var shoot_force : float = 25.0
@export var shoot_angle : float = 45.0
@export var shoot_direction : Vector3 = Vector3.LEFT

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
	
	var position_offset = shoot_direction.normalized() * 2
	disc_instance.transform.origin = global_transform.origin + position_offset
	
	print("Disc position: ", disc_instance.transform.origin)
	
	get_tree().root.add_child(disc_instance)
	
	var angle_radians = deg_to_rad(shoot_angle)
	var launch_velocity = shoot_direction.normalized() * shoot_force
	launch_velocity.y = launch_velocity.y + shoot_force * sin(angle_radians)
	
	disc_instance.apply_impulse(launch_velocity, disc_instance.transform.origin)
