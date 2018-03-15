extends "res://objects/flying_candy/flying_candy.gd"
const SPRITES = [preload("res://objects/cookie/choco_cookie.png"), 
				preload("res://objects/cookie/strawberry_cookie.png"),
				preload("res://objects/cookie/vanilla_cookie.png")]
const COLORS = [Color("917052"), Color("f7c4f1"), Color("3c3228")]

func _ready():
	var index = randi()%SPRITES.size()
	$sprite.set_texture(SPRITES[index])
	$sprite/hurt_particles.set_self_modulate(COLORS[index])
	var player = get_tree().get_nodes_in_group("players")[0]
	var normal = (player.global_position - global_position).normalized()
	
	$sprite.rotation = normal.angle()
	set_velocity(normal)