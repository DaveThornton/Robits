extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var ammo_01 = $Sprite/Ammo_01
onready var ammo_02 = $Sprite/Ammo_02
onready var ammo_03 = $Sprite/Ammo_03
onready var ammo_04 = $Sprite/Ammo_04
onready var ammo_05 = $Sprite/Ammo_05

func call_end_init():
	ammo_update()

func _on_WeapPick03Sniper_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)

func set_right():
	if sprite.scale.y < 0:
		sprite.scale.y *= -1

func set_left():
	if sprite.scale.y > 0:
		sprite.scale.y *= -1

func ammo_update():
	ammo_01.visible = false
	ammo_02.visible = false
	ammo_03.visible = false
	ammo_04.visible = false
	ammo_05.visible = false
	if ammo >= 5:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
		ammo_04.visible = true
		ammo_05.visible = true
	elif ammo >= 4:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
		ammo_04.visible = true
	elif ammo >= 3:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
	elif ammo >= 2:
		ammo_01.visible = true
		ammo_02.visible = true
	elif ammo >= 1:
		ammo_01.visible = true