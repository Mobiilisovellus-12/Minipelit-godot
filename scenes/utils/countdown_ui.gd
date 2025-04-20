extends Control

@export var countdown = 3

signal countdown_over

#For testing the screen
#func _ready():
#	start_countdown()

func start_countdown():
	$CountdownLabel.text = str(countdown)
	$CountdownLabel.show()
	$CountdownTimer.start()

func _on_countdown_timer_timeout():
	countdown -= 1
	if countdown > 0:
		$CountdownLabel.text = str(countdown)
		$CountdownTimer.start()
	elif countdown == 0:
		$CountdownLabel.text = "GO!"
		$CountdownTimer.start()
	else:
		$CountdownLabel.hide()
		emit_signal("countdown_over")
