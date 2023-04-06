extends Node2D
# export(PackedScene) var ex01
export(PackedScene) var ex002
export(PackedScene) var ex003
export(PackedScene) var ex004
export(PackedScene) var ex005
export(PackedScene) var ex006
export(PackedScene) var ex007
# export(PackedScene) var ex008
export(PackedScene) var ex009
export(PackedScene) var ex010
export(PackedScene) var ex011
# export(PackedScene) var ex012
# export(PackedScene) var ex013
# export(PackedScene) var ex014
# export(PackedScene) var ex015
# export(PackedScene) var ex016
# export(PackedScene) var ex017
export(PackedScene) var ex018
export(PackedScene) var ex019
# export(PackedScene) var ex020
# export(PackedScene) var ex021
# export(PackedScene) var ex022
# export(PackedScene) var ex023
export(PackedScene) var ex024
export(PackedScene) var ex025
# export(PackedScene) var ex026
# export(PackedScene) var ex027
# export(PackedScene) var ex208
# export(PackedScene) var ex029
# export(PackedScene) var ex030
# export(PackedScene) var ex031
# export(PackedScene) var ex032
export(PackedScene) var ex040
export(PackedScene) var ex055
export(PackedScene) var ex056_1
export(PackedScene) var ex056_2
export(PackedScene) var ex103
export(PackedScene) var ex104

export(PackedScene) var projhit_013
export(PackedScene) var projhit_014

export(PackedScene) var shape_00
export(PackedScene) var shape_06

func boom(_num, _owner, _pos, _weap_num: int, _pawn_num, _dmg):
	var x = null
	match _num:
		2: x = ex002.instance()
		3: x = ex003.instance()
		4: x = ex004.instance()
		5: x = ex005.instance()
		6: x = ex006.instance()
		7: x = ex007.instance()
		10: x = ex010.instance()
		11: x = ex011.instance()
		18: x = ex018.instance()
		19: x = ex019.instance()
		24: x = ex024.instance()
		25: x = ex025.instance()
		40: x = ex040.instance()
		55: x = ex055.instance()
		56.1: x = ex056_1.instance()
		56.2: x = ex056_2.instance()
		103: x = ex103.instance()
		104: x = ex104.instance()
	if x != null:
		Map_Hand.add_kid_to_map(x)
		x.init(_owner, _pos, _weap_num, _pawn_num, _dmg)
	else:
		print_debug("error in explosions invalid explosion number")

func proj_hit(_num, _pos, _moving):
	var y
	if _num == 13:
		y = projhit_013.instance()
	if _num == 14:#-------------still using 13
		y = projhit_013.instance()

	Map_Hand.add_kid_to_map(y)
	y.global_position = _pos

func get_shape(_num):
	var x
	match _num:
		0: x = shape_00.instance()
		6: x = shape_06.instance()
	return x