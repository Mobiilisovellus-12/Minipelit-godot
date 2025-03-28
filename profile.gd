extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	
	
	if Firebase.Auth.check_auth_file():
		%Email.text = "Logged in"
		%LogOutButton.visible = true
			
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))


func _on_log_out_button_pressed() -> void:
	Firebase.Auth.logout()
	%Username.text = "Guest"
	%Email.text = ""
	%LogOutButton.visible = false
