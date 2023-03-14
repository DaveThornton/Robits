extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite_gun = $POS_Gun/Gun_Sprite
onready var anim_state = $AnimationPlayer2

func post_set_up():
	if ammo <= 0:
		sprite_gun.frame = 1
	else:
		sprite_gun.frame = 1

func shoot_j():
	_fire()
	# if can_shoot:
	# 	print_debug("i can shoot so whats the problem")
	# 	if melee_cast.is_colliding():
	# 		if melee_cast.get_collider().get_groups().has("player"):
	# 			if melee_cast.get_collider().player == player:
	# 				fire_projectile()
	# 			else:
	# 				melee()
	# 		else:
	# 			melee()
	# 	elif ammo > 0:
	# 		fire_projectile()

# func fire_projectile():
# 	if !shoot_cast.is_colliding():
# 		var _ss = pos_shoot.global_position
# 		var _sr = pos_shoot.global_rotation
# 		if is_right:
# 			_sr = pos_shoot.global_rotation
# 		else:
# 			_sr = pos_shoot.global_rotation * -1
# 		var _sss = pos_shoot.global_scale
# 		FX.proj(gun_num, _sr, _ss, _sss, player, damage)
# 	else:
# 		FX.explode(56.1, player, shoot_cast.get_collision_point(), gun_num, 0, damage)
# 	SFX.play("W_56_Shoot")
# 	ammo = clamp(ammo - 1, 0, ammo_max)
# 	sprite_gun.frame = 1
# 	emit_signal("ammo_change",player,ammo)
# 	Player_Stats.add_shot(player, 1)
# 	can_shoot = false
# 	shoot_timer.start()

func _fire_no_projectile():
	FX.explode(56.1, player, shoot_cast.get_collision_point(), gun_num, 0, damage)