extends Node2D
onready var big = $Random_Pawn_Pic_00
onready var lil = $CPUParticles2D

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))
	lil.emitting = true

func color(_pri, _sec):
	big.self_modulate = _pri
	lil.color = _sec
