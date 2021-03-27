extends Node2D

onready var anim_face = $AnimationPlayer
onready var shield = $Pawn_18_Shield
onready var head = $Pawn_18_Head
onready var eye = $Pawn_18_Eye
onready var mouth = $Pawn_18_Mouth

var current_anim = "none"

func play(_anim):
	if current_anim != _anim:
		anim_face.play(_anim)
		current_anim = _anim

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	head.self_modulate = _pri
	eye.self_modulate = _sec
	mouth.self_modulate = _sec
	shield.self_modulate = _sec
