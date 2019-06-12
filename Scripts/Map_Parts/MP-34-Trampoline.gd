extends Node2D
onready var anim = $AnimationPlayer

export var bounce = 100
export var duration = .1
export var y_way = true

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.bounce(-bounce, duration, y_way)
		anim.play("Bounce")