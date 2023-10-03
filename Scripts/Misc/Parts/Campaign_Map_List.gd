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
export(Array, PackedScene) var world_10

var world_count = 11

func get_world_count():	return world_count

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
		10: if num >= 0 && num <= world_09.size(): return world_10[num]
		_:
			print_debug("error in get campaign map asked for ---- World ", world, "----  map ",num)
			print_debug("so you get map 00")
			return world_00[0]

func get_world_has_level(world):
	match world:
		0: 
			if world_00.size() > 0: return true
			else: return false
		1: 
			if world_01.size() > 0: return true
			else: return false
		2: 
			if world_02.size() > 0: return true
			else: return false
		3: 
			if world_03.size() > 0: return true
			else: return false
		4: 
			if world_04.size() > 0: return true
			else: return false
		5: 
			if world_05.size() > 0: return true
			else: return false
		6: 
			if world_06.size() > 0: return true
			else: return false
		7: 
			if world_07.size() > 0: return true
			else: return false
		8: 
			if world_08.size() > 0: return true
			else: return false
		9: 
			if world_09.size() > 0: return true
			else: return false
		10: 
			if world_10.size() > 0: return true
			else: return false
		_: 
			print_debug("error in campaign map list wrong num ", world, " no world with that number returning false")
			return false
