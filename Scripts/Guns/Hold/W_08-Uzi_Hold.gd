extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var walk_count = 0

func shoot():
	_fire()

func end_of_fire():
	anim_fire.play("Shoot")
	if use_ammo:
		ammo = clamp(ammo - 1, 0, ammo_max)
	emit_signal("ammo_change",player,ammo)
	Player_Stats.add_shot(player, 1)
	walk = walk_where()
	_fire_sound()
	if eject_shell:
		shell()
	call_on_projectile_fired()

func walk_where():
	walk_count += 1
	match walk_count:
		0: return walk_amount * 3
		1: return -walk_amount * 2
		2: return -walk_amount * 1.5
		3: return walk_amount * 2
		4: return -walk_amount * 3
		5: return 0
		6: return walk_amount
		7: return -walk_amount * 2
		8: 
			walk_count = -1
			return walk_amount * 2.2

func shoot_r():
	walk_count = -1