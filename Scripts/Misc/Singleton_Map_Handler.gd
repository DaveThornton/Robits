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
signal act_01
signal act_02
signal act_03
signal act_04

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

func add_kid_to_map(_obj):
	if is_instance_valid(map):
		map.add_kid_to_parts(_obj) #weird error
	else:
		clearing_house.add_child(_obj)

func add_kid_to_pick_ups(_obj):
	if is_instance_valid(map):
		map.add_kid_to_pick_ups(_obj) #weird error
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
		map.parts.add_child(_obj)#weird error
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

func get_map():
	return map

func load_map_cam_first(_level, _label_1, _label_2, _time, _show):
	$Splash_Timer.wait_time = _time
	if _show:
		splash(_label_1,_label_2)
	_load_map_cam(_level)
	Game.spawn_started()

func load_map_cam(_level, _label_1, _label_2, _time, _show):
	$Splash_Timer.wait_time = _time
	if _show:
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
		map.add_spawn_pos(area)

func remove_pos(area):
	if map != null:
		map.remove_spawn_pos(area)

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

func activate(_body, _num):
	match _num:
		1: emit_signal("act_01", _body)
		2: emit_signal("act_02", _body)
		3: emit_signal("act_03", _body)
		4: emit_signal("act_04", _body)

func connect_activate(_thing, _num):
	var _c = true
	match _num:
		0: print_debug(_thing, "  not connected to anything bc it was told to connedt to activation 00")
		1: _c = self.connect("act_01", _thing, "activate")
		2: _c = self.connect("act_02", _thing, "activate")
		3: _c = self.connect("act_03", _thing, "activate")
		4: _c = self.connect("act_04", _thing, "activate")
	if !_c:
		print_debug("error in connecting ", _thing, " didnt connect in map handler activation number ", _num)