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
			$shape.set_disabled(true)
	emit_signal("state_changed", state, new_state)
	state = new_state

func get_state():
	return(state)
	
func get_hit(normal):
	set_state(HURT)
	shake_camera(15, 0.2)
	Input.start_joy_vibration(0, 1.0, 1.0, 0.2)
	yield(animator, "animation_finished")
	set_state(DEAD)
	
func shake_camera(magnitude, life_spam):
	$"../../camera".shake(magnitude,life_spam)

func vibrate_joy(which, weak, strong, duration):
	Input.start_joy_vibration(which, weak, strong, duration)
	
func stop_joy_vibration(which):
	Input.stop_joy_vibration(0)