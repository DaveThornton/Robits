extends Node2D

export var player = 1
export var pos = 5

onready var s01 = $Sprite01
onready var s02 = $Sprite02
onready var s03 = $Sprite03
onready var s04 = $Sprite04
onready var s05 = $Sprite05
onready var s06 = $Sprite06
onready var s07 = $Sprite07
onready var s08 = $Sprite08
onready var s09 = $Sprite09

func _ready():
	modulate = Player_Stats.get_body_color(player)
	update_from_pos()

func get_pos():
	return pos

func move_up():
	if pos == 1 || pos == 2 || pos == 3:
		cant_move_sound()
	else:
		pos -= 4
		move_sound()
		update_from_pos()

func move_down():
	if pos == 7 || pos == 8 || pos == 9:
		cant_move_sound()
	else:
		pos += 4
		move_sound()
		update_from_pos()

func move_left():
	if pos == 1 || pos == 4 || pos == 7:
		cant_move_sound()
	else:
		pos -= 1
		move_sound()
		update_from_pos()

func move_right():
	if pos == 3 || pos == 6 || pos == 9:
		cant_move_sound()
	else:
		pos += 1
		move_sound()
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
	else:
		print("error in menu 3x3 invalid pos so going with pos 1 when its asking for  ", pos)
		sq01()

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

func move_sound():
	SFX.play("Menu_Move_01")

func cant_move_sound():
	SFX.play("Menu_Error_02")
