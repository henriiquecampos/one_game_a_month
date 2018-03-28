extends RigidBody2D

onready var candy = $candy

func _ready():
	candy.connect("tree_exited", self, "queue_free")
func _on_candy_state_changed(from, to):
	match to:
		candy.HURT:
			$shape.set_disabled(true)
			$sprite.hide()
		candy.DEAD:
			queue_free()