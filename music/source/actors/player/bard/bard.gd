extends "res://actors/player/player_character.gd"

var can_interact = false
var note_object = null
const NOTE_UI = preload("res://interface/note_duration/note_duration.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and can_interact:
		can_interact = false
		interact()
		
func interact():
	print("interacting")
	set_physics_process(false)
	set_process(false)
	var s = NOTE_UI.instance()
	s.max_value = note_object.duration
	add_child(s)
	
func resume():
	can_interact = true
	set_physics_process(true)
	set_process(true)