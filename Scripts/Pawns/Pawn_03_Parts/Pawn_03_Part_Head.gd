extends Node2D
onready var head = $Head
onready var face1 = $Head/Face_01
onready var face2 = $Head/Face_02
onready var shield = $Head/Shield

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func is_right(_right: bool):
	if _right == true:
		face1.scale.x = 1
		face2.scale.x = 1
	else:
		face1.scale.x = -1
		face2.scale.x = -1

func pos(_pos):
	if _pos == 1:
		face1.frame = 0
		face2.frame = 0
	elif _pos == 2:
		face1.frame = 1
		face2.frame = 1
	elif _pos == 3 || _pos == 6:
		face1.frame = 2
		face2.frame = 2
	elif _pos == 4 || _pos == 5:
		face1.frame = 3
		face2.frame = 3

func color(_pri: Color, _sec: Color):
	shield.self_modulate = _sec
	head.self_modulate = _pri
	face1.self_modulate = _pri
	face2.self_modulate = _sec
