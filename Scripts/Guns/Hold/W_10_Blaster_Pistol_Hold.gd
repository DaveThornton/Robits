extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	if can_shoot:
		if ammo > 0:
			can_shoot = false 
			shoot_timer.start()
			if !shoot_cast.is_colliding():
				_fire_projectile()
			else:
				var _thing = shoot_cast.get_collider()
				if _thing.get_groups().has("hittable"):
					if _thing.player == player:
						_fire_projectile()
					else:
						_thing.hit(player, gun_num, dmg_type, damage)
					print_debug("gun 10 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print_debug("gun 10 hitting wall not fireing projectile", _thing)
				else:
					print_debug("gun 10 dont know what im hitting but no projectile spawned")
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("W_10_Shoot")
			walk += walk_amount
		else:
			SFX.play("W_10_Empty")