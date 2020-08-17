extends Node2D

onready var legfr = $Body/F_R
onready var legfl = $Body/F_L
onready var legmr = $Body/M_R
onready var legml = $Body/M_L
onready var legbr = $Body/B_R
onready var legbl = $Body/B_L
onready var body = $Body
onready var head = $Body/Head

onready var eye = $Body/Head/Pawn_02_Part_Head_Eye
onready var mouth = $Body/Head/Pawn_02_Part_Head_Mouth

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	eye.self_modulate = _sec
	mouth.self_modulate = _sec
	body.self_modulate = _pri
	legfr.self_modulate = _pri
	legfl.self_modulate = _pri
	legmr.self_modulate = _pri
	legml.self_modulate = _pri
	legbr.self_modulate = _pri
	legbl.self_modulate = _pri
