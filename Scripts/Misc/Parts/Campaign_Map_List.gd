extends Node2D

export(Array, PackedScene) var map
export(Array, PackedScene) var world_00
export(Array, PackedScene) var world_01
export(Array, PackedScene) var world_02
export(Array, PackedScene) var world_03
export(Array, PackedScene) var world_04
export(Array, PackedScene) var world_05
export(Array, PackedScene) var world_06
export(Array, PackedScene) var world_07
export(Array, PackedScene) var world_08
export(Array, PackedScene) var world_09

func get_map(world, num):
	match world:
		0: if num >= 0 && num <= world_00.size(): return world_00[num]
		1: if num >= 0 && num <= world_01.size(): return world_01[num]
		2: if num >= 0 && num <= world_02.size(): return world_02[num]
		3: if num >= 0 && num <= world_03.size(): return world_03[num]
		4: if num >= 0 && num <= world_04.size(): return world_04[num]
		5: if num >= 0 && num <= world_05.size(): return world_05[num]
		6: if num >= 0 && num <= world_06.size(): return world_06[num]
		7: if num >= 0 && num <= world_07.size(): return world_07[num]
		8: if num >= 0 && num <= world_08.size(): return world_08[num]
		9: if num >= 0 && num <= world_09.size(): return world_09[num]
		_:
			print_debug("error in get campaign map asked for ---- World ", world, "----  map ",num)
			print_debug("so you get map 00")
			return world_00[0]
