extends Node2D

export var player = 1
export var pos = 5

onready var s01 = $Sprite1
onready var s02 = $Sprite2
onready var s03 = $Sprite3
onready var s04 = $Sprite4
onready var s05 = $Sprite5
onready var s06 = $Sprite6
onready var s07 = $Sprite7
onready var s08 = $Sprite8
onready var s09 = $Sprite9

signal pos_updated

func _ready():
	# modulate = Player_Stats.get_body_color(player)
	var test1 = connect("pos_updated",get_parent(),"update_pos")
	if test1 != 0:
		print("error in arcade map select campaign connect update pos in menu 3x3")
	call_deferred("start")
	
func start():
	update_from_pos()

func get_pos():
	return pos

func move_up():
	if pos == 1 || pos == 2 || pos == 3:
		cant_move_sound()
	else:
		pos -= 3
		move_sound()
		update_from_pos()

func move_down():
	if pos == 7 || pos == 8 || pos == 9:
		cant_move_sound()
	else:
		pos += 3
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
	emit_signal("pos_updated",pos)

func sq01():
	blank_squares()
	s01.frame = 2
func sq02():
	blank_squares()
	s02.frame = 2
func sq03():
	blank_squares()
	s03.frame = 2
func sq04():
	blank_squares()
	s04.frame = 2
func sq05():
	blank_squares()
	s05.frame = 2
func sq06():
	blank_squares()
	s06.frame = 2
func sq07():
	blank_squares()
	s07.frame = 2
func sq08():
	blank_squares()
	s08.frame = 2
func sq09():
	blank_squares()
	s09.frame = 2

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
