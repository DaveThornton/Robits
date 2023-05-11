extends Node2D

export var my_name = "spike"

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.killed_by_map(-1, 0,my_name, 50)