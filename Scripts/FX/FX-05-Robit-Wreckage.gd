extends RigidBody2D

export var expire = true
onready var sprite = $Sprite

var pawn_img_01 = preload("res://Sprites/Pawns/Pawn_01/Pawn_01_Wreckage.png")
var pawn_img_02 = preload("res://Sprites/Pawns/Pawn_02/Pawn_02_Wreckage.png")
var pawn_img_03 = preload("res://Sprites/Pawns/Pawn_03/Pawn_03_Wreckage.png")
var pawn_img_04 = preload("res://Sprites/Pawns/Pawn_04/Pawn_04_Wreckage.png")
var pawn_img_05 = preload("res://Sprites/Pawns/Pawn_05/Pawn_05_Wreckage.png")
var pawn_img_06 = preload("res://Sprites/Pawns/Pawn_06/Pawn_06_Wreckage.png")
var pawn_img_07 = preload("res://Sprites/Pawns/Pawn_07/Pawn_07_Wreckage.png")
var pawn_img_08 = preload("res://Sprites/Pawns/Pawn_08/Pawn_08_Wreckage.png")
var pawn_img_09 = preload("res://Sprites/Pawns/Pawn_09/Pawn_09_Wreckage.png")
var pawn_img_10 = preload("res://Sprites/Pawns/Pawn_10/Pawn_10_Wreckage.png")
var pawn_img_11 = preload("res://Sprites/Pawns/Pawn_11/Pawn_11_Wreckage.png")
var pawn_img_12 = preload("res://Sprites/Pawns/Pawn_12/Pawn_12_Wreckage.png")
var pawn_img_13 = preload("res://Sprites/Pawns/Pawn_13/Pawn_13_Wreckage.png")
var pawn_img_14 = preload("res://Sprites/Pawns/Pawn_14/Pawn_14_Wreckage.png")
var pawn_img_15 = preload("res://Sprites/Pawns/Pawn_15/Pawn_15_Wreckage.png")

func _ready():
	if expire:
		var time = rand_range(65.0,125.0)
		$Timer.wait_time = time
		$Timer.start()

func init(_player, _pawn, _part_num, _move, _pos, _impulse):
	sprite.frame = _part_num
	if _pawn == 2:
		sprite.texture = pawn_img_02
	elif _pawn == 3:
		sprite.texture = pawn_img_03
	elif _pawn == 4:
		sprite.texture = pawn_img_04
	elif _pawn == 5:
		sprite.texture = pawn_img_05
	elif _pawn == 6:
		sprite.texture = pawn_img_06
	elif _pawn == 7:
		sprite.texture = pawn_img_07
	elif _pawn == 8:
		sprite.texture = pawn_img_08
	elif _pawn == 9:
		sprite.texture = pawn_img_09
	elif _pawn == 10:
		sprite.texture = pawn_img_10
	elif _pawn == 11:
		sprite.texture = pawn_img_11
	elif _pawn == 12:
		sprite.texture = pawn_img_12
	elif _pawn == 13:
		sprite.texture = pawn_img_13
	elif _pawn == 14:
		sprite.texture = pawn_img_14
	elif _pawn == 15:
		sprite.texture = pawn_img_15
	elif _pawn > 15:
		print("wreckage doesnt go past pawn 15 so you should fix that or the pawn FX-05 ")
	if _player == 1:#Grey
		sprite.self_modulate = Player_Stats.p1.color_1
	elif _player == 2:#Pink
		sprite.self_modulate = Player_Stats.p2.color_1
	elif _player == 3:#Red
		sprite.self_modulate = Player_Stats.p3.color_1
	elif _player == 4:#Blue
		sprite.self_modulate = Player_Stats.p4.color_1
	elif _player == 5:#Yellow
		sprite.self_modulate = Player_Stats.p5.color_1
	elif _player == 6:#Purple
		sprite.self_modulate = Player_Stats.p6.color_1
	elif _player == 7:#Teal
		sprite.self_modulate = Player_Stats.p7.color_1
	elif _player == 8:#Green
		sprite.self_modulate = Player_Stats.p8.color_1
	if _move:
		self.position = _pos
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")
