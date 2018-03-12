extends KinematicBody2D

enum states {IDLE, WALK, JUMP, FALL}
var state = IDLE setget set_state, get_state

export (float) var walk_speed = 100.0
var direction = 1
const JUMP_HEIGHT = 800
const GRAVITY = 1000

var velocity = Vector2(0, 0)
func set_state(new_state):
	if state == new_state:
		return
	state = new_state
	
func get_state():
	return(state)
	
func jump():
	return(-JUMP_HEIGHT)
	
func cancel_jump():
	pass
	
func walk(direction, speed):
	speed = speed * direction
	return(speed)
	
func stop():
	return(Vector2(0,0))
	
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity)
	match state:
		IDLE:
			stop()
			return
		WALK:
			velocity.x = walk(direction, walk_speed)
			return
		JUMP:
			var can_jump = is_on_floor()
			if can_jump:
				velocity.y = jump()
			return
		FALL:
			return