extends ProgressBar
var hold = 0.0
func _process(delta):
	
	#Increase ProgressBar's value based on the amount of time the player
	#is holding the interact action
	if Input.is_action_pressed("interact"):
		hold += delta
		value = hold
	
	#Checks if the player released the interation too soon or right in
	#time with a small tolerance of 0.1 seconds
	if Input.is_action_just_released("interact"):
		if hold < max_value:
			get_parent().note_object.miss()
			get_parent().resume()
		elif hold >= max_value and hold <= max_value + 0.1:
			get_parent().success()
		queue_free()
	
	#Checks if the player is holding the action above the tolerance,
	#missing the note duration
	if hold > max_value + 0.1 :
		get_parent().miss()
		queue_free()