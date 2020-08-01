extends Node2D

onready var body = $Body
onready var arm = $Body/Pawn_09_Part_Arm
onready var legs = $Body/Horse_Legs
onready var head = $Body/Head
onready var face =$Body/Head/Face
onready var hat = $Body/Head/Pawn_09_Part_Hat

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")

func color(_pri, _sec):
	head.self_modulate = _pri
	body.self_modulate = _pri
	legs.self_modulate = _pri
	arm.self_modulate = _pri
	face.self_modulate = _sec
	hat.self_modulate = _sec
