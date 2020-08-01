extends Node2D

onready var legf = $"Pawn_01-Legs_F"
onready var legb = $"Pawn_01-Legs_B"
onready var body = $"Pawn_01-Body"
onready var head = $"Pawn_01-Head"
onready var arm = $Pawn_01_Part_Arm

onready var face = $"Pawn_01-Head/Pawn_01-Head_Face"
onready var hair = $"Pawn_01-Head/Pawn_01-Head_Hair"

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	hair.self_modulate = _sec
	arm.self_modulate = _pri
	body.self_modulate = _pri
	legf.self_modulate = _pri
	legb.self_modulate = _pri
