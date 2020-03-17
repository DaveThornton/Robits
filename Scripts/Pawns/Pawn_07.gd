extends KinematicBody2D

onready var anim_trax = $AnimationPlayer

func _ready():
	anim_trax.play("Turn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
