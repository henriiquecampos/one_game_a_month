extends "res://actors/player/player_character.gd"

var can_interact = true
var object = null
const NOTE = preload("res://interface/note_duration/note.tscn")
var note = null
enum KEYS{Z, X, C}
var check = false
func _process(delta):
	#Start the interaction if it can, then check for which pitch the 
	#player is trying to use in the interaction
	if Input.is_action_just_pressed("interact") and current_state != JUMP and can_interact:
		$Animator.play("flute")
		var pitch = 0.0
		note = NOTE.instance()
		note.position += Vector2(32, -150)
		if Input.is_key_pressed(KEY_Z):
			note.set_modulate(note.COLORS[Z])
			pitch = 1.0
		elif Input.is_key_pressed(KEY_X):
			note.set_modulate(note.COLORS[X])
			pitch = 1.25
		elif Input.is_key_pressed(KEY_C):
			note.set_modulate(note.COLORS[C])
			pitch = 1.50
		add_child(note)
		interact(pitch)
		if object != null:
			check = check_pitch(pitch, object.pitch)
			if !check:
				object.miss()
	if Input.is_action_just_released("interact") and note != null and can_interact:
		var duration = note.duration
		note.finished()
		if object != null:
			if check_duration(duration, object.note_duration) and check:
				success()
				object.success()
			else:
				miss()
				object.miss()
		else:
			resume()
		
func interact(p):
	#Access the pitch effect and modify it based on the pitch the player
	#is using in the interaction
	var bus = AudioServer.get_bus_index($Flute.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(p)
	$Flute.play()
	#Verifies if the player's pitch matches the object's pitch
	#if it does it can then start the duration verification check
	#based on "res://interface/note_duration/note_duration.gd"

	
	
func resume():
	#Returns the character to it's rest/idle position and re-enable its
	#movement and interaction behaviors
	$Animator.play("rest")
	$Flute.stop()
	can_interact = true
	set_physics_process(true)
	set_process(true)
	
func miss():
	#Plays a failing animation on both the player and the object he is
	#interacting with, in this case "res://actors/birds/bird.gd" then
	#resume the player's character
	$Animator.play("miss")
	yield($Animator, "animation_finished")
	resume()
	
func success():
	$Flute.stop()
	$Animator.play("success")
	yield($Animator, "animation_finished")
	resume()

func check_pitch(player, other):
	#Verifies if pitches match
	if player == other:
		return(true)
	else:
		return(false)
		
func check_duration(player, other):
	#Verifies if durations match
	if player == other:
		return(true)
	else:
		return(false)