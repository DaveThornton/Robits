extends Node2D

onready var head = $Head
onready var face = $Face
onready var shield = $Shield

func face_on(_face:bool):
	if _face:
		face.frame = 0
	else:
		face.frame = 1

func is_right(_right: bool):
	if _right == true:
		face.scale.x = 1
	else:
		face.scale.x = -1

func shield_up():
	shield.visible = true
 
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	shield.self_modulate = _sec
	face.self_modulate = _sec
