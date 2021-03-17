extends Node2D

onready var head = $Pawn_17_Head_V2
onready var eye = $Pawn_17_Eye_Ball_V2
onready var shield = $Pawn_17_Shield
onready var anim_eye = $AnimationPlayer_Eye
onready var anim_dir = $AnimationPlayer_Dir


func is_right(_right: bool):
	if _right:
		anim_dir.play("Right")
	else:
		anim_dir.play("Left")

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func play_face(_nothing):
	pass

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	eye.self_modulate = _sec
	shield.self_modulate = _sec
