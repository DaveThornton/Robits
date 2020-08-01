extends Node2D

onready var head = $Pawn_06_Part_Body/Pawn_06_Part_Head
onready var body = $Pawn_06_Part_Body
onready var arm = $Pawn_06_Part_Body/Pawn_06_Part_Arm

onready var face = $Pawn_06_Part_Body/Pawn_06_Part_Head/Pawn_06_Part_Face
onready var hover = $Pawn_06_Part_Body/Pawn_06_Part_Hover

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	arm.self_modulate = _pri
	face.self_modulate = _sec
	hover.modulate = _sec
