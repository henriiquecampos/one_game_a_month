extends Area2D

enum states{ATTACK, HURT, DEAD}
var state = ATTACK setget set_state, get_state
signal state_changed(from, to)

export (int) var score
onready var animator = $animator

func set_state(new_state):
	if new_state == state:
		return
		
	match state:
		HURT:
			match new_state:
				DEAD:
					queue_free()
					
	match new_state:
		HURT:
			animator.play("hurt")
	emit_signal("state_changed", state, new_state)
	state = new_state

func get_state():
	return(state)
	
func get_hit():
	set_state(HURT)