extends "res://objects/basic_candy.gd"

export (int) var SPEED = 100
const SPRITES = [preload("res://objects/cake/choco_cake.png"), preload("res://objects/cake/strawberry_cake.png")]

func _ready():
	randomize()
	$sprite.set_texture(SPRITES[randi()%SPRITES.size()])
func _physics_process(delta):
	move_local_x(SPEED * delta)
	
func get_hit():
	.get_hit()
	SPEED = (SPEED * 0.75) * -1
	yield($visibility, "screen_exited")
	set_state(DEAD)