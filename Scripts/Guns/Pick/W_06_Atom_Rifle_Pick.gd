extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'
onready var sprite2 = $Sprite/Sprite2
onready var sprite3 = $Sprite/Sprite3

func _on_WeapPick10Blaster_Pistol_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)

func set_right():
	sprite.scale.y = 1

func set_left():
	sprite.scale.y = -1

func ammo_is_zero():
	sprite3.visible = false