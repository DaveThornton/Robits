extends Node2D

onready var head = $Sprite_Body/Sprite_Head
onready var body = $Sprite_Body
onready var arm = $Sprite_Body/Sprite_Arm
onready var legs = $Sprite_Legs
onready var hip = $Sprite_Legs/Sprite_Hip
onready var pack = $Sprite_Body/Sprite_Jet_Pack
onready var face =$Sprite_Body/Sprite_Head/Sprite_Face
onready var head_b = $Sprite_Body/Sprite_Head/Sprite_Head_B

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	legs.self_modulate = _pri
	arm.self_modulate = _pri
	pack.self_modulate = _pri

	hip.self_modulate = _sec
	face.self_modulate = _sec
	head_b.self_modulate = _sec
