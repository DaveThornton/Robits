extends Area2D

export var my_name = "map"

func _ready():
	pass

func _on_Kill_Zone_body_entered(body):
	if body.get_groups().has("player"):
		# body.hit(-1, "map", "map", 500)
		body.killed_by_map(0, 0, my_name, 100)
		print_debug(body)
	elif body.get_groups().has("unkillable"):
		pass
	else:
		body.queue_free()
