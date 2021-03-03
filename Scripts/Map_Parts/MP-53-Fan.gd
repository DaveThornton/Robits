extends Node2D

onready var anim = $AnimationPlayer

func _ready():
	anim.play("spin_fast")

func hit_it(_body):
	if _body.get_groups().has("hittable") || _body.get_groups().has("player"):
		_body.hit(-1, "Fan", "Sharp", 1000)

#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	hit_it(body)
