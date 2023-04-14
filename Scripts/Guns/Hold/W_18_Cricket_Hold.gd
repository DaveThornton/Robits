extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var ammo_01 = $POS_Gun/Gun_Sprite/Ammo_01
onready var ammo_02 = $POS_Gun/Gun_Sprite/Ammo_02
onready var ammo_03 = $POS_Gun/Gun_Sprite/Ammo_03
onready var ammo_04 = $POS_Gun/Gun_Sprite/Ammo_04

export var color_for_2_ammo = Color8(255,255,255,255)
export var color_for_1_ammo = Color8(255,255,255,255)
export var color_for_0_ammo = Color8(255,255,255,255)

var pawn

func shoot_j():
	_fire()

func post_set_up():
	pawn = Controllers.get_pawn(player)
	check_ammo()

func call_on_all_projectile_fire():
	check_ammo()
	if pawn:
		pawn.knock_back(500, .2)

func check_ammo():
	set_color(ammo_01,2)
	set_color(ammo_02,2)
	set_color(ammo_03,2)
	set_color(ammo_04,2)
	if ammo == 8:
		pass
	elif ammo == 7:
		set_color(ammo_01,1)
	elif ammo == 6:
		set_color(ammo_01,0)
	elif ammo == 5:
		set_color(ammo_01,0)
		set_color(ammo_02,1)
	elif ammo == 4:
		set_color(ammo_01,0)
		set_color(ammo_02,0)
	elif ammo == 3:
		set_color(ammo_01,0)
		set_color(ammo_02,0)
		set_color(ammo_03,1)
	elif ammo == 2:
		set_color(ammo_01,0)
		set_color(ammo_02,0)
		set_color(ammo_03,0)
	elif ammo == 1:
		set_color(ammo_01,0)
		set_color(ammo_02,0)
		set_color(ammo_03,0)
		set_color(ammo_04,1)
	elif ammo == 0:
		set_color(ammo_01,0)
		set_color(ammo_02,0)
		set_color(ammo_03,0)
		set_color(ammo_04,0)
	else:
		print_debug("error in cricket ammo shouldnt be more than 8")
	
func set_color(indicator,num):
	if num == 2:
		indicator.self_modulate = color_for_2_ammo
	elif num == 1:
		indicator.self_modulate = color_for_1_ammo
	elif num == 0:
		indicator.self_modulate = color_for_0_ammo