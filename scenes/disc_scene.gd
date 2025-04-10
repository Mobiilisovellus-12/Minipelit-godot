extends RigidBody3D

func _ready():
	add_to_group("discs")

func is_shot():
	#Code for maybe animation or other handling
	#For now just free the object from memory
	queue_free()
