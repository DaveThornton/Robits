extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

func shoot_j():
	_fire()

func shoot_r():
	if just_shot:
		can_shoot = false
		anim_fire.play("Reload")
		shoot_timer.start()
		just_shot = false