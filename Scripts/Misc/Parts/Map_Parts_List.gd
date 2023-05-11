extends Node2D

# export(PackedScene) var ex002
# export(PackedScene) var ex003
# export(PackedScene) var ex004
# export(PackedScene) var ex005
# export(PackedScene) var ex006
export(PackedScene) var mp051

func get_part(num):
	match num:
		51: 
			print_debug("got map part 51")
			return mp051
