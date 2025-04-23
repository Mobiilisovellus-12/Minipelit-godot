extends Control

signal start_the_game

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func _on_begin_button_pressed():
	emit_signal("start_the_game")

func _on_back_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/menus/game_select.tscn"))
