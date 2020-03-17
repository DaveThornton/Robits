extends Node2D

onready var anim = $AnimationPlayer
onready var shield = $Sprite2
onready var wheel = $Sprite

var on_floor = true

func turn(right:bool):
	if on_floor:
		if right:
			anim.play("Spin_Ground")
		else:
			anim.play_backwards("Spin_Ground")
	else:
		if right:
			anim.play("Spin_Air")
		else:
			anim.play_backwards("Spin_Air")

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
	wheel.self_modulate = _color
