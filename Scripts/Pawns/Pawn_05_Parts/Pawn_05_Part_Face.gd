extends Node2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite


func _ready():
	pass # Replace with function body.

func play(right:bool):
#	anim.play("Turn")
	sprite.visible = true
	if right:
		anim.play("Idle-Right")
	else:
		anim.play("Idle-Left")
#		anim.play_backwards("Turn")

func blank():
	sprite.visible = false

func stop():
	anim.stop(false)
