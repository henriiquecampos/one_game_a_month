extends "res://objects/pickup/pickup.gd"

export (int, "A", "B", "C", "D", "E", "F", "G") var pitch = 0
export (int) var duration = 4
export (int) var octave = 1
onready var info = [pitch, duration, octave]
func _on_body_entered(body):
	print(info)
	._on_body_entered(body)