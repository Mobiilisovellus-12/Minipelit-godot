extends Node

var current_game_key: String = "game1"
var games_data: Dictionary = {}

var score: int = 0

signal score_changed(new_score: int)
signal highscore_changed(new_highscore: int)

const DEFAULT_PATH := "res://resources/default/save_template.json"
const SAVE_PATH := "user://saves/save.json"

func _ready():
	ensure_save_file_exists()
	load_game_data()

func set_game(game_key: String):
	current_game_key = game_key

func add_score(amount: int):
	score += amount
	score_changed.emit(score)

func reset_score():
	score = 0
	score_changed.emit(score)

func check_highscore():
	if score > get_current_high_score():
		var entry = games_data.get(current_game_key, [])[0]
		entry["highScore"] = score
		highscore_changed.emit(score)
		save_game_data()

func reset_highscore():
	var entry = games_data.get(current_game_key, [])[0]
	entry["highScore"] = 0
	highscore_changed.emit(0)
	save_game_data()

func get_current_high_score() -> int:
	if games_data.has(current_game_key) and games_data[current_game_key].size() > 0:
		return games_data[current_game_key][0].get("highScore", 0)
	return 0

func ensure_save_file_exists():
	if !FileAccess.file_exists(SAVE_PATH):
		if FileAccess.file_exists(DEFAULT_PATH):
			var default_file = FileAccess.open(DEFAULT_PATH, FileAccess.READ)
			var default_data = default_file.get_as_text()
			default_file.close()

			DirAccess.make_dir_recursive_absolute(SAVE_PATH.get_base_dir())
			var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
			save_file.store_string(default_data)
			save_file.close()
		else:
			push_error("Default save file missing at: %s" % DEFAULT_PATH)

func load_game_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()

			var result = JSON.parse_string(content)
			if result is Dictionary:
				games_data = result
				score = 0
				score_changed.emit(score)
				highscore_changed.emit(get_current_high_score())
			else:
				push_error("Failed to parse save data.")
		else:
			push_error("Failed to open save file.")
	else:
		push_error("No save file found at: %s" % SAVE_PATH)

func save_game_data():
	ensure_save_file_exists()
	DirAccess.make_dir_recursive_absolute(SAVE_PATH.get_base_dir())
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(games_data, "\t"))
		file.close()
	else:
		push_error("Failed to save game data.")
