extends "res://objects/basic_candy.gd"

const SPRITES = [
				preload("res://objects/lollipop/green_lollipop.png"),
				preload("res://objects/lollipop/red_lollipop.png")
				]
const COLORS = [Color("00d057"), Color("f66600")]

func _ready():
	var index = randi()%SPRITES.size()
	$sprite.set_texture(SPRITES[index])
	$sprite/hurt_particles.set_self_modulate(COLORS[index])
	candy_color = COLORS[index]
	
	if get_position().x > 1024/2:
		set_scale(Vector2(-get_scale().x, get_scale().y))
		$animator.add_animation("attack", 
			preload("res://objects/lollipop/attack_right.tres"))
	else:
		$animator.add_animation("attack", 
			preload("res://objects/lollipop/attack_left.tres"))