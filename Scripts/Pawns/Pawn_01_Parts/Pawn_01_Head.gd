extends Node2D

onready var anim = $AnimationPlayer
onready var head = $Head
onready var face = $Face
onready var hair = $Hair
onready var shield = $Shield

func play(_anim):
	if _anim == "On":
		anim.play(_anim)
	elif _anim == "Off":
		anim.play(_anim)
	elif _anim == "Stun":
		anim.play(_anim)
	elif _anim == "Flash":
		anim.play(_anim)
	else:
		anim.play("On")
		print("error in pawn 01 head play animation not a valid animation ")

func is_right(_right):
	if _right:
		head.frame = 0
		face.scale.x = 1
		hair.scale.x = 1
	else:
		head.frame = 1
		face.scale.x = -1
		hair.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	hair.self_modulate = _sec
	shield.self_modulate = _sec
