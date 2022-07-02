extends Node2D

onready var head = $Head
onready var shield = $Head/Shield
onready var eye = $Head/Eye
onready var mouth = $Head/Mouth
onready var bow = $Head/Bow
onready var hair = $Head/Hair
onready var anim = $AnimationPlayer

func play(_anim):
	if anim.has_animation(_anim):
		anim.play(_anim)
	else:
		print_debug("wrong anim on head of pawn 11 it called for ",_anim," it doesnt exist")
		anim.play("Idle")

func is_right(_right):
	if _right:
		head.frame = 0
		eye.scale.x = 1
		mouth.scale.x = 1
		bow.scale.x = 1
	else:
		head.frame = 1
		eye.scale.x = -1
		mouth.scale.x = -1
		bow.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	head.self_modulate = _pri
	shield.self_modulate = _sec
	eye.self_modulate = _sec
	mouth.self_modulate = _sec
	bow.self_modulate = _sec
	hair.self_modulate = _sec
