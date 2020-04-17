extends Node2D

onready var head = $Head
onready var face = $Face
onready var shield = $Shield
onready var ant = $Pawn_05_Part_Ant

func is_right(_right: bool):
	if _right:
		self.scale.x = 1
	else:
		self.scale.x = -1

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	face.self_modulate = _sec
	shield.self_modulate = _sec
	ant.color(_pri, _sec)
