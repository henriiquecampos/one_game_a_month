extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var velocity = Vector2()
var can_jump = true

enum STATES{IDLE, WALK, JUMP}
var current_state = IDLE setget set_current_state, get_current_state

func _physics_process(delta):
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP)
	
	if is_on_floor():
		can_jump = true
		
	if !can_jump:
		if velocity.y == 0:
			$Sprite.set_animation("fall")
			$Sprite.stop()
		elif velocity.y > 10:
			$Sprite.set_frame(1)
	
func apply_jump():
	if is_on_floor():
		set_current_state(JUMP)
		velocity.y = JUMP_HEIGHT
		can_jump = false
		
func cancel_jump():
	if !can_jump:
		if velocity.y <= 0:
			velocity.y = 0
		
func walk(direction, speed = MAX_SPEED):
	velocity.x = speed * direction
	
	if direction != 0 and can_jump:
		set_current_state(WALK)
		$Sprite.set_flip_h(false if direction > 0 else true)
	else:
		if can_jump:
			set_current_state(IDLE)

func set_current_state(state):
	if current_state == state:
		return
	if state == IDLE:
		$Sprite.play("idle")
	elif state == WALK:
		$Sprite.play("walk")
	elif state == JUMP:
		$Sprite.play("jump")
		
	current_state = state

func get_current_state():
	return(current_state)