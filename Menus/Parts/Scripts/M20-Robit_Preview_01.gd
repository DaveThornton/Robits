extends Node2D

onready var pawn_01 = $Pawn_01_Pic
onready var pawn_02 = $Pawn_18_Pic
onready var pawn_03 = $Pawn_03_Pic
onready var pawn_04 = $Pawn_17_Pic
onready var pawn_05 = $Pawn_05_Pic
onready var pawn_06 = $Pawn_06_Pic
onready var pawn_07 = $Pawn_07_Pic
onready var pawn_08 = $Pawn_16_Pic
onready var pawn_09 = $Pawn_09_Pic
onready var pawn_10 = $Pawn_10_Pic
onready var pawn_11 = $Pawn_11_Pic
onready var pawn_12 = $Pawn_12_Pic
onready var pawn_13 = $Pawn_13_Pic
onready var pawn_14 = $Pawn_14_Pic
onready var pawn_15 = $Pawn_15_Pic
onready var pawn_rand = $Random_Pawn_Pic
onready var outline = $AnimatedSprite
export var player = 1

func _ready():
	var _pri = Player_Stats.get_body_color(player)
	var _sec = Player_Stats.get_sec_color(player)
	outline.modulate = _pri
	pawn_01.color(_pri, _sec)
	pawn_02.color(_pri, _sec)
	pawn_03.color(_pri, _sec)
	pawn_04.color(_pri, _sec)
	pawn_05.color(_pri, _sec)
	pawn_06.color(_pri, _sec)
	pawn_07.color(_pri, _sec)
	pawn_08.color(_pri, _sec)
	pawn_09.color(_pri, _sec)
	pawn_10.color(_pri, _sec)
	pawn_11.color(_pri, _sec)
	pawn_12.color(_pri, _sec)
	pawn_13.color(_pri, _sec)
	pawn_14.color(_pri, _sec)
	pawn_15.color(_pri, _sec)
	pawn_rand.color(_pri, _sec)

func set_pic(_pawn: int):
	if _pawn < 17:
		all_off()
		if _pawn == 1:
			pawn_01.visible = true
		elif _pawn == 2:
			pawn_02.visible = true
		elif _pawn == 3:
			pawn_03.visible = true
		elif _pawn == 4:
			pawn_04.visible = true
		elif _pawn == 5:
			pawn_05.visible = true
		elif _pawn == 6:
			pawn_06.visible = true
		elif _pawn == 7:
			pawn_07.visible = true
		elif _pawn == 8:
			pawn_08.visible = true
		elif _pawn == 9:
			pawn_09.visible = true
		elif _pawn == 10:
			pawn_10.visible = true
		elif _pawn == 11:
			pawn_11.visible = true
		elif _pawn == 12:
			pawn_12.visible = true
		elif _pawn == 13:
			pawn_13.visible = true
		elif _pawn == 14:
			pawn_14.visible = true
		elif _pawn == 15:
			pawn_15.visible = true
		elif _pawn == 16:
			pawn_rand.visible = true
	else:
		print_debug("error in Robit preview bad pawn number")

func all_off():
	pawn_01.visible = false
	pawn_02.visible = false
	pawn_03.visible = false
	pawn_04.visible = false
	pawn_05.visible = false
	pawn_06.visible = false
	pawn_07.visible = false
	pawn_08.visible = false
	pawn_09.visible = false
	pawn_10.visible = false
	pawn_11.visible = false
	pawn_12.visible = false
	pawn_13.visible = false
	pawn_14.visible = false
	pawn_15.visible = false
	pawn_rand.visible = false
