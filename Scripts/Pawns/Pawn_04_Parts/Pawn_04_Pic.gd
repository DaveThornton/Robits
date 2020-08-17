extends Node2D

onready var hover = $Pawn_04_Body/Pawn_04_Hover
onready var body = $Pawn_04_Body
onready var head = $Pawn_04_Body/Pawn_04_Head
onready var arm = $Pawn_04_Body/Pawn_04_Part_Arm

onready var face = $Pawn_04_Body/Pawn_04_Head/Pawn_04_Face
onready var head_b = $Pawn_04_Body/Pawn_04_Head_Hover
onready var body_b = $Pawn_04_Body/Pawn_04_Hover_Top
onready var hover_b = $Pawn_04_Body/Pawn_04_Hover/Pawn_04_Hover_Bot
onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	arm.self_modulate = _pri
	body.self_modulate = _pri
	hover.self_modulate = _pri
	face.self_modulate = _sec
	head_b.self_modulate = _sec
	body_b.self_modulate = _sec
	hover_b.self_modulate = _sec
