extends Node2D

onready var legf = $Pawn_15_Leg_F
onready var hub = $Pawn_15_Hub_01
onready var hub2 = $Pawn_15_Hub_01/Pawn_15_Hub_02
onready var legb = $Pawn_15_Leg_B
onready var body = $Pawn_15_Body
onready var arm = $Pawn_15_Part_Arm

onready var face = $Pawn_15_Body/Pawn_15_Face

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	face.self_modulate = _sec
	arm.self_modulate = _pri
	body.self_modulate = _pri
	legf.self_modulate = _pri
	legb.self_modulate = _pri
	hub.self_modulate = _pri
	hub2.self_modulate = _sec
