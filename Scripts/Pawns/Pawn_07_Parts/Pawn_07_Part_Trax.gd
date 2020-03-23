extends Node2D

onready var anim = $Animation
onready var shield = $Sprite2
onready var trax = $Sprite

func turn(right:bool):
	anim.play("Turn")
	if right:
		trax.scale.x = 1
		shield.scale.x = 1
	else:
		trax.scale.x = -1
		shield.scale.x = -1

func ladder():
	anim.play("Ladder_Up")

func stop():
	anim.stop(false)

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func shield_color(_color):
	shield.self_modulate = _color

func color(_color):
	trax.self_modulate = _color
