extends Control

func _ready():
	get_viewport().size = DisplayServer.screen_get_size()
	
	
	if Firebase.Auth.check_auth_file():
		# Tähän lisättävä Username-ominaisuus
		%Email.text = "Logged in"
		%LogOutButton.visible = true
		%LogInButton.visible = false
	else:
		default()
		
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/menus/main_menu.tscn"))


func _on_log_out_button_pressed() -> void:
	Firebase.Auth.logout()
	default()
	get_tree().change_scene_to_packed(load("res://scenes/utils/firebase.tscn"))
	print("logout painettu")
	
func default() -> void:
	%Username.text = "Guest"
	%Email.text = ""
	%LogOutButton.visible = false
	%LogInButton.visible = true


func _on_log_in_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/utils/firebase.tscn"))
