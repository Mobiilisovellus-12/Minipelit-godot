extends Control

signal pause_button_pressed

func _on_pause_button_pressed():
	print("Pause button pressed")
	emit_signal("pause_button_pressed")
