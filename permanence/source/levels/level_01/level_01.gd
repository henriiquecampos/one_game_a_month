extends Node2D

func _ready():
	$player_character/health.connect("health_changed", 
		$game_screen/interface/control/progress_bar,"set_value")
	$game_screen/interface/control/progress_bar.set_max($player_character/health.max_health)
	$player_character/health.connect("health_changed", self, "_on_player_health_changed")
	score_node.connect("score_changed", self, "_on_score_changed")
	score_node.set_score(0)
	
func _on_player_health_changed(health):
	if health >= 100:
		get_tree().set_pause(true)
		$game_screen.change_scene()

func _on_player_character_scored(amount):
	score_node.set_score(score_node.get_score() + amount)

func _on_score_changed(to):
	var s = $game_screen/interface/control/score
	
	var text = "calories: {amount}"

	s.set_text(text.format({"amount":to}))