extends Node2D

onready var anim = $AnimationPlayer
onready var hub = $Pawn_15_Hub_01
onready var sec = $Pawn_15_Hub_02

func turn(right:bool):
	if right:
		anim.play("Turn")
	else:
		anim.play_backwards("Turn")

func stop():
	anim.stop(false)

func color(_pri, _sec):
	hub.self_modulate = _pri
	sec.self_modulate = _sec
