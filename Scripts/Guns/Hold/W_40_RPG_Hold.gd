extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite_gun = $POS_Gun/Gun_Sprite

func post_set_up():
	_tip_update()

func shoot_j():
	_fire()

func _fire_sound(): pass

func call_on_all_projectile_fire(): _tip_update()

func _tip_update():
	if ammo > 0:
		sprite_gun.frame = 0
	else:
		sprite_gun.frame = 1