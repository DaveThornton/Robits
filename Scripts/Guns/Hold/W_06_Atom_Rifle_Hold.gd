extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	if can_shoot:
		if ammo > 0 && !shoot_cast.is_colliding():
			can_shoot = false
			shoot_timer.start()
			_fire_projectile()
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("W_06_Shoot")
			walk += walk_amount
		elif shoot_cast.is_colliding():
			
			if shoot_cast.get_collider().get_groups().has("player"):
				if shoot_cast.get_collider().player == player:
					_fire_projectile()
				else:
					can_shoot = false
					anim_fire.play("Melee")
					SFX.play("W_06_Melee")
					melee_timer.start()
		else:
			SFX.play("Laser_Empty")