extends Area2D

var world_to_load = 0
var map_to_load = 1

func load_map():
	FX.CAMERA.reset()
	Campaign.load_next_level(Map_Hand.map.get_next_level_w_info(map_to_load))
	# var map_w_info = Map_Hand.map.get_next_level_w_info (map_to_load)#0: next map number to load, 1: use spash ,  2: splash title , 3: splash body ,  4: lenght of splash in seconds
	# var map_scene_to_load = Campaign.get_map(map_w_info[0], map_w_info[1])
	# # Map_Hand.load_map_cam_first(map_scene_to_load, map_w_info[3], map_w_info[4], map_w_info[5], map_w_info[2])#_level, _label_1, _label_2, _time, _show):
	# Map_Hand.load_map_cam(map_scene_to_load, map_w_info[3], map_w_info[4], map_w_info[5], map_w_info[2])#_level, _label_1, _label_2, _time, _show):
	# call_deferred("queue_free")

func set_map_to_load(num: int):
	map_to_load = num

func _on_MP15LevelChange02Area_body_entered(body:Node):
	if body.get_groups().has("player"):
		call_deferred("load_map")