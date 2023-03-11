extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var reload_timer = $Reload_Timer

func shoot_j():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		elif ammo > 0 :
			just_shot = true
			anim_fire.play("Shoot")
			if !shoot_cast.is_colliding():
				can_shoot = false
				shoot_timer.start()
			else:
				print_debug("to close  weap 07 crossbow")
				walk += walk_amount
				if shoot_cast.get_collider().get_groups().has("map"):
					var spot = shoot_cast.get_collision_point()
					var x = FX.stuck_bolt().instance()
					Map_Hand.add_kid_to_map(x)
					x.init(player, damage, spot, rotation, scale, 2)
					print_debug("map")
				else:
					var spot = shoot_cast.get_collision_point()
					print_debug(spot)
					var x = FX.stuck_bolt().instance()
					shoot_cast.get_collider().add_child(x)
					x.init(player, damage, spot, rotation, scale, 2)
					print_debug("not map")
			can_shoot = false
			shoot_timer.start()
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			print_debug("make cross bow have its own sound weap 07")
			SFX.play("W_07_Shoot")
		else:
			can_shoot = false
			shoot_timer.start()
			SFX.play("W_07_Empty")

func shoot_r():
	reload_timer.start()

func _on_Shoot_Timer_timeout():
	_fire_projectile()

func _on_Reload_Timer_timeout():
	if just_shot:
		anim_fire.play("Reload")
		just_shot = false
		can_shoot = true
