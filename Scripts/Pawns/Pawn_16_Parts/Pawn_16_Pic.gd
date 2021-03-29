extends Node2D
onready var body = $Pawn_16_Body
onready var head = $Pawn_16_Head
onready var arm = $Pawn_16_Head/Pawn_16_Part_Arm
onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")
	body.play(2)

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.color(_pri, _sec)
	arm.color(_pri, _sec)
	body.color(_pri, _sec)
