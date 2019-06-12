extends Navigation2D

#func _ready():
#	pass 

#func get_path(_asker):
#	pass

#func _process(delta):
#	pass
func find_path(_thing_1, _thing_2):
	var pool = get_simple_path(_thing_1.global_position, _thing_2.global_position, false) 
#	print("finding path")
	_thing_1.path = pool #get_simple_path(_thing_1.global_position, _thing_2.global_position) 
	self.get_tree().get_current_scene().draw_line(pool)
#	return pool

func found_me():
	print("found me i am MP-04-Nav2d")