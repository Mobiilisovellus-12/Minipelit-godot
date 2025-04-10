extends Node3D

@onready var start_screen = $CanvasLayer/BeforeGame
@onready var game_objects = $GameEnvironment/GameObjects
@onready var crosshair = $joystick_ui/CanvasLayer/TextureRect

var game_started = false

func _ready():
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
	get_viewport().size = DisplayServer.screen_get_size()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	toggle_game_ui_visibility()
	game_objects.visible = false
	game_objects.process_mode = Node.PROCESS_MODE_DISABLED
	start_screen.visible = true
	
	start_screen.start_the_game.connect(_start_game)

func toggle_game_ui_visibility():
	var test_ui = $GameEnvironment/GameObjects/DiscShootingPlayer/ActivateGyro
	var joystick_ui = $joystick_ui/CanvasLayer
	var virtual_joystick = $"CanvasLayer/Virtual Joystick"
	
	test_ui.visible = not test_ui.visible
	joystick_ui.visible = not joystick_ui.visible
	virtual_joystick.visible = not virtual_joystick.visible

func _start_game():
	start_screen.visible = false
	start_screen.queue_free()
	game_objects.visible = true
	game_objects.process_mode = Node.PROCESS_MODE_INHERIT
	toggle_game_ui_visibility()
	
	#crosshair.position.x = get_viewport().size.x / 2 - 64
	#crosshair.position.y = get_viewport().size.y / 2 - 64
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	game_started = true
