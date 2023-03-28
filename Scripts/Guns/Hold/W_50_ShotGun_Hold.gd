extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'


onready var pump_timer = $Pump_Timer

var pawn

func post_set_up():
	pawn = Controllers.get_pawn(player)

func shoot_j():
	if !just_shot:
		_fire()
	else:
		anim_fire.play("Reload")
		SFX.reload(gun_num)
		just_shot = false
		can_shoot = false
		shoot_timer.start()


func spawn_shell():
	FX.shell(gun_num, pos_shell.global_position, pos_shell.global_rotation)

func _on_Pump_Timer_timeout():
	can_shoot = true