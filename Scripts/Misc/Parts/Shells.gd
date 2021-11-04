extends Node2D

export(PackedScene) var shell002
export(PackedScene) var shell020
export(PackedScene) var shell050
# export(PackedScene) var shell003
# export(PackedScene) var shell003
# export(PackedScene) var shell004
# export(PackedScene) var shell006

func spawn(_num, _pos, _rot):
	var s
	if _num == 2:
		s = shell002.instance()
	elif _num == 3:
		s = shell002.instance()
	elif _num == 4:
		s = shell002.instance()
	elif _num == 8:
		s = shell002.instance()
	elif _num == 9:
		s = shell002.instance()
	elif _num == 20:
		s = shell020.instance()
	elif _num == 21:
		s = shell020.instance()
	elif _num == 22:
		s = shell020.instance()
	elif _num == 50:
		s = shell050.instance()
	elif _num == 57:
		s = shell002.instance()
	elif _num == 83:
		s = shell002.instance()
	elif _num == 84:
		s = shell002.instance()
	Map_Hand.add_kid_to_map(s)
	s.position = _pos
	s.rotation = _rot
