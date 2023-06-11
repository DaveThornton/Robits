extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

func _ready():
	time = my_time
	outline = $POS_Gun/Outline

func set_outline_color(_color):
    outline.self_modulate = _color