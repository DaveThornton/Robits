extends Node2D

onready var s01 = $Sprite01
onready var s02 = $Sprite02
onready var s03 = $Sprite03
onready var s04 = $Sprite04
onready var s05 = $Sprite05
onready var s06 = $Sprite06
onready var s07 = $Sprite07
onready var s08 = $Sprite08
onready var s09 = $Sprite09

func update_pos(_pos):
	grey_out()
	color_frame(_pos)

func color_frame(_num):
	var sq = get_square(_num)
	sq.frame += 9

func set_square(_sq, _frame):
	get_square(_sq).frame = _frame
	
func grey_out():
	s01.frame = 1
	s02.frame = 2
	s03.frame = 3
	s04.frame = 4
	s05.frame = 5
	s06.frame = 6
	s07.frame = 7
	s08.frame = 8
	s09.frame = 9

func get_square(_num):
	if _num == 1:
		return s01
	elif _num == 2:
		return s02
	elif _num == 3:
		return s03
	elif _num == 4:
		return s04
	elif _num == 5:
		return s05
	elif _num == 6:
		return s06
	elif _num == 7:
		return s07
	elif _num == 8:
		return s08
	elif _num == 9:
		return s09
	else:
		print("error in menu map campaign 3x3 invalid number in get square returning square 1      ", _num)
		return s01