extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 50
const MAX_SPEED = 600
const JUMP_HEIGHT = -1400
var velocity = Vector2()
var can_jump = true
var falling = false
var can_move = true
onready var init_scale = $sprites.get_scale()
onready var animator = $sprites/animator

enum STATES{IDLE, WALK, JUMP, FALL}
var current_state = IDLE setget set_current_state, get_current_state

signal state_changed(from, to)

func stand():
	if is_on_floor():
		set_current_state(IDLE)

func jump(is_released):
	if is_released:
		cancel_jump()
		return
	if can_jump:
		set_current_state(JUMP)
		velocity.y = JUMP_HEIGHT
		
func cancel_jump():
	if !can_jump:
		if velocity.y <= 0:
			velocity.y = 0

func walk(is_released, direction, speed = MAX_SPEED):
	if is_released:
		velocity.x = 0
		set_current_state(IDLE)
		return
	velocity.x = speed * direction

	if can_jump:
		set_current_state(WALK)
	

func turn(is_released, direction):
	$sprites.scale = Vector2(init_scale.x *-1, init_scale.y) if direction < 0 else init_scale

func set_current_state(state):
	if current_state == state:
		return
	if state == IDLE:
		can_jump = true
		falling = false
	elif state == WALK:
		falling = false
	elif state == JUMP:
		can_jump = false
	elif state == FALL:
		falling = true
	emit_signal("state_changed", current_state, state)
	current_state = state

func get_current_state():
	return(current_state)

func _physics_process(delta):
	if !can_move:
		return
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, UP)
	
	if is_on_floor():
		set_current_state(IDLE)
	if !can_jump:
		if !falling and velocity.y >= 0:
			set_current_state(FALL)
	