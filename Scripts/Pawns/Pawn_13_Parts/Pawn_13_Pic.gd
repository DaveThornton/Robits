extends Node2D

onready var head = $Sprite_Body/Sprite_Head
onready var body = $Sprite_Body
onready var hbody = $Sprite_Body/Sprite_H_Body
onready var arm = $Sprite_Body/Sprite_Arm
onready var legs_f = $Sprite_Body/Sprite_H_Body/Sprite_Legs_F
onready var legs_b = $Sprite_Body/Sprite_H_Body/Sprite_Legs_B
onready var face =$Sprite_Body/Sprite_Head/Sprite_Face
onready var face_b = $Sprite_Body/Sprite_Head/Sprite_Face_B

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	legs_f.self_modulate = _pri
	legs_b.self_modulate = _pri
	arm.self_modulate = _pri
	hbody.self_modulate = _pri
	
	face.self_modulate = _sec
	face_b.self_modulate = _sec
