extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		elif ammo > 0:
			if !shoot_cast.is_colliding():
				_fire_projectile()
			else:
				var _thing = shoot_cast.get_collider()
				if _thing.get_groups().has("hittable"):
					_thing.hit(player, gun_num, dmg_type, damage)
					print_debug("gun 02 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print_debug("gun 02 hitting wall not fireing projectile", _thing)
				else:
					print_debug("gun 02 dont know what im hitting but no projectile spawned")
			shell()
			walk += walk_amount
			can_shoot = false
			shoot_timer.start()
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("AK_Shoot")
		else:
			anim_fire.play("Click")
			can_shoot = false
			shoot_timer.start()
			SFX.play("Gun_Click")
