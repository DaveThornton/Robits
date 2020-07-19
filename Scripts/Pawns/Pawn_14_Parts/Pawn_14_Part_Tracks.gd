extends Node2D

onready var anim = $AnimationPlayer
onready var shield = $Shield
onready var wheel = $Wheel
onready var trax = $Track
onready var trax_back = $Back

func turn(right:bool):
	anim.play("Right")
	if right:
		anim.play("Right")
	else:
		anim.play_backwards("Right")

func ladder(): #_up:bool):
#	if _up:
	anim.play("Up")
#	else:
#		anim.play_backwards("Up")

func stop():
	anim.stop(false)

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	shield.self_modulate = _sec
	trax.self_modulate = _pri
	wheel.self_modulate = _sec
	trax_back.self_modulate = _pri
