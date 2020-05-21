extends Node2D

onready var anim = $AnimationPlayer
onready var head = $Front
onready var back = $Back
onready var face = $Face
onready var shield = $Shield

func is_right(_right: bool):
	if _right == true:
		self.scale.x = 1
	else:
		self.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visable = false

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	back.self_modulate = _pri
	shield.self_modulate = _sec
