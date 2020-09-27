extends Node
onready var splash_scn = $"M10-Splash"
var map
var next_map
onready var clearing_house = $clearing_house

var level

func spawn_pos():
	if !Game.over:
		return map.next_spawn_pos()
	else:
		return null

func load_map( _map_to_load):
	var m = _map_to_load.instance()
	if map:
		map.queue_free()
	map = m
	add_child(m)
	Game.spawn_started()
	var test = get_tree().get_current_scene().connect("reset", m, "reset")
	if test != 0:
		print("error Singleton Map Handler connecting map to reset from world gd")

func add_kid_to_map(_obj):
	if is_instance_valid(map):
#		Map_Hand.clearing_house.add_child(_obj)
		map.add_child(_obj) #weird error
	else:
#		map.add_child(_obj)
		clearing_house.add_child(_obj)

func add_bg_to_map(_obj):
	if is_instance_valid(map):
#		Map_Hand.clearing_house.add_child(_obj)
		map.badguys.add_child(_obj) #weird error
	else:
#		map.add_child(_obj)
		clearing_house.add_child(_obj)

func set_next_map(_map):
	next_map = _map

func load_next_map():
	if next_map:
		load_map(next_map)
	else:
		print("error in map handler load next map - no next map")

func clear_map():
	map.call_deferred("free")
	map = null

func load_map_cam_first(_level, _label_1, _label_2, _time, _show):
	$Splash_Timer.wait_time = _time
	splash(_label_1,_label_2)
	_load_map_cam(_level)
	Game.spawn_started()

func load_map_cam(_level, _label_1, _label_2, _time, _show):
	$Splash_Timer.wait_time = _time
	splash(_label_1,_label_2)
	_load_map_cam(_level)

func _load_map_cam(_level):
	var m = _level.instance()
	if map:
		map.queue_free()
	map = m
	add_child(m)
	var test = get_tree().get_current_scene().connect("reset", m, "reset")
	if test != 0:
		print("error Singleton Map Handler connecting (map in cam) to reset from world gd")
#	map.global_position += Vector2(0,540)

#	for x in get_tree().get_current_scene().pawns.get_child_count():
#		pass

	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func splash(_top, _body):
	splash_scn.visible = true
	splash_scn.change_text(_top, _body)
	$Splash_Timer.start()

func _on_Splash_Timer_timeout():
	get_tree().paused = false
	splash_scn.change_text("error", "error in map hand")
	splash_scn.visible = false
