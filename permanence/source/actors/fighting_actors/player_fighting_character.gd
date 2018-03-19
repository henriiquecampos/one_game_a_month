extends "res://actors/fighting_actors/basic_fighting_character.gd"

signal attacked
func _input(event):
	match state:
		STAND:
			if event.is_action_pressed("left"):
				$left_punch.set_disabled(false)
				emit_signal("attacked")
			elif event.is_action_released("left"):
				$left_punch.set_disabled(true)
				
			elif event.is_action_pressed("right"):
				$right_punch.set_disabled(false)
				emit_signal("attacked")
			elif event.is_action_released("right"):
				$right_punch.set_disabled(true)
			
			if event.is_action_pressed("down"):
				set_state(DUCK)

		DUCK:
			if event.is_action_pressed("left"):
				$left_sweep.set_disabled(false)
				emit_signal("attacked")
			elif event.is_action_released("left"):
				$left_sweep.set_disabled(true)
				
			elif event.is_action_pressed("right"):
				$right_sweep.set_disabled(false)
				emit_signal("attacked")
			elif event.is_action_released("right"):
				$right_sweep.set_disabled(true)
				
			if event.is_action_pressed("up"):
				set_state(IN_AIR)
				emit_signal("attacked")
				$upper_punch.set_disabled(false)
		IN_AIR:
			if event.is_action_pressed("up"):
				$upper_punch.set_disabled(false)
				emit_signal("attacked")
			elif event.is_action_pressed("down"):
				$upper_punch.set_disabled(true)
				$down_kick.set_disabled(false)
				emit_signal("attacked")