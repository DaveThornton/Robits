extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var anim = $AnimationPlayer

func call_end_init():
	anim.play("Idle")

func _on_WeapPick51Contradiction_S_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	_entered(_body_id, _body, _body_shape, _local_shape)

func set_right():
	if sprite.scale.y < 0:
		sprite.scale.y *= -1

func set_left():
	if sprite.scale.y > 0:
		sprite.scale.y *= -1

func ammo_is_zero():
	anim.play("Stop")