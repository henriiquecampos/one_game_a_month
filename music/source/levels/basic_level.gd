extends Node2D

onready var objectives = $Objectives.get_child_count()

func _ready():
	$Portal.connect("body_entered", self, "_portal_body_entered")
	for o in $Objectives.get_children():
		o.connect("tree_exited", self, "check_objective", [o])
		
func check_objective(what):
	if what.has_method("score"):
		emit_signal("score_increased", [what.score])
	objectives -= 1
	
func _portal_body_entered(body):
	if body.is_in_group("players"):
		check_completion()
		
func check_completion():
	if $Objectives.get_child_count() == 0:
		print("completed")
		$Screen/GameScreen.change_scene()