extends "res://objects/pickup/pickup.gd"

export (float) var pitch = 1
export (float) var duration = 4
export (int) var octave = 1
onready var info = [pitch, duration, octave]
func _on_body_entered(body):
	if body.is_in_group("players"):
		body.can_interact = true
		body.note_object = self
		$SFX.play()
		
func capture(who):
	$Shape.set_disabled(true)
#	$Tween.interpolate_property(self, "global_position", get_global_position(), who.get_global_position(),
#	1.0, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.interpolate_property($Sprite, "scale", get_scale(), Vector2(0.1, 0.1),
	1.0, Tween.TRANS_BACK, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()