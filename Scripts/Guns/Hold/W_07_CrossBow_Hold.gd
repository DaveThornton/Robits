extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var reload_timer = $Reload_Timer

func shoot_j():
	_fire()

func shoot_r():
	reload_timer.start()

func _on_Reload_Timer_timeout():
	if just_shot:
		anim_fire.play("Reload")
		just_shot = false
		can_shoot = true