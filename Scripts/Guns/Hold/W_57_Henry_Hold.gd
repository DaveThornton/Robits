extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var pump_timer = $Pump_Timer

func shoot_j():
	if can_shoot:
		if !just_shot:
			_fire()
		else:
			anim_fire.play("Reload")
			just_shot = false
			can_shoot = false
			pump_timer.start()

func spawn_shell():
	FX.shell(gun_num, pos_shell.global_position, pos_shell.global_rotation)

func _on_Pump_Timer_timeout():
	can_shoot = true