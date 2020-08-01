extends Node2D

onready var track_w = $Pawn_14_Body/Pawn_14_Tracks_Back/Pawn_14_Tracks_Wheels
onready var track_b = $Pawn_14_Body/Pawn_14_Tracks_Back
onready var track_t = $Pawn_14_Body/Pawn_14_Tracks_Back/Pawn_14_Tracks_Track
onready var body = $Pawn_14_Body
onready var head = $Pawn_14_Body/Pawn_14_Head
onready var arm = $Pawn_14_Part_Arm

onready var face = $Pawn_14_Body/Pawn_14_Head/Pawn_14_Face

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	arm.self_modulate = _pri
	track_t.self_modulate = _pri
	track_b.self_modulate = _pri
	track_w.self_modulate = _sec
	face.self_modulate = _sec
