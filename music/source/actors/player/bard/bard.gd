extends "res://actors/player/player_character.gd"

var can_interact = false
var object = null
const NOTE_UI = preload("res://interface/note_duration/note_duration.tscn")

func _process(delta):
	#Start the interaction if it can, then check for which pitch the 
	#player is trying to use in the interaction
	if Input.is_action_just_pressed("interact") and can_interact and current_state != JUMP:
		$Animator.play("flute")
		can_interact = false
		if Input.is_key_pressed(KEY_Z):
			interact(1.0)
		elif Input.is_key_pressed(KEY_X):
			interact(1.25)
		elif Input.is_key_pressed(KEY_C):
			interact(1.5)
		
func interact(pitch):
	#Locks the player movement so if can only interact once and can't
	#move during the interaction
	set_physics_process(false)
	set_process(false)
	#Access the pitch effect and modify it based on the pitch the player
	#is using in the interaction
	var bus = AudioServer.get_bus_index($Flute.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(pitch)
	$Flute.play()
	#Verifies if the player's pitch matches the object's pitch
	#if it does it can then start the duration verification check
	#based on "res://interface/note_duration/note_duration.gd"
	if check_pitch(pitch, object.pitch):
		var s = NOTE_UI.instance()
		s.max_value = object.duration
		add_child(s)
	else:
		miss()
	
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
	object.miss()
	yield($Animator, "animation_finished")
	resume()
	
func success():
	$Flute.stop()
	$Animator.play("success")
	object.success()
	yield($Animator, "animation_finished")
	resume()

func check_pitch(player, other):
	#Verifies if pitches match
	if player == other:
		return(true)
	else:
		return(false)