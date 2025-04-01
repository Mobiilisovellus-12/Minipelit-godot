extends Control

var gameData = {}
var jsonFilePath = "res://resources/game.json"

const jsonUtils = preload("res://scripts/read_json.gd")

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	gameData = jsonUtils.read_json(jsonFilePath)
	generate_ui()


func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))


func _on_play_button_pressed(path):
	get_tree().change_scene_to_packed(load(path))


func generate_ui():
	var scontainer = $ColorRect/ScrollContainer/VBoxContainer
	
	for item in gameData.keys():
		for i in range (gameData[item].size()):
			var game_entry = gameData[item][i]
	
			var game_label = Label.new()
			game_label.text = game_entry.get("gameName")
			
			var game_texture = TextureRect.new()
			game_texture.texture = load(game_entry.get("gameImg"))
			game_texture.custom_minimum_size = Vector2(200, 200)
			
			var scene_path = game_entry.get("scenePath")
			
			var play_button = Button.new()
			play_button.text = "PLAY"
			#add path
			
			scontainer.add_child(game_label)
			scontainer.add_child(game_texture)
			scontainer.add_child(play_button)
