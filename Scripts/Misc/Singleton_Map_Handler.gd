extends Node

onready var splash_scn = $"M10-Splash"
onready var splash_timer = $Splash_Timer
var map
var next_map
var default_splash_time = 1.0
onready var clearing_house = $clearing_house
onready var parts = $Parts
export(PackedScene) var player_spawn_vs

var level

signal wow
signal splash_done

func spawn_pos():
	if !Game.get_game_over():
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
		print_debug("error Singleton Map Handler connecting map to reset from world gd")
	# var test2 = map.connect("call_pow",map ,"call_pow")
	# if test2 != 0:
	# 	print_debug("error Singleton Map Handler connecting map to pow from world gd")

func add_kid_to_map(_obj):
	if is_instance_valid(map):
		map.add_child(_obj) #weird error
	else:
		clearing_house.add_child(_obj)

func add_player_spawn(part):
	if is_instance_valid(map):
		map.add_player_spawn(part) #weird error
	else:
		clearing_house.add_child(part)

func add_bg_to_map(_obj):
	call_deferred("_add_bg_to_map",_obj)
func _add_bg_to_map(_obj):
	if is_instance_valid(map):
		map.badguys.add_child(_obj)#weird error
	else:
		clearing_house.add_child(_obj)

func add_part_to_map(part):
	map.add_kid_to_parts(part)

func set_map(_map):
	if map:
		map.call_deferred("queue_free")
	var m = _map.instance()
	map = m
	add_child(m)

	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func set_next_map(_map):
	next_map = _map

func load_next_map():
	if next_map:
		load_map(next_map)
	else:
		print_debug("error in map handler load next map - no next map")

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
		map.call_deferred("queue_free")
	map = m
	add_child(m)

	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func call_pow():
	emit_signal("wow")

func add_pos(area):
	if map != null:
		map.add_pos(area)

func remove_pos(area):
	if map != null:
		map.remove_pos(area)

func splash(_top, _body):
	splash_scn.visible = true
	splash_scn.change_text(_top, _body)
	$Splash_Timer.start()
	
func splash_w_timer(_top,_body,_time):
	splash_timer.wait_time = _time
	splash(_top, _body)

func _on_Splash_Timer_timeout():
	emit_signal("splash_done")
	get_tree().paused = false
	splash_scn.change_text("error", "error in map hand")
	splash_scn.visible = false
	splash_timer.wait_time = default_splash_time

func get_map_part(num): return parts.get_part(num)