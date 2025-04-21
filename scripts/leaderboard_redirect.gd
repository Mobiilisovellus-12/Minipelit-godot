extends Node

const button_theme = preload("res://themes/button_theme.tres")

static func redirect_to_leaderboard(target_scene: Node, leaderboard_path):
	var leaderboard_button = Button.new()
	leaderboard_button.text = "🏆"
	leaderboard_button.theme = button_theme
	leaderboard_button.custom_minimum_size = Vector2(120, 50)
	
	leaderboard_button.anchor_left = 1
	leaderboard_button.anchor_top = 0
	leaderboard_button.anchor_right = 1
	leaderboard_button.anchor_bottom = 0
	
	var offset = Vector2(20, 20)
	leaderboard_button.offset_left = -offset.x - leaderboard_button.custom_minimum_size.x
	leaderboard_button.offset_top = offset.y
	leaderboard_button.offset_right = -offset.x
	leaderboard_button.offset_bottom = offset.y + leaderboard_button.custom_minimum_size.y
	
	leaderboard_button.z_index = 100
	
	leaderboard_button.pressed.connect(func():
		target_scene.get_tree().change_scene_to_file(leaderboard_path)
	)
	
	target_scene.add_child(leaderboard_button)
