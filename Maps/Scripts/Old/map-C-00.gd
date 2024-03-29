extends Node2D

export var show_splash = false
export var title_text = "Title"
export var body_text = "Body"
export var camera_move = false
export var camera_max_left = 0
export var camera_max_right = 12000
export var splash_time = 1.5
export var background = 1
export var music = 0 # 0 is none
export var random_spawns = false
export var set_equip_weap_on = false
export var set_equip_weap_off = false

onready var player_spawns = $Player_Spawns
onready var player_spawns_out = $Player_Spawns_Out
onready var parts = $Map_parts
onready var badguys = $BadGuys
var spots_in_range = []
var next_spawn_spot = 0
var nav_system

signal start
signal activate(_num, _player)

func _ready():
#	print_debug(Game.mode)
	call_deferred("set_back",background)
	# FX.set_back(background)
	call_deferred("set_camera_max_right", camera_max_right)
	# FX.CAMERA.max_right = camera_max_right
	call_deferred("set_camera_move", camera_move)
	# FX.camera_move(camera_move)
	Game.use_lives()
	if show_splash:
		HUD.splash(title_text, body_text, splash_time, true)
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print_debug("map nav system found")
	else:
		print_debug("map has no navigation")
	if set_equip_weap_on:
		Settings.set_campaign_start_gun(true)
		for i in Settings.max_num_of_player: 
			Controllers.player_equip_start_weap(i + 1)
	elif set_equip_weap_off:
		Settings.set_campaign_start_gun(false)
		for i in Settings.max_num_of_player: 
			Controllers.player_remove_start_weap(i + 1)
	emit_signal("start")
#	var e = self.connect("reset",get_tree().get_current_scene(),"reset")
	var e = get_tree().get_current_scene().connect("reset",self,"reset")
	if !e:
		print_debug("error in map ready: error connecting reset")
	if camera_move:
		for s in 8:
			spots_in_range.append(player_spawns.get_child(s))
	call_deferred("_start")

func _start():
	emit_signal("start")
	if music > 0:
		SFX.music(true, music)
	else:
		SFX.music(false, music)

func add_pos(_spot):
	if spots_in_range.find(_spot) < 0:
		next_spawn_spot = 0
		spots_in_range.insert(0, _spot)
		if (FX.CAMERA.global_position.x - spots_in_range.back().global_position.x) >= 1920:
			spots_in_range.pop_back()
			#shouldnt have to do this the remove shouldt leave more than one 
			if (FX.CAMERA.global_position.x - spots_in_range.back().global_position.x) >= 1920:
				spots_in_range.pop_back()
#	print_debug("adding a spot ", _spot, "      spots in range count ---> ", spots_in_range.size())

func remove_pos(_spot):
	if spots_in_range.find(_spot) >= 0 && spots_in_range.size() > 0:
		next_spawn_spot = 0
		spots_in_range.erase(_spot)
#	print_debug("removing a spot ", _spot, "      spots in range count ---> ", spots_in_range.size())

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
	Map_Hand.clear_map()
	# call_deferred("queue_free")
	# reset()

func reset():
	print_debug("reset called in map c gd so it removed map")
	remove_map()

func activate_BG(_num, _player):
	emit_signal("activate",_num, _player)
	print_debug("map calling BGs go kill")

func _on_Start_Timer_timeout():
	pass

func set_back(_back):
	FX.set_back(_back)

func set_camera_move(_move):
	FX.CAMERA.move(_move)

func set_camera_max_right(_amount):
	FX.CAMERA.max_right = _amount

class MyCustomSorter:
	static func sort_distance(a,b):
		if abs(a.position) > abs(b.position):
			return true
		return false
