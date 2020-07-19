extends Node2D

onready var head = $Pawn_15_Body
onready var face = $Pawn_15_Body/Pawn_15_Face
onready var shield = $Shield
onready var anim_head = $AnimationPlayer_Head
onready var anim_face = $AnimationPlayer_Face

func is_right(_right: bool):
	if _right:
		anim_head.play("Right")
		face.scale.x = 1
	else:
		anim_head.play("Left")
		face.scale.x = -1

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	face.self_modulate = _sec
	shield.self_modulate = _sec
