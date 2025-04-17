extends Control

#main method
func _ready():
	Firebase.Auth.login_succeeded.connect(_on_firebaseAuth_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(_on_firebaseAuth_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		%StateLabel.text = "Logged in"
		print("Logged in from previous session(s)")
		get_tree().call_deferred("change_scene_to_packed", load("res://scenes/main_menu.tscn"))

#register with email
func _on_signup_withEmail_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StateLabel.text = "Sign up"

#login with email
func _on_login_withEmail_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%StateLabel.text = "Login"

#login anonymously
func _on_login_anonymous_button_pressed():
	Firebase.Auth.login_anonymous()

#when login succesfull
func _on_firebaseAuth_login_succeeded(auth):
	print(auth)
	%StateLabel.text = "Login succesfull!"
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

#when signup succesfull
func _on_firebaseAuth_signup_succeeded(auth):
	print(auth)
	%StateLabel.text = "Sign up succesfull!"
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

#when login unsuccesfull
func on_login_failed(error_code, message):
	print("error:" + str(error_code))
	print("message:" + str(message))
	%StateLabel.text = "Login failed"

#when signup unsuccesfull
func on_signup_failed(error_code, message):
	print("error:" + str(error_code))
	print("message:" + str(message))
	%StateLabel.text = "Sign up failed"
