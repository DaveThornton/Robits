extends Node2D

export var player = 1
export var pos = 6

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

func _ready():
	update_from_pos()

func move_up():
	if pos == 1 || pos == 2 || pos == 3 || pos == 4:
		print("cant move up")
		pass
	else:
		pos -= 4
		update_from_pos()

func move_down():
	if pos == 13 || pos == 14 || pos == 15 || pos == 16:
		pass
	else:
		pos += 4
		update_from_pos()

func move_left():
	if pos == 1 || pos == 5 || pos == 9 || pos == 13:
		pass
	else:
		pos -= 1
		update_from_pos()

func move_right():
	if pos == 4 || pos == 8 || pos == 12 || pos == 16:
		pass
	else:
		pos += 1
		update_from_pos()

func update_from_pos():
	if pos == 1:
		sq01()
	if pos == 2:
		sq02()
	if pos == 3:
		sq03()
	if pos == 4:
		sq04()
	if pos == 5:
		sq05()
	if pos == 6:
		sq06()
	if pos == 7:
		sq07()
	if pos == 8:
		sq08()
	if pos == 9:
		sq09()
	if pos == 10:
		sq10()
	if pos == 11:
		sq11()
	if pos == 12:
		sq12()
	if pos == 13:
		sq13()
	if pos == 14:
		sq14()
	if pos == 15:
		sq15()
	if pos == 16:
		sq16()


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