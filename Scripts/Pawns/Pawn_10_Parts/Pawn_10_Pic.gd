extends Node2D

onready var body = $Pawn_10_Part_Body
onready var head = $Pawn_10_Part_Body/Pawn_10_Part_Head
onready var arm = $Pawn_10_Part_Body/Pawn_09_Part_Arm
onready var wheel = $Pawn_10_Part_Body/Pawn_10_Part_Tire
onready var face = $Pawn_10_Part_Body/Pawn_10_Part_Head/Pawn_10_Part_Face

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	face.self_modulate = _sec
	arm.self_modulate = _pri
	body.self_modulate = _pri
	wheel.self_modulate = _sec
