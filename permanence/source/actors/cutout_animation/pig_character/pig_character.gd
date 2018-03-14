extends Node2D

onready var initial_scale = get_scale()

func _input(event):
	if not event is InputEventKey:
		return
		
	if event.is_action_pressed("right"):
		set_scale(Vector2(initial_scale.x, initial_scale.y))
	elif event.is_action_pressed("left"):
		set_scale(Vector2(initial_scale.x * -1, initial_scale.y))