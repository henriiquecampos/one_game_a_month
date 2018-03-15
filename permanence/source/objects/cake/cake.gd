extends "res://objects/flying_candy/flying_candy.gd"

const SPRITES = [preload("res://objects/cake/choco_cake.png"), 
				preload("res://objects/cake/strawberry_cake.png")]

func _ready():
	if get_position().x > get_viewport().size.x/2:
		velocity.x *= -1
	randomize()
	$sprite.set_texture(SPRITES[randi()%SPRITES.size()])