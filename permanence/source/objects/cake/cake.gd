extends "res://objects/flying_candy/flying_candy.gd"

const SPRITES = [
				preload("res://objects/cake/choco_cake.png"), 
				preload("res://objects/cake/strawberry_cake.png")
				]
const COLORS = [Color("917052"), Color("f7c4f1")]

func _ready():
	if get_position().x > 1024/2:
		velocity.x *= -1
	randomize()
	var index = randi()%SPRITES.size()
	$sprite.set_texture(SPRITES[index])
	$sprite/hurt_particles.set_self_modulate(COLORS[index])
	candy_color = COLORS[index]