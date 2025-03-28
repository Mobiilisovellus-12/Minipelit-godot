extends Control

@onready var game_timer = $CanvasLayer/Timer
@onready var timer_label = $CanvasLayer/Timer_label
var time : float = 0.0

func _ready():
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_LANDSCAPE)
	get_viewport().size = DisplayServer.screen_get_size()
	
	game_timer.start()
	timer_label.text = "00:00"
	
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
