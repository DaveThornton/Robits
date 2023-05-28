extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

func _on_W_41_SPNKr_Pick_body_shape_entered(body_rid:RID, body:Node, body_shape_index:int, local_shape_index:int):
	_entered(body_rid, body, body_shape_index, local_shape_index)

func set_right():
	if sprite.scale.y < 0:
		sprite.scale.y *= -1

func set_left():
	if sprite.scale.y > 0:
		sprite.scale.y *= -1