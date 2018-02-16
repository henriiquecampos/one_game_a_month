extends ProgressBar
var hold = 0.0
func _process(delta):
	if Input.is_action_pressed("interact"):
		hold += delta
		value = hold
	
		
	if Input.is_action_just_released("interact"):
		if hold < max_value:
			print("too short")
		elif hold >= max_value and hold <= max_value + 0.1:
			print("correct")
			get_parent().note_object.set_modulate(Color("#00ffff"))
			get_parent().note_object.capture(get_parent())
		get_parent().resume()
		queue_free()

	if hold > max_value + 0.1 :
		print("too long")
		get_parent().note_object.set_modulate(Color("#ff0000"))
		get_parent().resume()
		queue_free()