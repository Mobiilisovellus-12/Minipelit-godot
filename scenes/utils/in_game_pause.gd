extends Control

signal return_back_to_game
signal go_back_to_menu

func _on_return_button_pressed():
	emit_signal("return_back_to_game")


func _on_back_to_menu_button_pressed():
	emit_signal("go_back_to_menu")
