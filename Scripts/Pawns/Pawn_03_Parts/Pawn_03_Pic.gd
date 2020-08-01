extends Node2D

onready var body = $Pawn_03_Part_Body
onready var head = $Pawn_03_Part_Head
onready var arm = $Pawn_03_Part_Body/Pawn_03_Part_Arm
onready var face1 = $Pawn_03_Part_Head/Pawn_03_Part_Face_01
onready var wheelb = $Pawn_03_Part_Big_Wheel_01
onready var wheels = $Pawn_03_Part_Small_Wheel_02

onready var wheelc = $Pawn_03_Part_Big_Wheel_01/Pawn_03_Part_Big_Wheel_02
onready var teeth1 = $Pawn_03_Part_Big_Wheel_01/Pawn_03_Part_Big_Wheel_03
onready var teeth2 = $Pawn_03_Part_Small_Wheel_02/Pawn_03_Part_Small_Wheel_01
onready var face2 = $Pawn_03_Part_Head/Pawn_03_Part_Face_02

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	face1.self_modulate = _pri
	arm.self_modulate = _pri
	body.self_modulate = _pri
	wheelb.self_modulate = _pri
	wheels.self_modulate = _pri
	
	face2.self_modulate = _sec
	wheelc.self_modulate = _sec
	teeth1.self_modulate = _sec
	teeth2.self_modulate = _sec
