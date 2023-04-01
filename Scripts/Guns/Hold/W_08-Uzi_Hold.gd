extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite2 = $POS_Gun/Gun_Sprite/Clip

var walk_count = 0

func post_set_up():
	mag_visible(bool(ammo > 0))

func shoot():
	_fire()

func call_on_all_projectile_fire():
	walk = walk_where()
	mag_visible(bool(ammo > 0))

func call_on_projectile_fired():
	mag_visible(bool(ammo > 0))

func walk_where():
	walk_count += 1
	match walk_count:
		0: return walk_amount * 3
		1: return -walk_amount * 2
		2: return -walk_amount * 1.5
		3: return walk_amount * 2
		4: return -walk_amount * 3
		5: return 0
		6: return walk_amount
		7: return -walk_amount * 2
		8: 
			walk_count = -1
			return walk_amount * 2.2

func shoot_r():
	walk_count = -1

func end_add_ammo(_ammo):
	if ammo > 0:
		mag_visible(true)

func mag_visible(_vis):
	sprite2.visible = _vis