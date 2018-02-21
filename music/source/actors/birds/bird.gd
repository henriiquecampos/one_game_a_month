tool
extends "res://objects/pickup/pickup.gd"

export (float) var pitch = 1
export (float) var duration = 1
onready var info = [pitch, duration]
export (int, 0, 2) var sprite_row = 0 setget set_sprite_row
export (bool) var flip_h = false setget set_flip_h
var success = false

func sing():
	$Sprite.frame = (sprite_row * 4) + 2
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
	$Sprite.frame = (sprite_row * 4) + 3
	$SFX.stop()
	
func miss():
	$Sprite/Exclamation.show()
	$Sprite.frame = 12 + sprite_row
	
func success():
	$Sprite/Exclamation.hide()
	$Sprite.frame = (sprite_row * 4) + 1
	success = true
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
	$Sprite/Exclamation.hide()
	if !success:
		$Sprite.frame = (sprite_row * 4) + 3
	#Sets the current interact object to be null if players exits its
	#area of interaction
	if body.is_in_group("players"):
		body.can_interact = false
		body.object = null

func set_flip_h(value):
	flip_h = value
	$Sprite.scale.x *= -1

func set_sprite_row(value):
	sprite_row = value
	$Sprite.frame = (sprite_row * 4) + 3