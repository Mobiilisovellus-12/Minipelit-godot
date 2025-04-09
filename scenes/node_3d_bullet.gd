extends Node3D

const speed = 40.0

@onready var bullet_mesh = $MeshInstance3D
@onready var bullet_ray = $RayCast3D
@onready var particles = $GPUParticles3D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -speed) * delta
	if bullet_ray.is_colliding():
		bullet_mesh.visible = false
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free() # Remove bullet
		
func _on_timer_timeout():
	queue_free()
