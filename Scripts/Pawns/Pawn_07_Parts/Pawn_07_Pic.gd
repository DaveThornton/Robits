extends Node2D

onready var head = $Pawn_07_Part_Body/Pawn_07_Part_Head
onready var body = $Pawn_07_Part_Body
onready var arm = $Pawn_07_Part_Body/Pawn_07_Part_Arm
onready var trax = $Pawn_07_Part_Trax
onready var trax_back = $Pawn_07_Part_Trax/Pawn_07_Part_Trax_Back
onready var face =$Pawn_07_Part_Body/Pawn_07_Part_Head/Pawn_07_Part_Face

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	arm.self_modulate = _pri
	trax_back.self_modulate = _pri
	trax.self_modulate = _sec
	face.self_modulate = _sec
