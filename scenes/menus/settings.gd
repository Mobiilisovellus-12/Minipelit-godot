extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func _on_back_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/menus/main_menu.tscn"))
