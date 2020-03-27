extends Area2D

export var activation_num = 1

func _on_MP25Activate_Area_body_entered(body):
	if body.get_groups().has("player"):
		Map_Hand.map.activate_BG(activation_num, body)
#		self.get_tree().get_current_scene().map.activate_BG(activation_num, body)
		print("calling for BG to hunt in MP-25")
