extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var particles = $POS_Gun/Gun_Sprite/CPUParticles2D
onready var sprite_red = $POS_Gun/Gun_Sprite/Sprite

var clicked = false 

func post_set_up():
	if ammo == 0:
		red_vis(false)

func shoot():
	_fire()

func empty():
	if !clicked:
		SFX.empty(gun_num)
		clicked = true
		red_vis(false)

func end_add_ammo(_ammo):
	if ammo > 0:
		red_vis(true)

func shoot_r():
	clicked = false

func red_vis(_vis):
	sprite_red.visible = _vis