extends Control

var gameData = {}
var jsonFilePath = "res://resources/game.json"

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	gameData = read_json(jsonFilePath)
	assignValues()

func assignValues():
	%GameLabel1.text = gameData["game1"][0]["gameName"]
	%GameTexture1.texture = load(gameData["game1"][0]["gameImg"])


func _on_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))


func read_json(filePath : String):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedRes = JSON.parse_string(dataFile.get_as_text())
		
		if parsedRes is Dictionary:
			return parsedRes
		else:
			print("Can't read file")
	
	else:
		print("Doesn't exist")
