extends Node2D

onready var anim = $AnimationPlayer

func _ready():
	anim.play("Bounce")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
