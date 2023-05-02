extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

func set_outline_color(_color):
    outline = $POS_Gun/Outline
    outline.self_modulate = _color