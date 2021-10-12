extends Node2D

export var up_down = true

onready var anim = $AnimationPlayer


func _ready():
	if up_down:
		anim.play("Up_Down")
	else:
		anim.play("Down_Up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass























