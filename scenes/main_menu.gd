extends Control

func _ready():
	# Setting the scene size to screen size
	get_viewport().size = DisplayServer.screen_get_size()

func _on_games_button_pressed():
	# Loading a scene
	get_tree().change_scene_to_packed(load("res://scenes/game_select.tscn"))


func _on_settings_button_pressed():
	# Loading a scene
	get_tree().change_scene_to_packed(load("res://scenes/settings.tscn"))


func _on_profile_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/profile.tscn"))
