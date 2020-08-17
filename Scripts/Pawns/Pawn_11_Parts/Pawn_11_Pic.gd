extends Node2D

onready var body = $Sprite_Body
onready var arm = $Sprite_Body/Pawn_09_Part_Arm
onready var tracks_b = $Sprite_Track_T/Sprite_Track_B
onready var tracks_f = $Sprite_Track_T/Sprite_Track_F
onready var tracks_m = $Sprite_Track_T/Sprite_Track_M
onready var tracks_t = $Sprite_Track_T
onready var head = $Sprite_Head
onready var face =$Sprite_Head/Sprite_Face

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	tracks_b.self_modulate = _pri
	tracks_m.self_modulate = _pri
	tracks_t.self_modulate = _pri
	arm.self_modulate = _pri
	face.self_modulate = _sec
	tracks_m.self_modulate = _sec
