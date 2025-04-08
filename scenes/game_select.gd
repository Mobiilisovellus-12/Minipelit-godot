extends Control

var gameData = {}
var jsonFilePath = "res://resources/game.json"

const shop_path = "res://scenes/shop-screen.tscn"
const shopUtils = preload("res://scripts/shop_redirect.gd")

const jsonUtils = preload("res://scripts/read_json.gd")
const button_theme = preload("res://themes/button_theme.tres")
const back_button_theme = preload("res://themes/back_button_theme.tres")


#main
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	_add_ui_theme()
	shopUtils.redirect_to_shop(self, shop_path)
	gameData = jsonUtils.read_json(jsonFilePath)
	generate_ui()

func _add_ui_theme():
	%BackButton.theme = back_button_theme

#function redirects back to the main menu scene
func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))

func _to_shop():
	get_tree().change_scene_to_packed(load("res://scenes/shop-screen.tscn"))

#function redirects to desired scene
func _on_play_button_pressed(path):
	get_tree().change_scene_to_packed(load(path))


func generate_ui():
	var scontainer = $ColorRect/ScrollContainer/VBoxContainer
	
	for item in gameData.keys():
		for i in range(gameData[item].size()):
			var game_entry = gameData[item][i]

			var scene_path = game_entry.get("scenePath")

			var game_texture = TextureRect.new()
			game_texture.texture = load(game_entry.get("gameImg"))
			game_texture.expand = true
			game_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			game_texture.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			game_texture.size_flags_stretch_ratio = 1

			var game_label = Label.new()
			game_label.text = game_entry.get("gameName")
			game_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			game_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			game_label.add_theme_font_size_override("font_size", 40)

			var play_button = Button.new()
			play_button.text = "PLAY"
			play_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			play_button.custom_minimum_size = Vector2(0, 50)
			play_button.add_theme_font_size_override("font_size", 40)
			if button_theme:
				play_button.theme = button_theme
			play_button.pressed.connect(_on_play_button_pressed.bind(scene_path))

			var right_box = VBoxContainer.new()
			right_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			right_box.size_flags_stretch_ratio = 1

			var spacer = Control.new()
			spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL

			right_box.add_child(game_label)
			right_box.add_child(spacer)
			right_box.add_child(play_button)

			var hbox = HBoxContainer.new()
			hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			hbox.add_child(game_texture)
			hbox.add_child(right_box)

			var row_spacer = Control.new()
			row_spacer.custom_minimum_size = Vector2(0, 30)

			scontainer.add_child(hbox)
			scontainer.add_child(row_spacer)
