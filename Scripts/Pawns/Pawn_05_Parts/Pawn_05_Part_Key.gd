extends Node2D

onready var anim = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func turn(right:bool):
#	anim.play("Turn")
	if right:
		anim.play("Turn")
	else:
		anim.play_backwards("Turn")

func ladder():
	anim.play("Ladder")

func stop():
	anim.stop(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
