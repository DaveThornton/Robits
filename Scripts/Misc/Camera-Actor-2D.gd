extends Camera2D
#const camera_speed = 150
#var total_x
#var total_y
#var total

func _ready():
	pass

func _process(delta):
	if get_tree().get_current_scene().pawns.get_child_count() != 0:
		var total = Vector2(0,0)
		for p in range (get_tree().get_current_scene().pawns.get_child_count()):
			total += get_tree().get_current_scene().pawns.get_child(p).global_position
#		print(total / get_tree().get_current_scene().pawns.get_child_count())
		global_position = (total / get_tree().get_current_scene().pawns.get_child_count())
#	print(get_tree().get_current_scene().pawns.get_child_count())
#	global_position.x = (global_position.x + (camera_speed * delta))
#	pass
