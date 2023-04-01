extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite2 = $POS_Gun/Gun_Sprite/Sprite2

var how_many_burst = 3
var burst = 0

func shoot():
	_fire()

func post_set_up():
	mag_visible(bool(ammo > 0))

func call_on_projectile_fired():
	burst += 1
	if burst > (how_many_burst - 1):
		stop_shoot = true
	if ammo == 0:
		mag_visible(false)

func end_add_ammo(_ammo):
	if ammo > 0:
		mag_visible(true)

func mag_visible(_vis):
	sprite2.visible = _vis

func shoot_r():
	burst = 0
	stop_shoot = false