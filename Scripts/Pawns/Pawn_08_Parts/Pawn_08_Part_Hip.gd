extends Node2D

onready var anim = $AnimationPlayer
onready var hip = $Hip

func turn(right:bool):
	if right:
		anim.play("Turn")
	else:
		anim.play_backwards("Turn")

func stop():
	anim.stop(false)

func color(_color):
	hip.self_modulate = _color
