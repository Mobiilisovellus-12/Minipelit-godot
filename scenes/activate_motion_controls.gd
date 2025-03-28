extends Control

signal motion_control_toggled(enabled: bool)
signal recalibrate_requested

@onready var motion_control_button = $MarginContainer/VBoxContainer/HBoxContainer/CheckButton
@onready var recalibrate_button = $MarginContainer/VBoxContainer/HBoxContainer2/Button

func _ready():
	motion_control_button.toggled.connect(_on_motion_control_toggled)
	recalibrate_button.pressed.connect(_on_recalibrate_pressed)

func _on_motion_control_toggled(button_pressed: bool):
	motion_control_toggled.emit(button_pressed)

func _on_recalibrate_pressed():
	print("Recalibrate button pressed!")
	recalibrate_requested.emit()
