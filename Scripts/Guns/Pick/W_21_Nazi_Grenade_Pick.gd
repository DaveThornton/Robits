extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

onready var hand_right = $handle
onready var hand_left = $handle2
onready var gun_pos = $POS_Gun

func call_end_of_set_dir():
	if is_right:
		gun_pos.rotation_degrees = 0
		hand_right.disabled = false
		hand_left.disabled = true
	else:
		gun_pos.rotation_degrees = 180
		hand_right.disabled = true
		hand_left.disabled = false

func set_outline_color(_color):
    outline = $POS_Gun/Outline
    outline.self_modulate = _color