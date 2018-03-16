extends "res://objects/basic_candy.gd"

export (int) var SPEED = 100
var velocity = Vector2(1,0) setget set_velocity

func _physics_process(delta):
	move_local_x((velocity.x * SPEED) * delta)
	move_local_y((velocity.y * SPEED) * delta)
	
func set_velocity(new_velocity):
	velocity = new_velocity