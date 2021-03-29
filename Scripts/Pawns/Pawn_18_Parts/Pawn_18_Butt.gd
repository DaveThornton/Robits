extends Node2D

onready var butt = $Pawn_18_Butt
onready var butt_top = $Pawn_18_Butt_Top
onready var shield = $Pawn_18_Shield

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	butt.self_modulate = _pri
	butt_top.self_modulate = _sec
	shield.self_modulate = _sec

