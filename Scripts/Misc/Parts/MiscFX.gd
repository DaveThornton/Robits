extends Node2D

export(PackedScene) var arrow
export(PackedScene) var bolt
export(PackedScene) var mine
export(PackedScene) var disappear
export(PackedScene) var flame
export(PackedScene) var plasma_det
export(PackedScene) var mega_ex
export(PackedScene) var bg_03_parts

func stuck_arrow():
	return arrow

func stuck_bolt():
	return bolt

func armed_mine():
	return mine

func get_flame():
	return flame

func mega_boom(_pos):
	var s = mega_ex.instance()
	Map_Hand.add_kid_to_map(s)
	s.global_position = _pos

func poof(_pos):
	var s = disappear.instance()
	Map_Hand.add_kid_to_map(s)
	s.start( 0 , _pos, 0, 0)

func get_plasma_det():
	return plasma_det

func get_part(_num):
	match _num:
		3: return bg_03_parts