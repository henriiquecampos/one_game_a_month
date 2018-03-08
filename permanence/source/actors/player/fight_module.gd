extends Node

enum actions{IDLE, PUNCH, KICK, DUCK, UPPER, SWEEP, COMBO}

var action = IDLE setget set_current_action, get_current_action
var combo = 0
var target = null
signal action_changed(from, to)
var hit_vector = Vector2(0,0)
var hurt_vector = Vector2(0,0)

export (NodePath) var input_node

func _ready():
	get_node(input_node).connect("right", self, "punch", [1])
	get_node(input_node).connect("left", self, "punch", [-1])
	get_node(input_node).connect("down", self, "duck")
func punch(is_released, direction):
	if !is_released:
		set_current_action(PUNCH)
		hit_vector.x = direction

func duck(is_released):
	if !is_released:
		set_current_action(DUCK)
	else:
		set_current_action(IDLE)
		
func set_current_action(what):
	if what == action and what != PUNCH:
		return
	emit_signal("action_changed", action, what)
	action = what
	
func get_current_action():
	return(action)

func set_target(to):
	target = to
	to.connect("exit_tree", self, "clear_target")
	
func clear_target():
	target = null