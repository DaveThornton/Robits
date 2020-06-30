extends Node2D

onready var body = $Sprite_Body
onready var arm = $Sprite_Body/Pawn_09_Part_Arm
onready var tracks_b = $Sprite_Track_B
onready var tracks_f = $Sprite_Track_F
onready var tracks_m = $Sprite_Track_M
onready var tracks_t = $Sprite_Track_T
onready var head = $Sprite_Head
onready var face =$Sprite_Head/Sprite_Face

var player = 0

func init(_num):
	player = _num
	var _pri_color = Player_Stats.get_body_color(player)
	var _sec_color = Player_Stats.get_sec_color(player)
	head.self_modulate = _pri_color
	body.self_modulate = _pri_color
	tracks_b.self_modulate = _pri_color
	tracks_m.self_modulate = _pri_color
	tracks_t.self_modulate = _pri_color
	arm.self_modulate = _pri_color
	face.self_modulate = _sec_color
	tracks_m.self_modulate = _sec_color
