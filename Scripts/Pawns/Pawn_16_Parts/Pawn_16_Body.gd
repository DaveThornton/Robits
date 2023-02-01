extends Node2D

onready var shield = $Pawn_16_Body/Pawn_16_Body_Shield
onready var shield_legs = $Pawn_16_Back_Legs_Shield
onready var body = $Pawn_16_Body
onready var legs_f = $Pawn_16_Front_Legs
onready var legs_b = $Pawn_16_Back_Legs
onready var anim = $AnimationPlayer
onready var anim_rocket = $AnimationPlayer_Rocket

var last_anim = " "
var overide = false

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

func flame_up():
	if last_anim != "Flame_On":
		last_anim = "Flame_On"
		anim_rocket.play("Flame_On")

func flame_on():
	anim_rocket.play("Flaming")

func flame_down():
	if last_anim != "Flame_Off":
		last_anim = "Flame_Off"
		anim_rocket.play("Flame_Off")

func shield_up():
	shield.visible = true
	shield_legs.visible = true

func shield_down():
	shield.visible = false
	shield_legs.visible = false

func color(_pri: Color, _sec: Color):
	body.self_modulate = _pri
	legs_f.self_modulate = _pri
	legs_b.self_modulate = _pri
	shield.self_modulate = _sec
	shield_legs.self_modulate = _sec 
