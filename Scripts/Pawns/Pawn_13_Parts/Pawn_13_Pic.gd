extends Node2D

onready var head = $Sprite_Head
onready var body = $Sprite_Body
onready var hbody = $Sprite_H_Body
onready var arm = $Sprite_Body/Sprite_Arm
onready var legs_f = $Sprite_H_Body/Sprite_Legs_F
onready var legs_b = $Sprite_H_Body/Sprite_Legs_B
onready var face =$Sprite_Head/Sprite_Face
onready var face_b = $Sprite_Head/Sprite_Face_B

var player = 0

func init(_num):
	player = _num
	var _pri_color = Player_Stats.get_body_color(player)
	var _sec_color = Player_Stats.get_sec_color(player)
	head.self_modulate = _pri_color
	body.self_modulate = _pri_color
	legs_f.self_modulate = _pri_color
	legs_b.self_modulate = _pri_color
	arm.self_modulate = _pri_color
	hbody.self_modulate = _pri_color
	
	face.self_modulate = _sec_color
	face_b.self_modulate = _sec_color
