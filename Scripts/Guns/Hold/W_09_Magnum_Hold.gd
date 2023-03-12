extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var shot_count = 0

func shoot_j():
	_fire()

func call_on_all_projectile_fire():
	shot_count += 1
	if shot_count == 6:
		shot_count = 0
		shell()
		shell()
		shell()
		shell()
		shell()
		shell()