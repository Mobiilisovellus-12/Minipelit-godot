extends RigidBody3D

signal got_hit(target)

func _ready():
	add_to_group("discs")

func is_shot():
	#Code for maybe animation or other handling
	#For now just free the object from memory
	
	print("Disc hit!")
	
	emit_signal("got_hit",self)
	
	queue_free()
