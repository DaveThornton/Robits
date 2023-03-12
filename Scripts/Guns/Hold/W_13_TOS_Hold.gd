extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

# var shoot_pressed = false

func shoot():
	_fire()

# func _physics_process(_delta):

# 	if shoot_pressed && can_shoot && ammo >= 1 && !melee_cast.is_colliding():
# 		SFX.play("W_13_Shoot")
# 		var _ss = pos_shoot.global_position
# 		var _sr = pos_shoot.global_rotation
# 		if is_right:
# 			_sr = pos_shoot.global_rotation
# 		else:
# 			_sr = pos_shoot.global_rotation * -1
# 		var _sss = pos_shoot.global_scale
# 		FX.proj(gun_num, _sr, _ss, _sss, player, damage)
# 		ammo = clamp(ammo - 1, 0, ammo_max)
# 		emit_signal("ammo_change",player,ammo)
# 		Player_Stats.add_shot(player, 1)
# 		shoot_timer.start()
# 		can_shoot = false
# 	elif shoot_pressed && !can_shoot && ammo >= 1 && !melee_cast.is_colliding():
# 		var _ss = pos_shoot.global_position
# 		var _sr = pos_shoot.global_rotation
# 		if is_right:
# 			_sr = pos_shoot.global_rotation
# 		else:
# 			_sr = pos_shoot.global_rotation * -1
# 		var _sss = pos_shoot.global_scale
# 		FX.proj(gun_num, _sr, _ss, _sss, player, 0)
# 	elif shoot_pressed && melee_cast.is_colliding():
# 		melee()
# 	else:
# 		SFX.stop("W_13_Shoot")

# func shoot_j():
# 	shoot_pressed = true
# 	anim_fire.play("Shoot")

# func shoot_r():
# 	shoot_pressed = false
# 	anim_fire.play("UnShoot")
# 	SFX.stop("W_13_Shoot")

# func _hit(_pos):
# 	FX.proj_hit(gun_num, _pos, true)

# func _hit_nothing(_pos):
# 	FX.proj_hit(gun_num, _pos, false)
