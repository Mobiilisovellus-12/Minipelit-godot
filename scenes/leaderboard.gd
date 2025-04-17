extends Control

const function = preload("res://scripts/get_leaderboard.gd")
const back_button_theme = preload("res://themes/back_button_theme.tres")

func _ready():
	function.read_and_sort_leaderboard($ColorRect/ScrollContainer/VBoxContainer)
	_add_ui()

func _add_ui():
	%Button.theme = back_button_theme

func to_main_menu():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))
