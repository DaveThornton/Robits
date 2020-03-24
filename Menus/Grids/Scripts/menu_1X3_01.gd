extends Node2D

onready var s01 = $Box_01
onready var s02 = $Box_02
onready var s03 = $Box_03

var pos = 2

func _ready():
	update_from_pos()

func move_up():
	if pos == 1:
		cant_move_sound()
	else:
		pos -= 1
		move_sound()
		update_from_pos()

func move_down():
	if pos == 3:
		cant_move_sound()
	else:
		move_sound()
		pos += 1
		update_from_pos()

func move_left():
	pass

func move_right():
	pass

func update_from_pos():
	if pos == 1:
		sq01()
	if pos == 2:
		sq02()
	if pos == 3:
		sq03()
		
func sq01():
	blank_squares()
	s01.visible = true

func sq02():
	blank_squares()
	s02.visible = true

func sq03():
	blank_squares()
	s03.visible = true

func blank_squares():
	s01.visible = false
	s02.visible = false
	s03.visible = false

func move_sound():
	SFX.play("Menu_Move_01")

func cant_move_sound():
	SFX.play("Menu_Error_02")
