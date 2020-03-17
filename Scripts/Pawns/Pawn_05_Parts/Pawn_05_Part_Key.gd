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

func shield_color(_color):
	shield.self_modulate = _color

func color(_color):
	key.self_modulate = _color
