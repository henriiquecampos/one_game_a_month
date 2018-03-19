extends Area2D

enum states {IDLE, STAND, DUCK, IN_AIR}
var state = STAND setget set_state, get_state

export (int) var damage
export (float) var health = 100

signal state_changed(from, to)

func set_state(new_state):
	if state == new_state:
		return
	match new_state:
		IDLE:
			for s in get_children():
				s.set_disabled(true)
			$idle.set_disabled(false)
		STAND:
			$idle.set_disabled(false)
			$duck.set_disabled(true)
		DUCK:
			$duck.set_disabled(false)
			$idle.set_disabled(true)
		IN_AIR:
			$idle.set_disabled(false)
			$duck.set_disabled(true)
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	pass
