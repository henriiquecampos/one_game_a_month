extends "res://objects/pickup/pickup.gd"

export (float) var pitch = 1
export (float) var duration = 4
export (int) var octave = 1
onready var info = [pitch, duration, octave]

func _on_body_entered(body):
	if body.is_in_group("players"):
		sing()
		body.can_interact = true
		body.note_object = self
		

func sing():
	$Sprite.frame = 2
	var bus = AudioServer.get_bus_index($SFX.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(pitch)
	$SFX.play()
	$Timer.set_wait_time(duration)
	$Timer.start()
	yield($Timer, "timeout")
	$Sprite.frame = 3
	$SFX.stop()
	
func miss():
	$Sprite.frame = 12
	
func success():
	$Sprite.frame = 1
	$Tween.interpolate_property(self, "position", position, position + Vector2(0, -300), 2.0,Tween.TRANS_SINE, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()

func _on_body_exited( body ):
	if body.is_in_group("players"):
		body.can_interact = false
		body.note_object = null
