extends Node2D

export(PackedScene) var bg_00
export(PackedScene) var bg_01
export(PackedScene) var bg_02
export(PackedScene) var bg_03
export(PackedScene) var bg_04
export(PackedScene) var bg_05
export(PackedScene) var bg_06
export(PackedScene) var bg_07
export(PackedScene) var bg_08
export(PackedScene) var bg_09
export(PackedScene) var bg_10
export(PackedScene) var bg_25

func get_bg(bg_num):
	match bg_num:
		1: return bg_01
		2: return bg_02
		3: return bg_03
		4: return bg_04
		5: return bg_05
		6: return bg_06
		7: return bg_07
		8: return bg_08
		9: return bg_09
		10: return bg_10
		25: return bg_25
		_: 
			print_debug("error wrong bg called in Campaign Bad Guys number: ", bg_num)
			return bg_00