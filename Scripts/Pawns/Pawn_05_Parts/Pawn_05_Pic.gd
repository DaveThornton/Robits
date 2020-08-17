extends Node2D

onready var body = $Pawn_05_Part_Body
onready var head = $Pawn_05_Part_Body/Pawn_05_Part_Head
onready var arm = $Pawn_05_Part_Body/Pawn_05_Part_Arm
onready var key = $Pawn_05_Part_Body/Pawn_05_Part_Key
onready var wheel = $Pawn_05_Part_Body/Pawn_05_Part_Wheel
onready var face = $Pawn_05_Part_Body/Pawn_05_Part_Head/Pawn_05_Part_Face
onready var ant = $Pawn_05_Part_Body/Pawn_05_Part_Head/Pawn_05_Part_Ant

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	arm.self_modulate = _pri
	body.self_modulate = _pri
	key.self_modulate = _pri
	wheel.self_modulate = _pri
	
	ant.self_modulate = _sec
	face.self_modulate = _sec
