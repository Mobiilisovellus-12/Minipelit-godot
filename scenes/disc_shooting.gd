extends Node3D

@onready var crosshair = $joystick_ui/CanvasLayer/TextureRect

func _ready():
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
	get_viewport().size = DisplayServer.screen_get_size()
	crosshair.position.x = get_viewport().size.x / 2 - 64
	crosshair.position.y = get_viewport().size.y / 2 - 64
