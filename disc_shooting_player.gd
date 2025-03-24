extends CharacterBody3D

var mouse_sensitivity = 0.01

@onready var camera = $Camera3D
@onready var collision_ball = $Camera3D/MeshInstance3D

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
