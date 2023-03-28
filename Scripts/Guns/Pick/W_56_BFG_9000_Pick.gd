extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

func _on_WeapPick51Contradiction_S_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	_entered(_body_id, _body, _body_shape, _local_shape)

func set_right():
	sprite.scale.y = 1.5

func set_left():
	sprite.scale.y = -1.5