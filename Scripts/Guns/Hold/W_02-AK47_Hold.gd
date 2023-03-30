extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite2 = $POS_Gun/Gun_Sprite/Gun_Sprite2

func shoot():
	_fire()

func post_set_up():
	check_if_zero()

func call_on_all_projectile_fire():
	check_if_zero()

func check_if_zero():
	if ammo == 0:
		sprite2.visible = false
	else:
		sprite2.visible = true