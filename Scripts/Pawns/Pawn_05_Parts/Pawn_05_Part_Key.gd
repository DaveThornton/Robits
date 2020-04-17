extends Node2D

onready var anim = $AnimationPlayer
onready var shield = $Sprite2
onready var key = $Sprite

func turn(right:bool):
	if right:
		anim.play("Turn")
	else:
		anim.play_backwards("Turn")

func ladder():
	anim.play("Ladder")

func stop():
	anim.stop(false)

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	key.self_modulate = _pri
	shield.self_modulate = _sec
