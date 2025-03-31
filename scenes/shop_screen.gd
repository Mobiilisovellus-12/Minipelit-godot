extends Control

func _ready():
	# Setting the scene size to screen size
	get_viewport().size = DisplayServer.screen_get_size()
	
func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))
