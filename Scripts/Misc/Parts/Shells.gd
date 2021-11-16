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
	match _num:
		2:
			s = shell002.instance()
		3:
			s = shell002.instance()
		4:
			s = shell002.instance()
		8:
			s = shell002.instance()
		9:
			s = shell002.instance()
		20:
			s = shell020.instance()
		21:
			s = shell020.instance()
		22:
			s = shell020.instance()
		50:
			s = shell050.instance()
		57:
			s = shell002.instance()
		83:
			s = shell002.instance()
		84:
			s = shell002.instance()
	Map_Hand.add_kid_to_map(s)
	s.position = _pos
	s.rotation = _rot
