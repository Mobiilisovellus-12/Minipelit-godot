extends Node

const button_theme = preload("res://themes/button_theme.tres")

#goes trough a json file
static func read_json(filePath : String):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedRes = JSON.parse_string(dataFile.get_as_text())
		
		if parsedRes is Dictionary:
			return parsedRes
		else:
			print("Can't read file")
	
	else:
		print("Doesn't exist")


#creates a button that redirects you to the shop
static func redirect_to_shop(target_scene: Node, shop_path):
	var shop_button = Button.new()
	shop_button.text = "🛒 Shop"
	shop_button.theme = button_theme
	shop_button.custom_minimum_size = Vector2(120, 50)
	
	shop_button.anchor_left = 0
	shop_button.anchor_top = 0
	shop_button.anchor_right = 0
	shop_button.anchor_bottom = 0
	
	var offset = Vector2(20, 20)
	shop_button.offset_left = offset.x
	shop_button.offset_top = offset.y
	shop_button.offset_right = offset.x + shop_button.custom_minimum_size.x
	shop_button.offset_bottom = offset.y + shop_button.custom_minimum_size.y
	
	shop_button.z_index = 100
	
	shop_button.pressed.connect(func():
		target_scene.get_tree().change_scene_to_file(shop_path)
	)
	
	target_scene.add_child(shop_button)

#creates a button that redirects you to the leaderboard
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
