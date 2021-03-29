extends Node2D

onready var shield = $Pawn_16_Shield
onready var body = $Pawn_16_Body
onready var legs_f = $Pawn_16_Front_Legs
onready var legs_b = $Pawn_16_Back_Legs
onready var anim = $AnimationPlayer
onready var ray_dr = $Ray_Down_Right
onready var ray_dl = $Ray_Down_Left

var overide = false
var check_time = .25

func play(_num: int):
	if !overide:
		if _num == 1:
			anim.play("Idle")
		elif _num == 2:
			anim.play("Walk")
		elif _num == 3:
			anim.play_backwards("Walk")
		elif _num == 4:
			anim.play("Crouch")
		elif _num == 5:
			anim.play("Crawl")
		elif _num == 6:
			anim.play_backwards("Crawl")
		elif _num == 7:
			anim.play("Stun")
		elif _num == 8:
			anim.play("Jump")
		elif _num == 9:
			anim.play("Fall")

func shield_up():
	shield.visible = true

func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	body.self_modulate = _pri
	legs_f.self_modulate = _pri
	legs_b.self_modulate = _pri
	shield.self_modulate = _sec
