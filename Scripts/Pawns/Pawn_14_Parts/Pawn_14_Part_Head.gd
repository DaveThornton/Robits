extends Node2D

onready var head = $Head
onready var face = $Face
onready var shield = $Shield
onready var anim = $AnimationPlayer

var up = false
var stunned = false

func face_on(_face:bool):
	if _face:
		face.frame = 0
	else:
		face.frame = 1

func is_right(_right: bool):
	if up:
		if anim.current_animation != "Up":
			anim.play("Up")
	else:
		if !stunned:
			if anim.current_animation != "Idle":
				anim.play("Idle")
		else:
			if anim.current_animation != "Stun":
				anim.play("Stun")
	
	if _right == true:
		face.scale.x = 1
	else:
		face.scale.x = -1

func stun(_stun):
	stunned = _stun

func up(_up):
	up = _up

func shield_up():
	shield.visible = true
 
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	shield.self_modulate = _sec
	face.self_modulate = _sec
