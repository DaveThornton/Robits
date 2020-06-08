extends Node2D

onready var body = $Body
onready var shield = $Shield

func is_right(_right):
	if _right:
		body.scale.x = 1
	else:
		body.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	body.self_modulate = _pri
	shield.self_modulate = _sec
