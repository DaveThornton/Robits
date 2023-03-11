extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var how_many_burst = 3
var burst = 0
var color_change = 0

func shoot():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		elif ammo > 0 && burst <= (how_many_burst - 1):
			if !shoot_cast.is_colliding():
				var _ss = pos_shoot.global_position
				var _sr = pos_shoot.global_rotation
				#---------------------------------------------------------------
				print_debug(is_right)
				if is_right:
					_sr = pos_shoot.global_rotation
				else:
					_sr = pos_shoot.global_rotation * -1
				#---------------------------------------------------------------
				var _sss = pos_shoot.global_scale
				FX.proj(gun_num, _sr, _ss, _sss, player, damage)
				color_change += 1
				if color_change == 3:
					color_change = 0
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
			# FX.shell(gun_num, pos_shell.global_position, pos_shell.global_rotation)
			burst += 1
			walk += walk_amount
			can_shoot = false
			shoot_timer.start()
			anim_fire.play("Fire")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("AK_Shoot")
		elif ammo > 0 && burst > (how_many_burst - 1):
			pass
		elif ammo <= 0:
			can_shoot = false
			shoot_timer.start()
			SFX.play("Gun_Click")
		else:
			print_debug("W04 M16 error while shooting else : what is going on. Ammo: ", ammo,"   burst: ", burst)

func shoot_r():
	burst = 0
	can_shoot = true