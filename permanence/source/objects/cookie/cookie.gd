extends "res://objects/flying_candy/flying_candy.gd"

func _ready():
	var player = get_tree().get_nodes_in_group("players")[0]
	var normal = (player.global_position - global_position).normalized()
	
	$sprite.rotation = normal.angle()
	set_velocity(normal)