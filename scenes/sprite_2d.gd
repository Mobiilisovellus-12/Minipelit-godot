extends Sprite2D

var crosshair : Sprite2D

func _ready():
	center_crosshair()

@export var speed : float = 600

@export var joystick_left : VirtualJoystick

var move_vector := Vector2.ZERO

func center_crosshair():
	var screen_center = get_viewport().size / 2
	position = screen_center

func _process(delta: float) -> void:
	## Movement using Input functions:
	move_vector = Vector2.ZERO
	move_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	position += move_vector * speed * delta

	#var screen_size = get_viewport().size
	#var border_left = 0
	#var border_right = screen_size.x
	#var border_top = 0
	#var border_bottom = screen_size.y
	
	#position.x = clamp(position.x, border_left, border_right)
	#position.y = clamp(position.y, border_top, border_bottom)
