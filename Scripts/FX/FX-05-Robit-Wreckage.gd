extends RigidBody2D

#export var part_num = 0
export var expire = true
onready var sprite = $Sprite

var pawn_img_2 = preload("res://Sprites/Pawns/Parts/Robit_Pawn-02-00-Parts.png")
var pawn_img_3 = preload("res://Sprites/Pawns/Parts/Robit_Pawn-03-00-Parts.png")
var pawn_img_4 = preload("res://Sprites/Pawns/Parts/Robit_Pawn-04-00-Parts.png")

func _ready():
	if expire:
		var time = rand_range(65.0,125.0)
		$Timer.wait_time = time
		$Timer.start()

func init(_player, _pawn, _part_num, _move, _pos, _impulse):
	if _pawn == 2:
		sprite.texture = pawn_img_2
	elif _pawn == 3:
		sprite.texture = pawn_img_3
	elif _pawn == 4:
		sprite.texture = pawn_img_4
	elif _pawn > 4:
		print("wreckage doesnt go past pawn 4 so you should fix that or the pawn FX-05 ")
	if _player == 1:#Grey
		sprite.self_modulate = Player_Stats.p1.color_2
	elif _player == 2:#Pink
		sprite.self_modulate = Player_Stats.p2.color_2
	elif _player == 3:#Red
		sprite.self_modulate = Player_Stats.p3.color_2
	elif _player == 4:#Blue
		sprite.self_modulate = Player_Stats.p4.color_2
	elif _player == 5:#Yellow
		sprite.self_modulate = Player_Stats.p5.color_2
	elif _player == 6:#Purple
		sprite.self_modulate = Player_Stats.p6.color_2
	elif _player == 7:#Teal
		sprite.self_modulate = Player_Stats.p7.color_2
	elif _player == 8:#Green
		sprite.self_modulate = Player_Stats.p8.color_2
	sprite.frame = _part_num
	if _move:
		self.position = _pos
	self.apply_impulse(Vector2(),_impulse)

func _on_Timer_timeout():
	self.call_deferred("free")
