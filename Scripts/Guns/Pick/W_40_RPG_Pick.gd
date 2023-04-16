extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

onready var sprite_outline = $Sprite/Outline

func _on_WeapPick40RPG_body_shape_entered(body_rid:RID, body:Node, body_shape_index:int, local_shape_index:int):
	_entered(body_rid, body, body_shape_index, local_shape_index)

func set_right():
	sprite.scale.y = 1

func set_left():
	sprite.scale.y = -1

func ammo_is_zero():
	sprite.frame = 1
	sprite_outline.frame = 1