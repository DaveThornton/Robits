extends Node2D

export(PackedScene) var arrow
export(PackedScene) var bolt
export(PackedScene) var disappear

func stuck_arrow():
	return arrow

func stuck_bolt():
	return bolt

func poof(_pos):
	var s = disappear.instance()
	Map_Hand.add_kid_to_map(s)
	s.start( 0 , _pos, 0, 0)