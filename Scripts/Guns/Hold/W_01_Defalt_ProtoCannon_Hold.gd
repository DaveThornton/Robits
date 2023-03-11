extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	if can_shoot:
		can_shoot = false 
		shoot_cast.force_raycast_update()
		if !shoot_cast.is_colliding():
			_fire_projectile()
		else:
			var _thing = shoot_cast.get_collider()
			if _thing.get_groups().has("hittable"):
				if _thing.get_groups().has("player") && _thing.player == player:
					_fire_projectile()
				else:
					_thing.hit(player, gun_num, dmg_type, damage)
				print_debug("gun 00 shot happened but no projectile spawned hit anyways")
			elif _thing.get_groups().has("map"):
				print_debug("gun 00 hitting wall not fireing projectile", _thing)
			else:
				print_debug("gun 00 dont know what im hitting but no projectile spawned")
		anim_fire.play("Shoot")
		Player_Stats.add_shot(player, 1)
		SFX.play("W_11_Shoot")
		walk += walk_amount
	else:
		SFX.play("W_11_Empty")

func shoot_r():
	can_shoot = true