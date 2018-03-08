extends "res://actors/kinematic_character.gd"

export (NodePath) var input_node
func _ready():
	get_node(input_node).connect("jump", self, "jump")
	get_node(input_node).connect("right", self, "turn", [1])
	get_node(input_node).connect("left", self, "turn", [-1])