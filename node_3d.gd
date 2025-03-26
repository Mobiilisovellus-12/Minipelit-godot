extends Node3D

func _ready():
	# Set the screen orientation to landscape
	DisplayServer.set_screen_orientation(DisplayServer.SCREEN_ORIENTATION_LANDSCAPE)
	
	# Optionally, set the window size (e.g., 1920x1080 for landscape)
	OS.set_window_size(Vector2(1920, 1080))
	
	print("Orientation changed to landscape and resolution set to 1920x1080.")

	Window.unresizable()
	get_viewport().get_window()
	
