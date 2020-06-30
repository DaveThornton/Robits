extends HBoxContainer
onready var pawn00 = $Pawn00
onready var pawn01 = $Pawn01
onready var pawn02 = $Pawn02
onready var pawn03 = $Pawn03
onready var pawn04 = $Pawn04
onready var pawn05 = $Pawn05
onready var pawn06 = $Pawn06
onready var pawn07 = $Pawn07
onready var pawn08 = $Pawn08
onready var pawn09 = $Pawn09
onready var pawn10 = $Pawn10
onready var pawn11 = $Pawn11
onready var pawn12 = $Pawn12
onready var pawn13 = $Pawn13
onready var pawn14 = $Pawn14
onready var pawn15 = $Pawn15
onready var pawn16 = $Pawn16

var pos = 9

func init():
	new_pos(pos)

func go_right():
	new_pos(pos + 1)
	
func go_left():
	new_pos(pos - 1)

func go_start():
	print('m77 in game pawn menu go start')
	return pos

func start():
	return pos

func new_pos(_pos):
	print("m77 in game pawn menu -- new pos = ", _pos)
	if _pos > 16:
		pos = 0
	elif _pos < 0:
		pos = 16
	else:
		pos = _pos
	print("m77 in game pawn menu -- new pos = ", pos)
	all_out()
	if pos == 0:
		pawn00.visible = true
	elif pos == 1:
		pawn01.visible = true
	elif pos == 2:
		pawn02.visible = true
	elif pos == 3:
		pawn03.visible = true
	elif pos == 4:
		pawn04.visible = true
	elif pos == 5:
		pawn05.visible = true
	elif pos == 6:
		pawn06.visible = true
	elif pos == 7:
		pawn07.visible = true
	elif pos == 8:
		pawn08.visible = true
	elif pos == 9:
		pawn09.visible = true
	elif pos == 10:
		pawn10.visible = true
	elif pos == 11:
		pawn11.visible = true
	elif pos == 12:
		pawn12.visible = true
	elif pos == 13:
		pawn13.visible = true
	elif pos == 14:
		pawn14.visible = true
	elif pos == 15:
		pawn15.visible = true
	elif pos == 16:
		pawn16.visible = true

func all_out():
	pawn00.visible = false
	pawn01.visible = false
	pawn02.visible = false
	pawn03.visible = false
	pawn04.visible = false
	pawn05.visible = false
	pawn06.visible = false
	pawn07.visible = false
	pawn08.visible = false
	pawn09.visible = false
	pawn10.visible = false
	pawn11.visible = false
	pawn12.visible = false
	pawn13.visible = false
	pawn14.visible = false
	pawn15.visible = false
	pawn16.visible = false
