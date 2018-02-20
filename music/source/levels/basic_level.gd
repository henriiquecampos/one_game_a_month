extends Node2D

onready var objectives = $Objectives.get_child_count()

func _ready():
	for o in $Objectives.get_children():
		o.connect("tree_exited", self, "check_objective", [o])
		
func check_objective(what):
	if what.has_method("score"):
		emit_signal("score_increased", [what.score])
	objectives -= 1