extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var pawn

func shoot_j():
	_fire()

func post_set_up():
	pawn = Controllers.get_pawn(player)

func call_on_all_projectile_fire():
	if pawn:
		pawn.knock_back(500, .2)
