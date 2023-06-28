extends Node2D

export(Array, PackedScene) var map

func get_map(_num):
	if _num > 0 && _num <= map.size():
		return map[_num]
	else:
		print_debug("error in get campaign map asked for map ", _num, " map list only goes to ", map.size())
		print_debug("so you get map 00")
		return map[0]
