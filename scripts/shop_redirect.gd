extends Node

const button_theme = preload("res://themes/button_theme.tres")

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
