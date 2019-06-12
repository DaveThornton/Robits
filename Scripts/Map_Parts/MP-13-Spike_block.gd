extends Node2D

#export var is_visible = true 
export var auto_kill = true
export var my_name = "spike"

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if auto_kill:
			body.killed_by_map(0, my_name,my_name, 50)
		else:
			body.hit(0, my_name, my_name, 50)