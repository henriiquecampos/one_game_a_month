extends "res://actors/basic_character.gd"
func _physics_process(delta):
	if Input.is_action_just_pressed("duck"):
		duck()
	if Input.is_action_just_released("duck"):
		stand()
	if !can_move:
		return
	if Input.is_action_just_pressed("jump"):
		apply_jump()
	if Input.is_action_just_released("jump"):
		cancel_jump()
		
	if Input.is_action_pressed("walk_right"):
		walk(1, 0)
	elif Input.is_action_pressed("walk_left"):
		walk(-1, 0)
	else:
		walk(0)