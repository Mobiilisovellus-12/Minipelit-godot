extends Control

@onready var game_timer = $CanvasLayer/Timer
@onready var timer_label = $CanvasLayer/Timer_label
@onready var score_label = $CanvasLayer/MarginContainer/VBoxContainer/Score
@onready var highscore_label = $CanvasLayer/MarginContainer/VBoxContainer/Highscore
@onready var shoot_button = $CanvasLayer/TextureButton
var time : float = 0.0


signal shoot_pressed

@export var normal_color: Color = Color(1, 1, 1)
@export var pressed_color: Color = Color(0.8, 0.8, 0.8)


func _ready():
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
	get_viewport().size = DisplayServer.screen_get_size()
	
	shoot_button.modulate = normal_color
	
	setup_score()
	
	game_timer.start()
	timer_label.text = "00:00"

func setup_score():
	ScoreManager.score_changed.connect(_on_score_changed)
	_on_score_changed(ScoreManager.score)
	ScoreManager.highscore_changed.connect(_on_highscore_changed)
	_on_highscore_changed(ScoreManager.get_current_high_score())

func _on_score_changed(new_score: int):
	score_label.text = "Score: %d" % new_score

func _on_highscore_changed(new_high: int):
	highscore_label.text = "Highscore: %d" % new_high

func _process(delta: float) -> void:
	time += delta
	timer_label.text = format_time(time)

# Helper function to format time into MM:SS format
func format_time(seconds: float) -> String:
	var minutes = int(seconds) / 60  # Get minutes
	var remaining_seconds = int(seconds) % 60  # Get remaining seconds

	# Format minutes and seconds with leading zeroes if necessary
	return str(minute_padding(minutes)) + ":" + str(seconds_padding(remaining_seconds))

# Helper function to add leading zero for minutes
func minute_padding(minutes: int) -> String:
	return "0" + str(minutes) if minutes < 10 else str(minutes)

# Helper function to add leading zero for seconds
func seconds_padding(seconds: int) -> String:
	return "0" + str(seconds) if seconds < 10 else str(seconds)


func _on_texture_button_pressed():
	shoot_button.modulate = pressed_color
	emit_signal("shoot_pressed")


func _on_texture_button_button_up():
	shoot_button.modulate = normal_color
