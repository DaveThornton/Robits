extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite_gun = $POS_Gun/Gun_Sprite
onready var anim_state = $AnimationPlayer2

func post_set_up():
	if ammo <= 0:
		sprite_gun.frame = 1
	else:
		sprite_gun.frame = 1

func shoot_j():
	_fire()

func _fire_no_projectile():
	FX.explode(56.1, player, shoot_cast.get_collision_point(), gun_num, 0, damage)