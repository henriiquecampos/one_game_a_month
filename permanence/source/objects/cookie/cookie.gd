extends KinematicBody2D

var speed = 300
var velocity = Vector2(speed, 0)

func _physics_process(delta):
	move_and_collide(velocity * delta)
	velocity = Vector2(speed, 0)