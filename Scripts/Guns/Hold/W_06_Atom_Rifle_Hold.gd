extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var tank = $POS_Gun/Gun_Sprite/Tank
onready var tank_anim = $POS_Gun/Gun_Sprite/Tank/AnimationPlayer

func shoot_j(): _fire()

func call_on_hit_with_no_projectile(_thing): _thing.stun(6)


func post_set_up():
    tank_anim.play("Tank_Idle")
    mag_visible(bool(ammo > 0))

func call_on_all_projectile_fire():
	mag_visible(bool(ammo > 0))

func call_on_projectile_fired():
    mag_visible(bool(ammo > 0))
	# if ammo == 0:
	# 	mag_visible(false)

func end_add_ammo(_ammo):
    mag_visible(bool(ammo > 0))
	# if ammo < 0:
	# 	mag_visible(true)

func mag_visible(_vis):
	tank.visible = _vis