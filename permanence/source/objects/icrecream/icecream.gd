extends Node

export (PackedScene) var topling

const TOPLINGS = [
					preload("res://objects/icrecream/choco_topling.png"),
					preload("res://objects/icrecream/strawberry_topling.png"),
					preload("res://objects/icrecream/vanilla_topling.png")
				]
const COLORS = [Color("917052"), Color("f7c4f1"), Color("e6dfc1")]
onready var animator = $animator

func _ready():
	randomize()
	var index = randi()%TOPLINGS.size()
	$topling.set_texture(TOPLINGS[index])
	yield($animator, "animation_finished")
	var t = topling.instance()
	t.get_node("particles").set_self_modulate(COLORS[index])
	t.get_node("sprite").set_texture(TOPLINGS[index])
	t.set_global_transform($topling.get_global_transform())
	$topling.hide()
	get_parent().add_child(t)
	$animator.play("exit")
	yield($animator, "animation_finished")
	queue_free()