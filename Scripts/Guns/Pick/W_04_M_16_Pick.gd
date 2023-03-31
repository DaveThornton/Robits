extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var sprite2 = $Sprite/Sprite2


func _on_WeapPick04M_16_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)

func call_end_init():
	mag_visible(bool(ammo > 0))

func set_right():
	sprite.scale.y = 1.5

func set_left():
	sprite.scale.y = -1.5

func mag_visible(_vis):
	sprite2.visible = _vis