extends Node2D

onready var back = $Back
onready var wheels = $Wheels
onready var wheels_move = $Wheel_Moves
onready var top = $Top
onready var shield = $Shield
onready var anim = $AnimationPlayer

func turn(_right:bool):
	if _right:
		anim.play("Right")
	else:
		anim.play_backwards("Right")

func stop():
	anim.stop(false)

func ladder():
	pass

func is_right(_right):
	pass
#	if _right:
#		face.scale.x = 1
#	else:
#		face.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	top.self_modulate = _pri
	back.self_modulate = _pri
	wheels_move.self_modulate = _sec
	wheels.self_modulate = _pri
	shield.self_modulate = _sec
