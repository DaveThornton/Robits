extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var ex_num = 25

func post_set_up():
	explode_num = ex_num
	if ammo <= 0:
		anim_fire.play("Armed")
		anim_fire.seek(4 - time, true)	

func shoot_r():
	if can_shoot:
		if ammo > 0:
			can_shoot = false
			ammo = 0
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)
			anim_fire.play("Armed")
