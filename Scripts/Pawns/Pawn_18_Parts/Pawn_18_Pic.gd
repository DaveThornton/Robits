extends Node2D

onready var butt = $Pawn_18_Butt
onready var leg_b = $Pawn_18_Mid_Leg_Bot
onready var leg_t = $Pawn_18_Mid_Leg_Top
onready var body = $Pawn_18_Mid_Body
onready var arm = $Pawn_18_Mid_Body/Pawn_18_Part_Arm
onready var head = $Pawn_18_Part_Head
onready var eye = $Pawn_18_Part_Head/Pawn_18_Part_Head_Eye
onready var mouth = $Pawn_18_Part_Head/Pawn_18_Part_Head_Mouth
onready var anim = $AnimationPlayer

func _ready():
	anim.play("Run")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	leg_t.self_modulate = _pri
	leg_b.self_modulate = _pri
	body.self_modulate = _pri
	arm.self_modulate = _pri
	butt.self_modulate = _pri
	eye.self_modulate = _sec
	mouth.self_modulate = _sec
	
	
