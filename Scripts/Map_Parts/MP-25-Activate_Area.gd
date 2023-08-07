extends Area2D

export var activation_num = 0

func setup(_num):
	activation_num = _num

func _on_MP25Activate_Area_body_entered(body):
	if body.get_groups().has("player"):
		Map_Hand.activate(body, activation_num)
		# Map_Hand.map.activate_BG(activation_num, body)