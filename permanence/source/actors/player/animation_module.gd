extends AnimationPlayer

var anims = ["idle", "walk", "jump", "fall"]
var actions = ["idle", "punch", "kick", "duck", "upper", "sweep"]

export (NodePath) var physics_node
export (NodePath) var fight_node
func _ready():
	get_node(physics_node).connect("state_changed", self, "_on_physics_state_changed")
	get_node(fight_node).connect("action_changed", self, "_on_action_changed")
	
func _on_physics_state_changed(from, to):
	play(anims[to])
	
func _on_action_changed(from, to):
	play(actions[to])
	if to != 0:
		yield(self, "animation_finished")
		play(actions[0])