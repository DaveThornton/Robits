extends Node2D

export var player = 1
export var pos = 1

onready var s01 = $Sprite01
onready var s02 = $Sprite02
onready var s03 = $Sprite03
onready var s04 = $Sprite04
onready var s05 = $Sprite05
onready var s06 = $Sprite06
onready var s07 = $Sprite07
onready var s08 = $Sprite08
onready var s09 = $Sprite09
onready var s10 = $Sprite10
onready var s11 = $Sprite11
onready var s12 = $Sprite12
onready var s13 = $Sprite13
onready var s14 = $Sprite14
onready var s15 = $Sprite15
onready var s16 = $Sprite16
onready var s17 = $Sprite17
onready var s18 = $Sprite18
onready var s19 = $Sprite19
onready var s20 = $Sprite20
onready var s21 = $Sprite21
onready var s22 = $Sprite22
onready var s23 = $Sprite23
onready var s24 = $Sprite24

func _ready():
	update_from_pos()

func move_up():
	if pos == 1 || pos == 2 || pos == 3 || pos == 4 || pos == 5 || pos == 6 || pos == 7 || pos == 8:
#		print("cant move up")
		pass
	else:
		pos -= 8
		update_from_pos()

func move_down():
	if pos == 17 || pos == 18 || pos == 19 || pos == 20 ||pos == 21 || pos == 22 || pos == 23 || pos == 24:
		pass
	else:
		pos += 8
		update_from_pos()

func move_left():
	if pos == 1 || pos == 8 || pos == 17:
		pass
	else:
		pos -= 1
		update_from_pos()

func move_right():
	if pos == 9 || pos == 16 || pos == 24:
		pass
	else:
		pos += 1
		update_from_pos()

func update_from_pos():
	if pos == 1:
		sq01()
	elif pos == 2:
		sq02()
	elif pos == 3:
		sq03()
	elif pos == 4:
		sq04()
	elif pos == 5:
		sq05()
	elif pos == 6:
		sq06()
	elif pos == 7:
		sq07()
	elif pos == 8:
		sq08()
	elif pos == 9:
		sq09()
	elif pos == 10:
		sq10()
	elif pos == 11:
		sq11()
	elif pos == 12:
		sq12()
	elif pos == 13:
		sq13()
	elif pos == 14:
		sq14()
	elif pos == 15:
		sq15()
	elif pos == 16:
		sq16()
	elif pos == 17:
		sq17()
	elif pos == 18:
		sq18()
	elif pos == 19:
		sq19()
	elif pos == 20:
		sq20()
	elif pos == 21:
		sq21()
	elif pos == 22:
		sq22()
	elif pos == 23:
		sq23()
	elif pos == 24:
		sq24()
	else:
		print("error in pos number menu 8 x 3 number higher than 24 or lower than 1 invalid")

func sq01():
	blank_squares()
	s01.frame = player
func sq02():
	blank_squares()
	s02.frame = player
func sq03():
	blank_squares()
	s03.frame = player
func sq04():
	blank_squares()
	s04.frame = player
func sq05():
	blank_squares()
	s05.frame = player
func sq06():
	blank_squares()
	s06.frame = player
func sq07():
	blank_squares()
	s07.frame = player
func sq08():
	blank_squares()
	s08.frame = player
func sq09():
	blank_squares()
	s09.frame = player
func sq10():
	blank_squares()
	s10.frame = player
func sq11():
	blank_squares()
	s11.frame = player
func sq12():
	blank_squares()
	s12.frame = player
func sq13():
	blank_squares()
	s13.frame = player
func sq14():
	blank_squares()
	s14.frame = player
func sq15():
	blank_squares()
	s15.frame = player
func sq16():
	blank_squares()
	s16.frame = player
func sq17():
	blank_squares()
	s17.frame = player
func sq18():
	blank_squares()
	s18.frame = player
func sq19():
	blank_squares()
	s19.frame = player
func sq20():
	blank_squares()
	s20.frame = player
func sq21():
	blank_squares()
	s21.frame = player
func sq22():
	blank_squares()
	s22.frame = player
func sq23():
	blank_squares()
	s23.frame = player
func sq24():
	blank_squares()
	s24.frame = player


func blank_squares():
	s01.frame = 0
	s02.frame = 0
	s03.frame = 0
	s04.frame = 0
	s05.frame = 0
	s06.frame = 0
	s07.frame = 0
	s08.frame = 0
	s09.frame = 0
	s10.frame = 0
	s11.frame = 0
	s12.frame = 0
	s13.frame = 0
	s14.frame = 0
	s15.frame = 0
	s16.frame = 0