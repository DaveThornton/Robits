extends Node2D

onready var wheel = $Wheel
onready var teeth = $Teeth
onready var shield = $Shield
onready var anim = $AnimationPlayer

func turn(right:bool):
	anim.play("Right")
	if right:
		anim.play("Right")
	else:
		anim.play_backwards("Right")

func ladder():
	anim.play("Up")
	print("pawn 03 needs ladder moves in wheel")

func stop():
	anim.stop(false)

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	shield.self_modulate = _sec
	wheel.self_modulate = _pri
	teeth.self_modulate = _sec
