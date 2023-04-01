extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var sprite2 = $Sprite/Arrow

func _on_W_07_CrossBow_Pick_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	_entered(_body_id, _body, _body_shape, _local_shape)

func set_right():
	sprite.scale.y = 1.5

func set_left():
	sprite.scale.y = -1.5

func ammo_is_zero():
	sprite.frame = 2
	sprite2.visible = false