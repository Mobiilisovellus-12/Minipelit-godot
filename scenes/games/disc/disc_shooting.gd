extends Node3D

var game_started = false

var timer1: Timer
var timer2: Timer

@onready var start_screen = $CanvasLayer/BeforeGame
@onready var game_objects = $GameEnvironment/GameObjects
@onready var crosshair = $joystick_ui/CanvasLayer/TextureRect
@onready var pause_button = $CanvasLayer/PauseButtonScene
@onready var pause_screen = $CanvasLayer/InGamePause
@onready var countdown_ui = $CanvasLayer/CountdownUI
@onready var test_ui = $GameEnvironment/GameObjects/DiscShootingPlayer/ActivateGyro
@onready var joystick_ui = $GameEnvironment/GameObjects/DiscShootingPlayer/joystick_ui/CanvasLayer
@onready var virtual_joystick = $"CanvasLayer/Virtual Joystick"
@onready var disc_shooter_left = $GameEnvironment/GameObjects/DiscShooter2
@onready var disc_shooter_right = $GameEnvironment/GameObjects/DiscShooter

func _ready():
	ScoreManager.set_game("game1")
	ScoreManager.load_game_data()
	
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
	get_viewport().size = DisplayServer.screen_get_size()
	
	before_game_start()
	
	start_screen.start_the_game.connect(_do_countdown)
	countdown_ui.countdown_over.connect(_start_game)
	pause_button.pause_button_pressed.connect(_pause_game)
	pause_screen.return_back_to_game.connect(_unpause_game)
	pause_screen.go_back_to_menu.connect(_quit_game_session)
	disc_shooter_left.disc_created.connect(_on_target_spawned)
	disc_shooter_right.disc_created.connect(_on_target_spawned)
	

func toggle_game_ui_visibility():
	test_ui.visible = not test_ui.visible
	joystick_ui.visible = not joystick_ui.visible
	virtual_joystick.visible = not virtual_joystick.visible

func before_game_start():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	toggle_game_ui_visibility()
	game_objects.hide()
	game_objects.process_mode = Node.PROCESS_MODE_DISABLED
	start_screen.show()

func _start_game():
	game_objects.show()
	game_objects.process_mode = Node.PROCESS_MODE_INHERIT
	pause_button.show()
	toggle_game_ui_visibility()
	
	#crosshair.position.x = get_viewport().size.x / 2 - 64
	#crosshair.position.y = get_viewport().size.y / 2 - 64
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	create_timers()
	
	game_started = true

func _pause_game():
	game_objects.process_mode = Node.PROCESS_MODE_DISABLED
	virtual_joystick.process_mode = Node.PROCESS_MODE_DISABLED
	pause_screen.show()

func _unpause_game():
	game_objects.process_mode = Node.PROCESS_MODE_INHERIT
	virtual_joystick.process_mode = Node.PROCESS_MODE_INHERIT
	pause_screen.hide()

func _quit_game_session():
	ScoreManager.check_highscore()
	get_tree().change_scene_to_packed(load("res://scenes/menus/game_select.tscn"))

func _do_countdown():
	start_screen.hide()
	start_screen.queue_free()
	countdown_ui.show()
	countdown_ui.start_countdown()

func _on_target_spawned(target: Node):
	target.got_hit.connect(Callable(self, "_on_target_shot"))

func _on_target_shot(target):
	print("Target destroyed:", target.name)
	ScoreManager.add_score(1)

func create_left_disc():
	disc_shooter_left.shoot_disc()

func create_right_disc():
	disc_shooter_right.shoot_disc()

func create_timers():
	randomize()
	
	timer1 = Timer.new()
	timer1.wait_time = randf_range(6.0, 10.0)
	timer1.one_shot = false
	timer1.autostart = true
	add_child(timer1)
	timer1.timeout.connect(_on_timer1_timeout)
	
	timer2 = Timer.new()
	timer2.wait_time = randf_range(13.0, 22.0)
	timer2.one_shot = false
	timer2.autostart = true
	add_child(timer2)
	timer2.timeout.connect(_on_timer2_timeout)

func _on_timer1_timeout():
	create_left_disc()
	timer1.wait_time = randf_range(6.0, 10.0)
	timer1.start()

func _on_timer2_timeout():
	create_right_disc()
	timer2.wait_time = randf_range(13.0, 22.0)
	timer2.start()
