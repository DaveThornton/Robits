extends Node2D

onready var body = $Pawn_17_Body_V2
onready var head = $Pawn_17_Body_V2/Pawn_17_Head_V2
onready var arm = $Pawn_17_Body_V2/Pawn_17_Part_Arm_V2
onready var eye = $Pawn_17_Body_V2/Pawn_17_Head_V2/Pawn_17_Eye_Top_V2/Pawn_17_Eye_Ball_V2
onready var stinger = $Pawn_17_Body_V2/Pawn_17_Stinger_V2
onready var rings = $Pawn_17_Body_V2/CPUParticles2D
onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	arm.self_modulate = _pri
	body.self_modulate = _pri
	eye.self_modulate = _sec
	stinger.self_modulate = _pri
	rings.self_modulate = _sec
