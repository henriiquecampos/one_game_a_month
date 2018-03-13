extends Area2D

enum states {ON_GROUND, IN_AIR, ATTACK, DEFENSE}
var state = ON_GROUND setget set_state, get_state

export (int) var damage
export (float) var health = 100

signal state_changed(from, to)

func apply_damage(damage, to):
	pass
	
func hurt(amount):
	pass

func set_state(new_state):
	if state == new_state:
		return
	match new_state:
		ON_GROUND:
			$upper_punch.set_disabled(true)
			$idle.set_disabled(false)
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)