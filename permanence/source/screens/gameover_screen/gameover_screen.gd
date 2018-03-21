extends "res://screens/basic_screen.gd"

func _ready():
	get_tree().set_pause(false)
	var highscore = score_node.check_highscore()
	
	var t = "score: {amount}"
	$highscore_table/current_score.set_text(t.format({"amount":score_node.get_score()}))
	
	t = "highscore: {amount}"
	$highscore_table/highscore.set_text(t.format({"amount":highscore}))
	
	if highscore > score_node.get_score():
		$highscore_table/new_high.show()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		change_scene()