extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var how_many_burst = 3
var burst = 0

func shoot():
	_fire()

func call_on_projectile_fired():
	burst += 1
	if burst > (how_many_burst - 1):
		stop_shoot = true

func shoot_r():
	burst = 0
	stop_shoot = false