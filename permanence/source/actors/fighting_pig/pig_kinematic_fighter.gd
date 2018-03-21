extends "res://actors/platform_actors/player_character.gd"

onready var animator = $cutout_sprites/animator
onready var fighter = $player_fighter
var can_jump = true

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
				fighter.STAND:
					animator.play("jump")
				fighter.IDLE:
					animator.play("fall")
		fighter.DUCK:
			animator.play("duck")
	
func _on_player_fighter_attacked(shape):
	match shape:
		fighter.LEFT_PUNCH:
			animator.play("punch")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.RIGHT_PUNCH:
			animator.play("punch")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.LEFT_SWEEP:
			animator.play("sweep")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.RIGHT_SWEEP:
			animator.play("sweep")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.UPPER_PUNCH:
			if can_jump:
				can_jump = false
				animator.play("upper")
				velocity.y = jump()
		fighter.DOWN_KICK:
			can_jump = false
			animator.play("kick")
			velocity.y = -(jump() * 0.8)
			animator.play("kick")

func _on_fighter_shape_entered(area_id, area, area_shape, self_shape):
	match self_shape:
		fighter.RIGHT_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.LEFT_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.UPPER_PUNCH:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.LEFT_SWEEP:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.RIGHT_SWEEP:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.DOWN_KICK:
			emit_signal("scored", area.score)
			area.get_hit((area.get_global_position() - get_global_position()).normalized())
		fighter.IDLE:
			animator.play("hurt")
			tween_hurt(animator.get_current_animation_length())
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.DUCK:
			animator.play("hurt")
			tween_hurt(animator.get_current_animation_length())
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)

func tween_hurt(duration):
	var initial = $cutout_sprites.scale
	$tween.interpolate_property($cutout_sprites, "scale", initial, initial * 1.05,
		duration/2, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	var current = $cutout_sprites.scale
	$tween.interpolate_property($cutout_sprites, "scale", current, initial,
		duration/2, Tween.TRANS_QUINT, Tween.EASE_IN)
	