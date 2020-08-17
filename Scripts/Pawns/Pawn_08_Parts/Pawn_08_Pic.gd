extends Node2D

onready var body = $Sprite_Body
onready var arm = $Sprite_Body/Sprite_Arm
onready var legs = $Sprite_Legs
onready var hip = $Sprite_Hip
onready var face =$Sprite_Body/Sprite_Face
onready var eye = $Sprite_Body/Sprite_Eye

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func init(_Player_num):
	color(Player_Stats.get_body_color(_Player_num), Player_Stats.get_sec_color(_Player_num))

func color(_pri, _sec):
	hip.self_modulate = _pri
	body.self_modulate = _pri
	legs.self_modulate = _pri
	arm.self_modulate = _pri
	eye.self_modulate = _sec
