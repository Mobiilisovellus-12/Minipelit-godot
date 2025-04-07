extends Control

var gameData = {}
var jsonFilePath = "res://resources/game.json"

const jsonUtils = preload("res://scripts/read_json.gd")
const button_theme = preload("res://themes/button_theme.tres")
const back_button_theme = preload("res://themes/back_button_theme.tres")


#main
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	_add_ui_theme()
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


#function generates the UI for the scene based on the json data you choose to use
func generate_ui():
	var scontainer = $ColorRect/ScrollContainer/VBoxContainer
	
	#loops trough the json
	for item in gameData.keys():
		for i in range (gameData[item].size()):
			var game_entry = gameData[item][i]
			
			#creates the games name/label
			var game_label = Label.new()
			game_label.text = game_entry.get("gameName")
			game_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			game_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			game_label.add_theme_font_size_override("font_size", 50)
			
			#creates the games img
			var game_texture = TextureRect.new()
			game_texture.texture = load(game_entry.get("gameImg"))
			#game_texture.expand_mode = TextureRect.STRETCH_SCALE
			#game_texture.size = Vector2(100, 100)
			
			#creates the path to the pre-game scene
			var scene_path = game_entry.get("scenePath")
			
			#creates the play button (redirects to pre-game scene)
			var play_button = Button.new()
			play_button.text = "PLAY"
			play_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			play_button.custom_minimum_size = Vector2(0, 50)
			play_button.theme = button_theme
			play_button.add_theme_font_size_override("font_size", 50)
			play_button.pressed.connect(_on_play_button_pressed.bind(scene_path))
			
			var spacer = Control.new()
			spacer.custom_minimum_size = Vector2(0, 100)
			
			#adds the ui components (label, texture, button) to the VBoxContainer
			var entry_container = VBoxContainer.new()
			#entry_container.alignment = BoxContainer.ALIGNMENT_CENTER
			#entry_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			entry_container.add_child(game_label)
			entry_container.add_child(game_texture)
			entry_container.add_child(play_button)
			
			scontainer.add_child(entry_container)
			scontainer.add_child(spacer)
