extends Control

const function = preload("res://scripts/get_leaderboard.gd")

func on_press():
	function.first_score("seitsemän", 649)
	
func on_other_press():
	function.read_and_sort_leaderboard()

#func on_third_press():
#	function.update_score("vallu", 1000)
