extends "res://actors/platform_actors/player_character.gd"

onready var animator = $cutout_sprites/animator
onready var fighter = $player_fighter
var can_jump = true
enum shapes{RIGHT_PUNCH, LEFT_PUNCH, UPPER_PUNCH, DOWN_KICK, LEFT_SWEEP, RIGHT_SWEEP, DUCK, IDLE}

signal scored(amount)
func _on_kinematic_state_changed(from, to):
	match to:
		IDLE:
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		JUMP:
			fighter.set_state(fighter.IN_AIR)
		FALL:
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.IN_AIR)

func _on_fighting_state_changed(from, to):
	match to:
		fighter.STAND:
			animator.play("idle")
			can_jump = true
		fighter.IN_AIR:
			match from:
				fighter.DUCK:
					animator.play("upper")
				fighter.STAND:
					animator.play("jump")
				fighter.IDLE:
					animator.play("fall")
		fighter.DUCK:
			animator.play("duck")
	
func _on_player_fighter_attacked():
	match fighter.get_state():
		fighter.IN_AIR:
			if can_jump:
				velocity.y = jump()
				animator.play("upper")
				can_jump = false
			elif get_state() == FALL:
				velocity.y = -jump()
				print("down_kick")
		fighter.STAND:
			animator.play("punch")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.DUCK:
			animator.play("sweep")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)

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
		LEFT_SWEEP:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		RIGHT_SWEEP:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		DOWN_KICK:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		IDLE:
			animator.play("hurt")
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		DUCK:
			animator.play("hurt")
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
