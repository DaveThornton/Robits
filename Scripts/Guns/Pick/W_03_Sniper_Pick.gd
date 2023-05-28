extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

func _on_WeapPick03Sniper_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)

func set_right():
	if sprite.scale.y < 0:
		sprite.scale.y *= -1

func set_left():
	if sprite.scale.y > 0:
		sprite.scale.y *= -1