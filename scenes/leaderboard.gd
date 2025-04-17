extends Control

const function = preload("res://scripts/get_leaderboard.gd")
const back_button_theme = preload("res://themes/back_button_theme.tres")

func _ready():
	function.read_and_sort_leaderboard(%VBoxContainer)

func _add_ui():
	%Button.theme = back_button_theme
