extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite2 = $POS_Gun/Gun_Sprite/Gun_Sprite2

func shoot():
	_fire()

func post_set_up():
	mag_visible(bool(ammo > 0))

func call_on_all_projectile_fire():
	mag_visible(bool(ammo > 0))

func call_on_projectile_fired():
	if ammo == 0:
		mag_visible(false)

func end_add_ammo(_ammo):
	if ammo < 0:
		mag_visible(true)

func mag_visible(_vis):
	sprite2.visible = _vis