extends Node2D

onready var head = $Pawn_10_Part_Head
onready var face = $Pawn_10_Part_Head/Pawn_10_Part_Face
onready var nose = $Pawn_10_Part_Head/Pawn_10_Part_Lights_Nose
onready var back = $Pawn_10_Part_Head/Pawn_10_Part_Lights_Back
onready var top = $Pawn_10_Part_Head/Pawn_10_Part_Lights_Top
onready var shield = $Shield
onready var anim = $AnimationPlayer

func play(_anim):
	if _anim == "Idle" || _anim == "Stun":
		anim.play(_anim)
	else:
		anim.play("Idle")
		print("error in pawn 10 head play animation not a valid animation ")

func is_right(_right: bool):
	if _right:
		face.scale.x = 1
		nose.position.x = 14
		nose.rotation_degrees = 0
		back.position.x = -10
		back.rotation_degrees = 0
	else:
		face.scale.x = -1
		nose.position.x = -14
		nose.rotation_degrees = 180
		back.position.x = 10
		back.rotation_degrees = 180

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false


func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	face.self_modulate = _sec
	nose.self_modulate = _sec
	back.self_modulate = _sec
	top.self_modulate = _sec
	shield.self_modulate = _sec
