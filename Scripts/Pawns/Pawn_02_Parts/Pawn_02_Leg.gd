extends Node2D

onready var leg = $Leg
onready var shield = $Shield
onready var anim = $AnimationPlayer

export var front = true
export var step_start_forward = true
#1 = front // 2 = mid // 3 = back
export var leg_num = 1

func _ready():
	leg_change(leg_num)
	if front:
		leg.modulate = Color8(255,255,255)
	else:
		leg.modulate = Color8(126,126,126)

func leg_change(_leg_num:int):
	leg_num = _leg_num
	leg_update()

func leg_update():
	if leg_num == 1:
		var res = load("res://Sprites/Pawns/Pawn_02/Pawn_02_Part_Front_Leg.png")
		leg.texture = res
		leg.position = Vector2(0,3)
	elif leg_num == 2:
		var res = load("res://Sprites/Pawns/Pawn_02/Pawn_02_Part_Mid_Leg.png")
		leg.texture = res
		leg.position = Vector2(0,0)
	elif leg_num == 3:
		var res = load("res://Sprites/Pawns/Pawn_02/Pawn_02_Part_Back_Leg.png")
		leg.texture = res
		leg.position = Vector2(0,-2)

func walk(_right:bool):
	if step_start_forward:
		anim.play("Walk_02")
	else:
		anim.play("Walk_01")
	
	if _right:
		leg.scale.x = 1
		shield.scale.x = 1
	else:
		leg.scale.x = -1
		shield.scale.x = -1

func jump():
	anim.play("Jump")

func fall():
	anim.play("Fall")
	
func ladder(_right):
	if step_start_forward:
		anim.play("Ladder_02")
	else:
		anim.play("Ladder_01")
	if _right:
		leg.scale.x = 1
		shield.scale.x = 1
	else:
		leg.scale.x = -1
		shield.scale.x = -1

func stop():
	anim.stop(false)

func stand():
	anim.play("Stand")

func shield_up():
	shield.visible = true
	
func shield_down():
	shield.visible = false

func color(_pri: Color, _sec: Color):
	if front:
		leg.modulate = Color8(255,255,255)
	else:
		leg.modulate = Color8(126,126,126)
	leg.self_modulate = _pri
	shield.self_modulate = _sec
