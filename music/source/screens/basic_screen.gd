extends Control
enum trans_type{IN, OUT}
export (String, FILE, "*.tscn") var next_scene
signal transition_finished

func _ready():
	apply_transition(OUT)
	
func change_scene(to = next_scene):
	apply_transition(IN)
	yield(self, "transition_finished")
	get_tree().change_scene(to)
	
func apply_transition(mode):
	var a = $Animator
	if mode == 0:
		a.play("transition")
	else:
		a.play_backwards("transition")
	yield(a, "animation_finished")