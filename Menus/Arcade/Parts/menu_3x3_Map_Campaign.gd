extends Node2D

onready var s01 = $Sprite1
onready var s02 = $Sprite2
onready var s03 = $Sprite3
onready var s04 = $Sprite4
onready var s05 = $Sprite5
onready var s06 = $Sprite6
onready var s07 = $Sprite7
onready var s08 = $Sprite8
onready var s09 = $Sprite9

var spot05_locked = true

var spot01 = false
var spot02 = false
var spot03 = false
var spot04 = false
var spot05 = false
var spot06 = false
var spot07 = false
var spot08 = false
var spot09 = false

func update_pos(_pos):
	grey_out()
	if !get_spot(_pos):
		color_frame(_pos)
	else:
		wreck_frame(_pos)

func wreck_frame(_num):
	var sq = get_square(_num)
	sq.frame += 20

func color_frame(_num):
	var sq = get_square(_num)
	sq.frame += 10

func set_square(_sq, _frame): get_square(_sq).frame = _frame
	
func set_spot05_locked(_locked): spot05_locked = _locked

func grey_out():
	s01.frame = 1
	s02.frame = 2
	s03.frame = 3
	s04.frame = 4
	if spot05_locked:
		s05.frame = 0
	else:
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
		print_debug("error in menu map campaign 3x3 invalid number in get square returning square 1      ", _num)
		return s01

func update_spots(spots):
	spot01 = spots[1]
	spot02 = spots[2]
	spot03 = spots[3]
	spot04 = spots[4]
	spot05 = spots[5]
	spot06 = spots[6]
	spot07 = spots[7]
	spot08 = spots[8]
	spot09 = spots[9]

func get_spot(_num):
	if _num == 1:
		return spot01
	elif _num == 2:
		return spot02
	elif _num == 3:
		return spot03
	elif _num == 4:
		return spot04
	elif _num == 5:
		return spot05
	elif _num == 6:
		return spot06
	elif _num == 7:
		return spot07
	elif _num == 8:
		return spot08
	elif _num == 9:
		return spot09
	else:
		print_debug("error in menu map campaign 3x3 invalid number in get spot returning spot 1      ", _num)
		return spot01