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
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))
	
func generate_ui():
	var scontainer = $ColorRect/ScrollContainer/VBoxContainer
	
	for item in shopData.keys():
		for i in range (shopData[item].size()):
			var shop_entry = shopData[item][i]
			
			var shop_label = Label.new()
			shop_label.text = shop_entry.get("itemName")
			
			var shop_price = Label.new()
			shop_label.text = shop_entry.get("itemPrice")
			
			var shop_pay_button = Button.new()
			shop_pay_button.text = "Pay"
			shop_pay_button.theme = button_theme
			
			var spacer = Control.new()
			spacer.size = Vector2(0, 100)
			
			scontainer.add_child(shop_label)
			scontainer.add_child(shop_price)
			scontainer.add_child(shop_pay_button)
			scontainer.add_child(spacer)
