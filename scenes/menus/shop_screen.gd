extends Control

var shopData = {}
var jsonFilePath = "res://resources/shop.json"

const jsonUtils = preload("res://scripts/read_json.gd")
const button_theme = preload("res://themes/button_theme.tres")
const back_button_theme = preload("res://themes/back_button_theme.tres")

func _ready():
	# Setting the scene size to screen size
	get_viewport().size = DisplayServer.screen_get_size()
	shopData = jsonUtils.read_json(jsonFilePath)
	generate_ui()
	
func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/menus/main_menu.tscn"))
	
func generate_ui():
	var scontainer = $ColorRect/ScrollContainer/VBoxContainer

	for item in shopData.keys():
		for i in range(shopData[item].size()):
			var shop_entry = shopData[item][i]
			
			var shop_image = TextureRect.new()
			shop_image.texture = load(shop_entry.get("itemImg"))
			shop_image.expand = true
			shop_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			shop_image.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			shop_image.size_flags_stretch_ratio = 1
			shop_image.custom_minimum_size = Vector2(0, 150)

			var shop_label = Label.new()
			shop_label.text = shop_entry.get("itemName", "Unnamed Item")
			shop_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			shop_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			shop_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			shop_label.add_theme_font_size_override("font_size", 30)

			var shop_price = Label.new()
			shop_price.text = str(shop_entry.get("itemPrice", "0"))
			shop_price.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			shop_price.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			shop_price.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			shop_price.add_theme_font_size_override("font_size", 25)

			var shop_pay_button = Button.new()
			shop_pay_button.text = "Pay"
			shop_pay_button.theme = button_theme
			shop_pay_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			shop_pay_button.custom_minimum_size = Vector2(0, 40)

			var spacer = Control.new()
			spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL

			var right_box = VBoxContainer.new()
			right_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			right_box.size_flags_stretch_ratio = 1
			right_box.add_child(shop_label)
			right_box.add_child(shop_price)
			right_box.add_child(spacer)
			right_box.add_child(shop_pay_button)

			var hbox = HBoxContainer.new()
			hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			hbox.add_child(shop_image)
			hbox.add_child(right_box)

			var row_spacer = Control.new()
			row_spacer.custom_minimum_size = Vector2(0, 20)

			scontainer.add_child(hbox)
			scontainer.add_child(row_spacer)
