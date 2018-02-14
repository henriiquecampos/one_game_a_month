extends "res://actors/basic_character.gd"

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		apply_jump()
	if Input.is_action_just_released("ui_accept"):
		cancel_jump()
		
	if Input.is_action_pressed("ui_right"):
		walk(1)
	elif Input.is_action_pressed("ui_left"):
		walk(-1)
	else:
		walk(0)