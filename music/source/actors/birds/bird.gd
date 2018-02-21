extends "res://objects/pickup/pickup.gd"

export (float) var pitch = 1
export (float) var duration = 1
export (int) var octave = 1
onready var info = [pitch, duration, octave]
export (int) var miss_sprite = 0
export (int) var normal_sprite = 0
export (int) var sing_sprite = 0
export (int) var success_sprite = 0

func sing():
	$Sprite.frame = sing_sprite
	#Find the pitch sound effect then apply the bird's pitch in pitch_scale
	#and plays the audio in the SFX Node
	var bus = AudioServer.get_bus_index($SFX.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(pitch)
	$SFX.play()
	#Sustain the note based on duration until the Timer finishes the
	#countdown the stop playing
	$Timer.set_wait_time(duration)
	$Timer.start()
	yield($Timer, "timeout")
	$Sprite.frame = normal_sprite
	$SFX.stop()
	
func miss():
	$Exclamation.show()
	$Sprite.frame = miss_sprite
	
func success():
	$Exclamation.hide()
	$Sprite.frame = success_sprite
	#Interpolates position on Y axis then frees itself, exiting the scene
	$Tween.interpolate_property(self, "position", position, position + Vector2(0, -300), 2.0,Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
	
func _on_body_entered(body):
	#Starts interaction with the player, setting itself as the current
	#object to interact with
	if body.is_in_group("players"):
		sing()
		body.can_interact = true
		body.object = self

func _on_body_exited( body ):
	$Exclamation.hide()
	$Sprite.frame = normal_sprite
	#Sets the current interact object to be null if players exits its
	#area of interaction
	if body.is_in_group("players"):
		body.can_interact = false
		body.object = null
