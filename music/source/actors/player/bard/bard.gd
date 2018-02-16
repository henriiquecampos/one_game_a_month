extends "res://actors/player/player_character.gd"

var can_interact = false
var note_object = null
const NOTE_UI = preload("res://interface/note_duration/note_duration.tscn")

func _process(delta):
	if Input.is_action_just_pressed("interact") and can_interact:
		can_interact = false
		if Input.is_key_pressed(KEY_Z):
			interact(1.0)
		elif Input.is_key_pressed(KEY_X):
			interact(1.25)
		elif Input.is_key_pressed(KEY_C):
			interact(1.5)
		
func interact(pitch):
	set_physics_process(false)
	set_process(false)
	var bus = AudioServer.get_bus_index($Flute.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(pitch)
	$Flute.play()
	if check_pitch(pitch):
		var s = NOTE_UI.instance()
		s.max_value = note_object.duration
		add_child(s)
	else:
		resume()
		print("wrong pitch")
	
func resume():
	$Flute.stop()
	can_interact = true
	set_physics_process(true)
	set_process(true)
	
func check_pitch(pitch):
	if pitch == note_object.pitch:
		return(true)
	else:
		return(false)