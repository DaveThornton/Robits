extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var sprite2 = $Sprite/Sprite2

func _on_WeapPick02Ak47_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)
	
func set_right():
	call_deferred("deferred_right")
func deferred_right():
	sprite.scale.y = 1
	# sprite2.scale.y = 1

func set_left():
	call_deferred("deferred_left")
func deferred_left():
	sprite.scale.y = -1
	# sprite2.scale.y = -1

func ammo_is_zero():
	sprite2.visible = false
