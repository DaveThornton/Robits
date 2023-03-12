extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	_fire()

func shoot_r():
	can_shoot = true

func post_set_up():
	ammo = 1