extends Node2D

func play(sfx = null):
	if sfx:
		get_node(sfx).play()