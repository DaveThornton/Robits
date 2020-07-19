extends Node2D

onready var head = $Pawn_10_Part_Head
onready var face = $Pawn_10_Part_Head/Pawn_10_Part_Face
onready var shield = $Shield

func is_right(_right: bool):
	if _right:
		face.scale.x = 1
	else:
		face.scale.x = -1

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	face.self_modulate = _sec
	shield.self_modulate = _sec
