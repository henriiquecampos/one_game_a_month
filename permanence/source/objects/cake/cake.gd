extends "res://objects/basic_candy.gd"

export (int) var SPEED = 100
const SPRITES = [preload("res://objects/cake/choco_cake.png"), preload("res://objects/cake/strawberry_cake.png")]

var velocity = Vector2(1,0)
func _ready():
	if get_position().x > get_viewport().size.x/2:
		velocity.x *= -1
	randomize()
	$sprite.set_texture(SPRITES[randi()%SPRITES.size()])

func _physics_process(delta):
	move_local_x((velocity.x * SPEED) * delta)
	move_local_y((velocity.y * SPEED) * delta)
	
func get_hit(hit_normal):
	.get_hit()
	velocity = hit_normal
	yield($visibility, "screen_exited")
	set_state(DEAD)