extends TextureButton

@export var normal_color: Color = Color(1, 1, 1)
@export var pressed_color: Color = Color(0.8, 0.8, 0.8)

func _ready():
	modulate = normal_color

func _on_pressed():
	modulate = pressed_color
	emit_signal("shoot_pressed")

func _on_button_up():
	modulate = normal_color

signal shoot_pressed
