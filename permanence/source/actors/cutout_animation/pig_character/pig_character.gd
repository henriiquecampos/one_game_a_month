extends Node2D

onready var initial_scale = get_scale()

func _input(event):

	if event.is_action_pressed("right") or Input.get_joy_axis(0, 0) == 1:
		set_scale(Vector2(initial_scale.x, initial_scale.y))
	elif event.is_action_pressed("left") or Input.get_joy_axis(0, 0) == -1:
		set_scale(Vector2(initial_scale.x * -1, initial_scale.y))