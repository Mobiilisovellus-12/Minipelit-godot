extends Control

const function = preload("res://scripts/get_leaderboard.gd")

func on_press():
	function.get_leaderboard_from_firebase()
