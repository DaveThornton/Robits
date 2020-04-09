extends Node2D

onready var anim = $AnimationPlayer
onready var hip = $Hip
onready var sec = $Pawn_08_Part_Hip_Sec

func turn(right:bool):
	if right:
		anim.play("Turn")
	else:
		anim.play_backwards("Turn")

func stop():
	anim.stop(false)

func color(_color_main, _color_sec):
	hip.self_modulate = _color_main
	sec.self_modulate = _color_sec
