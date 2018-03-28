extends "res://screens/basic_screen.gd"

func _ready():
	get_tree().set_pause(false)
	score_node.check_highscore()
	var t = "score: {amount}"
	$highscore_table/current_score.set_text(t.format({"amount":score_node.get_score()}))
	
	t = "highscore: {amount}"
	$highscore_table/highscore.set_text(t.format({"amount":score_node.highscore}))
	
	if score_node.current_score >= score_node.highscore:
		$highscore_table/new_highscore.visible = true
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		change_scene()