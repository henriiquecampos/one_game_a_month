extends "res://actors/fighting_actors/basic_fighting_character.gd"

func _input(event):
	if not event is InputEventKey:
		return
		
	if event.is_action_pressed("right"):
		$right_punch.set_disabled(false)
	elif event.is_action_released("right"):
		$right_punch.set_disabled(true)
	elif event.is_action_pressed("left"):
		$left_punch.set_disabled(false)
	elif event.is_action_released("left"):
		$left_punch.set_disabled(true)