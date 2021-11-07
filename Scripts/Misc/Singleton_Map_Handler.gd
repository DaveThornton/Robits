extends Node

# export(PackedScene) var vs_map_01
# export(PackedScene) var vs_map_02
# export(PackedScene) var vs_map_03
# export(PackedScene) var vs_map_04
# export(PackedScene) var vs_map_05
# export(PackedScene) var vs_map_06
# export(PackedScene) var vs_map_07
# export(PackedScene) var vs_map_08
# export(PackedScene) var vs_map_09
# export(PackedScene) var vs_map_10
# export(PackedScene) var vs_map_11
# export(PackedScene) var vs_map_12
# export(PackedScene) var vs_map_13
# export(PackedScene) var vs_map_14
# export(PackedScene) var vs_map_15
# export(PackedScene) var vs_map_16
# export(PackedScene) var vs_map_17
# export(PackedScene) var vs_map_18
# export(PackedScene) var vs_map_19
# export(PackedScene) var vs_map_20
# export(PackedScene) var vs_map_21
# export(PackedScene) var vs_map_22
# export(PackedScene) var vs_map_23
# export(PackedScene) var vs_map_24
# export(PackedScene) var vs_map_25
# export(PackedScene) var vs_map_26
# export(PackedScene) var vs_map_27
# export(PackedScene) var vs_map_28
# export(PackedScene) var vs_map_29
# export(PackedScene) var vs_map_30
# export(PackedScene) var vs_map_31
# export(PackedScene) var vs_map_32
# export(PackedScene) var vs_map_33
# export(PackedScene) var vs_map_34
# export(PackedScene) var vs_map_35
# export(PackedScene) var vs_map_36
# export(PackedScene) var vs_map_37
# export(PackedScene) var vs_map_38
# export(PackedScene) var vs_map_39
# export(PackedScene) var vs_map_40

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
		map.add_child(_obj) #weird error
	else:
		clearing_house.add_child(_obj)

func add_bg_to_map(_obj):
	call_deferred("_add_bg_to_map",_obj)
func _add_bg_to_map(_obj):
	if is_instance_valid(map):
		map.badguys.add_child(_obj)#weird error
	else:
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
