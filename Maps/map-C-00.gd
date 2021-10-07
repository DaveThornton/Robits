extends Node2D

export var show_splash = false
export var title_text = "Title"
export var body_text = "Body"
export var camera_move = false
export var camera_max_left = 0
export var camera_max_right = 12000
export var splash_time = 1.5
export var background = 1
export var random_spawns = false
export var set_equip_weap_on = false
export var set_equip_weap_off = false

onready var player_spawns = $Player_Spawns
onready var player_spawns_out = $Player_Spawns_Out
onready var parts = $Map_parts
onready var badguys = $BadGuys
#onready var splash_screen = $"Splash/Level_Load_Screen"
var spots_in_range = []
var next_spawn_spot = 0
var nav_system

signal start
signal activate(_num, _player)

func _ready():
#	print(Game.mode)
	FX.set_back(background)
	FX.CAMERA.max_right = camera_max_right
	Game.use_lives()
	if show_splash:
		HUD.splash(title_text, body_text, splash_time, true)
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print("map nav system found")
	else:
		print("map has no navigation")
	FX.camera_move(camera_move)
	if set_equip_weap_on:
		Game.start_eq = true
		for i in Settings.max_num_of_player: 
			Controllers.player_equip_start_weap(i + 1)
	elif set_equip_weap_off:
		Game.start_eq = false
		for i in Settings.max_num_of_player: 
			Controllers.player_remove_start_weap(i + 1)
	emit_signal("start")
#	var e = self.connect("reset",get_tree().get_current_scene(),"reset")
	var e = get_tree().get_current_scene().connect("reset",self,"reset")
	if !e:
		print("error in map ready: error connecting reset")
	if camera_move:
		for s in 8:
			spots_in_range.append(player_spawns.get_child(s))

func add_pos(_spot):
	if spots_in_range.find(_spot) < 0:
		next_spawn_spot = 0
		spots_in_range.insert(0, _spot)
		if (FX.CAMERA.global_position.x - spots_in_range.back().global_position.x) >= 1920:
			spots_in_range.pop_back()
			#shouldnt have to do this the remove shouldt leave more than one 
			if (FX.CAMERA.global_position.x - spots_in_range.back().global_position.x) >= 1920:
				spots_in_range.pop_back()
#	print("adding a spot ", _spot, "      spots in range count ---> ", spots_in_range.size())

func remove_pos(_spot):
	if spots_in_range.find(_spot) >= 0 && spots_in_range.size() > 0:
		next_spawn_spot = 0
		spots_in_range.erase(_spot)
#	print("removing a spot ", _spot, "      spots in range count ---> ", spots_in_range.size())

func next_spawn_pos():
	if camera_move:
		if spots_in_range.size()-1 == next_spawn_spot:
			next_spawn_spot = 0
		next_spawn_spot += 1
	#	spots_in_range.sort_custom(MyCustomSorter,"sort_distance")
		return spots_in_range[0 + next_spawn_spot - 1].position
#	return spots_in_range[spots_in_range.size() - next_spawn_spot].position
	else:
		next_spawn_spot += 1
		if next_spawn_spot > player_spawns.get_child_count() - 1:
			next_spawn_spot = 0
		return player_spawns.get_child(next_spawn_spot).position

func remove_map():
	reset()

func reset():
	emit_signal("start")
	# propagate_call("queue_free",[],false)

func activate_BG(_num, _player):
	emit_signal("activate",_num, _player)
	print("map calling BGs go kill")

func _on_Start_Timer_timeout():
	emit_signal("start")
	# parts.propagate_call("start")

class MyCustomSorter:
	static func sort_distance(a,b):
		if abs(a.position) > abs(b.position):
			return true
		return false
