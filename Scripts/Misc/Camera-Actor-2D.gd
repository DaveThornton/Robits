extends Camera2D

func _ready():
	pass

func _process(delta):
	if get_tree().get_current_scene().pawns.get_child_count() != 0:
		var total = Vector2(0,0)
		for p in range (get_tree().get_current_scene().pawns.get_child_count()):
			total += get_tree().get_current_scene().pawns.get_child(p).global_position
		global_position = (total / get_tree().get_current_scene().pawns.get_child_count())
