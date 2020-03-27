extends KinematicBody2D

onready var legs = $Legs
onready var body = $Pawn_08_Part_Body
onready var hip = $Pawn_08_Part_Hip
onready var anim = $AnimationPlayer

func _ready():
	anim.play("Right-Run")

#func _process(delta):
#	pass
