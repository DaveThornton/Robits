extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	_fire()

func shoot_r():
	can_shoot = true

func call_on_projectile_fired():
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	var _sss = pos_shoot.global_scale
	FX.proj(gun_num, _sr - .2 , _ss, _sss, player, damage)
	FX.proj(gun_num, _sr - .1 , _ss, _sss, player, damage)
	FX.proj(gun_num, _sr + .1 , _ss, _sss, player, damage)
	FX.proj(gun_num, _sr + .2 , _ss, _sss, player, damage)

func call_on_hit_with_no_projectile(_thing):
	if _thing.get_groups().has("hittable"):
		_thing.hit(player, gun_num, dmg_type, (damage * 4))

func empty():
	anim_fire.play("Click")
	SFX.empty(gun_num)