extends RigidBody2D

export var set_trash = false
export var number_set = 0

onready var sprite = $Sprite
onready var timer = $Timer
onready var cs00 = $col_2d_00
onready var cs01 = $col_2d_01
onready var cs02 = $col_2d_02
onready var cs03 = $col_2d_03
onready var cs04 = $col_2d_04
onready var cs05 = $col_2d_05
onready var cs06 = $col_2d_06
onready var cs07 = $col_2d_07
onready var cs08 = $col_2d_08
onready var cs09 = $col_2d_09
onready var cs10 = $col_2d_10
onready var cs11 = $col_2d_11
onready var cs12 = $col_2d_12
onready var cs13 = $col_2d_13
onready var cs14 = $col_2d_14
onready var cs15 = $col_2d_15
onready var cs16 = $col_2d_16
onready var cs17 = $col_2d_17
onready var cs18 = $col_2d_18
onready var cs19 = $col_2d_19
onready var cs20 = $col_2d_20

func _ready():
	if set_trash:
		sprite.frame = number_set
		set_num(number_set)

func init(_num, _pos, _impulse, _time_out):
	timer.wait_time = _time_out
	sprite.frame = _num
	timer.start()
	position = _pos
	apply_impulse(Vector2(),_impulse)
	set_num(_num)

func set_num(_num):
	if _num == 00:
		cs00.disabled = false
	elif _num == 01:
		cs01.disabled = false
	elif _num == 02:
		cs02.disabled = false
	elif _num == 03:
		cs03.disabled = false
	elif _num == 04:
		cs04.disabled = false
	elif _num == 05:
		cs05.disabled = false
	elif _num == 06:
		cs06.disabled = false
	elif _num == 07:
		cs07.disabled = false
	elif _num == 08:
		cs08.disabled = false
	elif _num == 09:
		cs09.disabled = false
	elif _num == 10:
		cs10.disabled = false
	elif _num == 11:
		cs11.disabled = false
	elif _num == 12:
		cs12.disabled = false
	elif _num == 13:
		cs13.disabled = false
	elif _num == 14:
		cs14.disabled = false
	elif _num == 15:
		cs15.disabled = false
	elif _num == 16:
		cs16.disabled = false
	elif _num == 17:
		cs17.disabled = false
	elif _num == 18:
		cs18.disabled = false
	elif _num == 19:
		cs19.disabled = false
	elif _num == 20:
		cs20.disabled = false

func _on_Timer_timeout():
	call_deferred("free")
