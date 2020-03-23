extends Node2D

onready var anim = $AnimationPlayer

var on = false

func _ready():
#	anim.play("Flame_Up")
#	anim.play("On")
	pass

func flame():
	on = true
	anim.play("On")

func flame_up():
	on = true
	anim.play("Flame_Up")

func flame_down():
	on = false
	anim.play("Flame_Down")

func flame_off():
	on = false
	anim.play("Off")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
