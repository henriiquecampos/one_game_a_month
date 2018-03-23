extends "res://actors/platform_actors/player_character.gd"

const SFX = [preload("res://actors/fighting_pig/1_jump.ogg"),
			preload("res://actors/fighting_pig/2_punch.ogg"),
			preload("res://actors/fighting_pig/3_sweep.ogg"),
			preload("res://actors/fighting_pig/4_upper.ogg"),
			preload("res://actors/fighting_pig/5_kick.ogg"),
			preload("res://actors/fighting_pig/6_pighurt.ogg")
			]

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
					$sfx.set_stream(SFX[0])
					$sfx.play()
				fighter.IDLE:
					animator.play("fall")
		fighter.DUCK:
			animator.play("duck")
	
func _on_player_fighter_attacked(shape):
	match shape:
		fighter.LEFT_PUNCH:
			$sfx.set_stream(SFX[1])
			$sfx.play()
			animator.play("punch")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.RIGHT_PUNCH:
			$sfx.set_stream(SFX[1])
			$sfx.play()
			animator.play("punch")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.LEFT_SWEEP:
			$sfx.set_stream(SFX[2])
			$sfx.play()
			animator.play("sweep")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.RIGHT_SWEEP:
			$sfx.set_stream(SFX[2])
			$sfx.play()
			animator.play("sweep")
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.UPPER_PUNCH:
			if can_jump:
				can_jump = false
				$sfx.set_stream(SFX[3])
				$sfx.play()
				animator.play("upper")
				velocity.y = jump()
		fighter.DOWN_KICK:
			can_jump = false
			velocity.y = -(jump() * 0.8)
			$sfx.set_stream(SFX[4])
			$sfx.play()
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
			$sfx.set_stream(SFX[5])
			$sfx.play()
			animator.play("hurt")
#			tween_hurt(animator.get_current_animation_length())
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)
		fighter.DUCK:
			$sfx.set_stream(SFX[5])
			$sfx.play()
			animator.play("hurt")
#			tween_hurt(animator.get_current_animation_length())
			$health.recover(area.damage)
			if !area.animator.is_playing():
				area.queue_free()
			yield(animator, "animation_finished")
			fighter.set_state(fighter.IDLE)
			fighter.set_state(fighter.STAND)

func tween_hurt(duration):
	var initial = $cutout_sprites/belly.scale
	$tween.interpolate_property($cutout_sprites/belly, "scale", initial, initial * 1.2,
		duration/2, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield($tween, "tween_completed")
	var current = $cutout_sprites/belly.scale
	$tween.interpolate_property($cutout_sprites/belly, "scale", current, initial,
		duration/2, Tween.TRANS_QUINT, Tween.EASE_IN)
	yield($tween, "tween_completed")