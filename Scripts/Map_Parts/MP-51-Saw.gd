extends Node2D

onready var anim = $AnimationPlayer

func _ready():
	anim.play("spin_fast")

func hit_it(_body):
	print_debug("body entered")	
	if _body.get_groups().has("player"):
		_body.killed_by_map(-1, 0, "map", 0)
	if _body.get_groups().has("hittable"):
		_body.hit(-1, "Saw", "Sharp", 1000)

func _on_Area2D_body_entered(body):
	hit_it(body)
