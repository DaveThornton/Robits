extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	_fire()
	
func shoot_r():
	if just_shot:
		shell()
		just_shot = false
		can_shoot = false
		shoot_timer.start()