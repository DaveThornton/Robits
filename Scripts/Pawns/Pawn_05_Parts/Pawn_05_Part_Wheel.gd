extends Node2D

onready var anim = $AnimationPlayer

var on_floor = true

func turn(right:bool):
	if on_floor:
		if right:
			anim.play("Spin_Ground")
		else:
			anim.play_backwards("Spin_Ground")
	else:
		if right:
			anim.play("Spin_Air")
		else:
			anim.play_backwards("Spin_Air")

func ladder():
	anim.play("Ladder_Up")

func stop():
	anim.stop(false)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
