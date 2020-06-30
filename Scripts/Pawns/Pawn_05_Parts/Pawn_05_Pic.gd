extends Node2D
onready var head =$Sprite_Head
onready var wheel = $Sprite_Wheel
onready var key = $Sprite_Key
onready var body = $Sprite_Body
onready var arm = $Sprite_Arm

onready var face = $Sprite_Face

var player = 0

func init(_num):
	player = _num
	var _pri_color = Player_Stats.get_body_color(player)
	var _sec_color = Player_Stats.get_sec_color(player)
	head.self_modulate = _pri_color
#	wheel.self_modulate = _pri_color
	key.self_modulate = _pri_color
	body.self_modulate = _pri_color
	arm.self_modulate = _pri_color
	face.self_modulate = _sec_color
