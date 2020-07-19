extends Node2D
onready var anim = $AnimationPlayer
onready var hover_top = $Pawn_04_Hover_Top
onready var hover = $Pawn_04_Hover
onready var hover_bot = $Pawn_04_Hover_bot
onready var shield = $Shield

var last_anim = ""

func _ready():
	anim.play("Idle")

func play(_anim:String):
	if last_anim != _anim:
		last_anim = _anim
		anim.play(_anim)
	else:
		return

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri, _sec):
	hover.self_modulate = _pri
	hover_top.self_modulate = _sec
	hover_bot.self_modulate = _sec
	shield.self_modulate = _sec
