extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var ammo_01 = $Sprite/Ammo_01
onready var ammo_02 = $Sprite/Ammo_02
onready var ammo_03 = $Sprite/Ammo_03
onready var ammo_04 = $Sprite/Ammo_04

export var color_for_2_ammo = Color8(255,255,255,255)
export var color_for_1_ammo = Color8(255,255,255,255)
export var color_for_0_ammo = Color8(255,255,255,255)

func _on_WeapPick10Blaster_Pistol_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)

func call_end_init():
	check_ammo()

func set_right():
	if sprite.scale.y < 0:
		sprite.scale.y *= -1

func set_left():
	if sprite.scale.y > 0:
		sprite.scale.y *= -1

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