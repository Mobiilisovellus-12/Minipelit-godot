extends Control

const shopUtils = preload("res://scripts/shop_redirect.gd")
const leaderboardUtils = preload("res://scripts/leaderboard_redirect.gd")
const shop_path = "res://scenes/menus/shop-screen.tscn"
const leaderboard_path = "res://scenes/menus/leaderboard.tscn"

func _ready():
	# Setting the scene size to screen size
	get_viewport().size = DisplayServer.screen_get_size()
	shopUtils.redirect_to_shop(self, shop_path)
	leaderboardUtils.redirect_to_leaderboard(self, leaderboard_path)

func _on_games_button_pressed():
	# Loading a scene
	get_tree().change_scene_to_packed(load("res://scenes/menus/game_select.tscn"))


func _on_settings_button_pressed():
	# Loading a scene
	get_tree().change_scene_to_packed(load("res://scenes/menus/settings.tscn"))


func _on_profile_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/menus/profile.tscn"))
