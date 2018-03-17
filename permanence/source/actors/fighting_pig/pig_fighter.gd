extends "res://actors/platform_actors/player_character.gd"

onready var animator = $cutout_sprites/animator
onready var fighter = $player_fighter
var is_jumping = false
enum shapes{RIGHT_PUNCH, LEFT_PUNCH, UPPER_PUNCH, SWEEP, DUCK, IDLE}

signal scored(amount)
func _on_kinematic_state_changed(from, to):
	match to:
		JUMP:
			fighter.set_state(fighter.IN_AIR)
		FALL:
			animator.play("fall")
			fighter.get_node("upper_punch").set_disabled(true)
			fighter.get_node("idle").set_disabled(false)
		IDLE:
			fighter.set_state(fighter.ON_GROUND)
			animator.play("idle")

func _on_fighting_state_changed(from, to):
	match from:
		fighter.IN_AIR:
			match to:
				fighter.ATTACK:
					if is_jumping:
						animator.play("upper")
						velocity.y = jump()
						is_jumping = false
				fighter.ON_GROUND:
					animator.play("idle")
					
		fighter.ON_GROUND:
			match to:
				fighter.ATTACK:
					animator.play("punch")
				fighter.DEFENSE:
					animator.play("duck")
				fighter.IN_AIR:
					is_jumping = true
					animator.play("jump")
		fighter.DEFENSE:
			match to:
				fighter.ATTACK:
					animator.play("sweep")
					yield(animator, "animation_finished")
					animator.play("idle")
				fighter.IN_AIR:
					fighter.get_node("idle").set_disabled(true)
					fighter.get_node("upper_punch").set_disabled(false)
					animator.play("upper")
					
		fighter.ATTACK:
			match to:
				fighter.ON_GROUND:
						animator.play("idle")
						
	match to:
		fighter.ATTACK:
			match from:
				fighter.ON_GROUND:
					yield(animator, "animation_finished")
					fighter.set_state(fighter.ON_GROUND)
		fighter.ON_GROUND:
			animator.play("idle")

func _on_fighter_shape_entered(area_id, area, area_shape, self_shape):
	match self_shape:
		RIGHT_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		LEFT_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		UPPER_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		SWEEP:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		IDLE:
			animator.play("hurt")
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.ON_GROUND)
			animator.play("idle")
		DUCK:
			animator.play("hurt")
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.ON_GROUND)
			animator.play("idle")