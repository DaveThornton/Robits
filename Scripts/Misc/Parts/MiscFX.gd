extends Node2D

export(PackedScene) var arrow
export(PackedScene) var bolt
export(PackedScene) var mine
export(PackedScene) var disappear
export(PackedScene) var flame

func stuck_arrow():
	return arrow

func stuck_bolt():
	return bolt

func armed_mine():
	return mine

func get_flame():
	return flame

func poof(_pos):
	var s = disappear.instance()
	Map_Hand.add_kid_to_map(s)
	s.start( 0 , _pos, 0, 0)