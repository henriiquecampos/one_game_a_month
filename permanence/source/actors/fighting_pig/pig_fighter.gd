extends "res://actors/platform_actors/player_character.gd"

onready var animator = $cutout_sprites/animator
onready var fighter = $player_fighter
func _on_kinematic_state_changed(from, to):
	match to:
		JUMP:
			fighter.set_state(fighter.IN_AIR)
		FALL:
			animator.play("fall")
		IDLE:
			fighter.set_state(fighter.ON_GROUND)
			animator.play("idle")

func _on_fighting_state_changed(from, to):
	match from:
		fighter.IN_AIR:
			match to:
				fighter.ATTACK:
					animator.play("upper")
					velocity.y += jump()
				fighter.ON_GROUND:
					animator.play("idle")
					
		fighter.ON_GROUND:
			match to:
				fighter.ATTACK:
					animator.play("punch")
				fighter.DEFENSE:
					animator.play("duck")
				fighter.IN_AIR:
					animator.play("jump")
		fighter.DEFENSE:
			match to:
				fighter.ATTACK:
					animator.play("sweep")
					yield(animator, "animation_finished")
					animator.play("idle")
				fighter.IN_AIR:
					animator.play("upper")
					
		fighter.ATTACK:
			match to:
				fighter.ON_GROUND:
						animator.play("idle")
						
	match to:
		fighter.ATTACK:
			yield(animator, "animation_finished")
			fighter.set_state(fighter.ON_GROUND)
		fighter.ON_GROUND:
			animator.play("idle")

func _on_fighter_shape_entered(area_id, area, area_shape, self_shape):
	if fighter.get_child(self_shape) == $player_fighter/right_punch or \
		fighter.get_child(self_shape) == $player_fighter/left_punch:
		area.get_hit()
			
