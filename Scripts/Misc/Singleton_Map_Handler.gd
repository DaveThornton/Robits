extends Node
var map
onready var splash = $Level_Load_Screen
#var splash = "res://Menus/Campaign/Level_Load_Screen.tscn"
onready var timer = $Timer
onready var timer_camp = $Timer_Camp_Load
#func _ready():
#	pass # Replace with function body.
var level

func spawn_pos():
	map = get_tree().get_current_scene().map #elemate this
	return map.next_spawn_pos()

func load_map( _map_to_load):
#	print("loading map")
	var m = _map_to_load.instance()
	map = m
	add_child(m)
	get_tree().get_current_scene().map = m
	Menu_Hand.load_arcade_hud()
	get_tree().get_current_scene().spawn_started()
	get_tree().get_current_scene().out_of_menu()

#warning-ignore:return_value_discarded
	get_tree().get_current_scene().connect("reset",m,"reset")

#func add_kid_to_map(_obj):                   <----------------never do this bad idea
#	call_deferred("_add_kid_to_map",_obj)
func add_kid_to_map(_obj):
	if map:
		map.add_child(_obj) #weird error
	else:
		get_tree().get_current_scene().clearing_house.add_child(_obj)
#
func load_map_cam(_level, _label_1, _label_2, _time, _show):
	if _show:
		level = _level
		splash.change_text(_label_1, _label_2)
		splash.visible = true
		timer_camp.wait_time = _time
		timer_camp.start()
#		timer.wait_time = _time
#		timer.start()
	else:
		_load_map_cam(_level)

func _load_map_cam(_level):
	var m = _level.instance()
	map = m
	get_tree().get_current_scene().add_child(m)
	get_tree().get_current_scene().map.call_deferred("free")
	get_tree().get_current_scene().map = m
	var e = get_tree().get_current_scene().connect("reset",m,"reset")
	if !e:
		print("error in level loader: error connecting reset")
#	timer.wait_time = _time
#	timer.start()
	for p in get_tree().get_current_scene().pawns.get_children():
		p.position = m.player_spawns.get_child(m.next_spawn_spot).position
		m.next_spawn_spot += 1

func _on_Timer_timeout():
	get_tree().paused = false
	splash.visible = false

func _on_Timer_Camp_Load_timeout():
	_load_map_cam(level)
	get_tree().paused = false
	splash.visible = false
