extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var sprite2 = $Sprite/Sprite2

func call_end_init():
	if ammo == 0:
		sprite2.visible = false

func _on_WeapPick02Ak47_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)
	
func set_right():
	sprite.scale.y = 1
	sprite2.scale.y = 1

func set_left():
	sprite.scale.y = -1
	sprite2.scale.y = -1