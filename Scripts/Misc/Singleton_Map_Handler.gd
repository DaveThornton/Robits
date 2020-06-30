extends Node

var map

#onready var splash = $Level_Load_Screen
#onready var timer_camp = $Timer_Camp_Load
onready var clearing_house = $clearing_house


#var the_game
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

#func add_kid_to_map(_obj):<-------------------------bad idea----
#	call_deferred("_add_kid_to_map",_obj)<-----------------------
func add_kid_to_map(_obj):
	if is_instance_valid(map):
#		Map_Hand.clearing_house.add_child(_obj)
		map.add_child(_obj) #weird error
	else:
#		map.add_child(_obj)
		clearing_house.add_child(_obj)

func clear_map():
	map.call_deferred("free")
	map = null

func load_map_cam(_level, _label_1, _label_2, _time, _show):
#	var m = _level.instance()
	if _show:
#		Menu_Hand.splash(_label_1, _label_2, _time, true)
		HUD.splash(_label_1, _label_2, _time, true)
#		level = _level
		_load_map_cam(_level)
#		splash.change_text(_label_1, _label_2)
#		splash.visible = true
#		timer_camp.wait_time = _time
#		timer_camp.start()
#		timer.wait_time = _time
#		timer.start()
	else:
		_load_map_cam(_level)

func _load_map_cam(_level):
	var m = _level.instance()
	if map:
		map.queue_free()
	map = m
	add_child(m)
#	Game.spawn_started()
	var test = get_tree().get_current_scene().connect("reset", m, "reset")
	if test != 0:
		print("error Singleton Map Handler connecting (map in cam) to reset from world gd")

	for x in get_tree().get_current_scene().pawns.get_child_count():
		print(x)
		pass

	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1
	
#	var e = get_tree().get_current_scene().connect("reset",m,"reset")
#	if !e:
#		print("error in map handler _load_map_cam: error connecting reset")

#func _on_Timer_timeout():
#	get_tree().paused = false
#	splash.visible = false
#
#func _on_Timer_Camp_Load_timeout():
#	_load_map_cam(level)
#	get_tree().paused = false
#	splash.visible = false
