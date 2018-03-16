extends "res://actors/fighting_actors/basic_fighting_character.gd"
func set_state(new_state):
	.set_state(new_state)
	match new_state:
		ON_GROUND:
			$upper_punch.set_disabled(true)
			$right_punch.set_disabled(true)
			$left_punch.set_disabled(true)
			$sweep.set_disabled(true)
			$idle.set_disabled(false)
			$duck.set_disabled(true)
		IN_AIR:
			$duck.set_disabled(true)
func _input(event):
#	if not event is InputEventKey:
#		return
	match state:
		ON_GROUND:
			if event.is_action_pressed("right"):
				$right_punch.set_disabled(false)
				set_state(ATTACK)
			elif event.is_action_pressed("left"):
				$left_punch.set_disabled(false)
				set_state(ATTACK)
			if event.is_action_pressed("down"):
				$duck.set_disabled(false)
				$idle.set_disabled(true)
				set_state(DEFENSE)
		IN_AIR:
			if event.is_action_pressed("up"):
				$upper_punch.set_disabled(false)
				set_state(ATTACK)
			elif event.is_action_pressed("up"):
				$upper_punch.set_disabled(true)
				
		DEFENSE:
			if event.is_action_pressed("down"):
				$sweep.set_disabled(false)
				set_state(ATTACK)
		ATTACK:
			if event.is_action_released("right"):
				$right_punch.set_disabled(true)
				set_state(ON_GROUND)
			elif event.is_action_released("left"):
				$left_punch.set_disabled(true)
				set_state(ON_GROUND)
			elif event.is_action_released("down"):
				$sweep.set_disabled(true)
				set_state(ON_GROUND)