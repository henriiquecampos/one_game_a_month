extends Position2D

export (PackedScene) var spawn_scene

export (float) var min_wait_time = 15.0
export (float) var max_wait_time = 30.0

export (Vector2) var tween_target = Vector2()
onready var initial_pos = get_position()

func _ready():
	_move()
	$timer.connect("timeout", self, "_spawn", [spawn_scene])
	$timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	$timer.start()

func _spawn(what):
	var s = what.instance()
	s.set_position(get_position())
	
	get_parent().add_child(s)
	$timer.set_wait_time(rand_range(min_wait_time, max_wait_time))
	$timer.start()
	
func _move(to = tween_target):
	var t = $tween
	t.interpolate_property(self, "position", initial_pos, to, 2.0,
		 t.TRANS_LINEAR, t.EASE_IN)
	t.start()
	yield(t, "tween_completed")
	t.interpolate_property(self, "position", to, initial_pos, 2.0,
		 t.TRANS_LINEAR, t.EASE_IN)
	t.start()
	yield(t, "tween_completed")
	_move()
	