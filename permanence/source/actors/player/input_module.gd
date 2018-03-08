extends Node
signal up(is_released)
signal down(is_released)
signal left(is_released)
signal right(is_released)
signal jump(is_released)

func _input(event):
	if !event is InputEventKey:
		return
	if event.is_echo():
		return
	if event.is_action_pressed("jump"):
		emit_signal("jump", false)
	elif event.is_action_released("jump"):
		emit_signal("jump", true)
		
	if event.is_action_pressed("right"):
		emit_signal("right", false)
	elif event.is_action_pressed("left"):
		emit_signal("left", false)
	elif event.is_action_released("right"):
		emit_signal("right", true)
	elif event.is_action_released("left"):
		emit_signal("left", true)
		
	if event.is_action_pressed("down"):
		emit_signal("down", false)
	elif event.is_action_released("down"):
		emit_signal("down", true)