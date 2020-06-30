extends Node2D

onready var body = $Sprite_Body
onready var arm = $Sprite_Arm
onready var legs = $Sprite_Legs
onready var hip = $Sprite_Hip
onready var face =$Sprite_Face
onready var eye = $Sprite_Eye

var player = 0

func init(_num):
	player = _num
	var _pri_color = Player_Stats.get_body_color(player)
	var _sec_color = Player_Stats.get_sec_color(player)
	hip.self_modulate = _pri_color
	body.self_modulate = _pri_color
	legs.self_modulate = _pri_color
	arm.self_modulate = _pri_color
	eye.self_modulate = _sec_color
