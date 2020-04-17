extends Node2D

onready var anim = $AnimationPlayer
onready var head = $Head
onready var face = $Face
onready var shield = $Shield

func is_right(_right):
	if _right:
		face.scale.x = 1
	else:
		face.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visable = false

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	shield.self_modulate = _sec
