extends Area2D

enum states {IDLE, STAND, DUCK, IN_AIR}
enum shapes{RIGHT_PUNCH, LEFT_PUNCH, UPPER_PUNCH, DOWN_KICK, LEFT_SWEEP, RIGHT_SWEEP, DUCK, IDLE}
const SFX = [preload("res://actors/fighting_actors/animal_melee_sound.wav"),
			 preload("res://actors/fighting_actors/melee_sound.wav")]
var state = STAND setget set_state, get_state

export (int) var damage
export (float) var health = 100

signal state_changed(from, to)

func set_state(new_state):
	if state == new_state:
		return
	match new_state:
		IDLE:
			for s in get_children():
				if s is CollisionShape2D:
					s.set_disabled(true)
			$idle.set_disabled(false)
		STAND:
			$idle.set_disabled(false)
			$duck.set_disabled(true)
		DUCK:
			$duck.set_disabled(false)
			$idle.set_disabled(true)
		IN_AIR:
			$idle.set_disabled(false)
			$duck.set_disabled(true)
	emit_signal("state_changed", state, new_state)
	state = new_state
	
func get_state():
	return(state)
	
func punch():
	var index = randi()%SFX.size()
	var bus = AudioServer.get_bus_index($sfx.get_bus())
	var fx = AudioServer.get_bus_effect(bus, 0)
	fx.set_pitch_scale(rand_range(0.8, 1.3))
	$sfx.set_stream(SFX[index])
	$sfx.play()
#	fx.set_pitch_scale(1.0)

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	pass
