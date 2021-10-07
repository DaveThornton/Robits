extends Node2D

export var splash = false
export var top_text = "top_text"
export var body_text = "body_text testing levely stuff blah blah ... blah!!!"
export var camera_move = false
export var camera_max_right = 1920
export var background = 1
export(PackedScene) var gun_01
export(PackedScene) var gun_02
export(PackedScene) var gun_03
export(PackedScene) var gun_04
export(PackedScene) var gun_05
export(PackedScene) var gun_06
export(PackedScene) var gun_07
export(PackedScene) var gun_08
export(PackedScene) var nade_01
export(PackedScene) var nade_02
export(PackedScene) var nade_03
export(PackedScene) var nade_04
export(PackedScene) var power_up_01
export(PackedScene) var power_up_02
export(PackedScene) var power_up_03
export(PackedScene) var power_up_04
onready var player_spawns = $Player_spawns
onready var parts = $Map_parts 
var next_spawn_spot = 0
var spawn_spots = []
var nav_system
var first = true
var num_in_play = 0
onready var pipes = $Pipes

signal start
signal activate(_num, _player)

func _ready():
#	Game.mode = 2
	Game.use_lives() #checks if number of lives are used
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print("map nav system found")
	else:
		print("map has no navigation")
	if $Pipes:
		pipes = $Pipes
	else:
		print("map has no pipes")
	FX.set_back(background)
	FX.CAMERA.max_right = camera_max_right
	FX.camera_move(camera_move)
	if splash:
		HUD.splash(top_text, body_text, 1.5, true)

func next_spawn_pos():
	if first:
		for i in player_spawns.get_child_count():
			spawn_spots.append(player_spawns.get_child(i))
		first = false
	spawn_spots.shuffle()
	return spawn_spots.pop_front().position

func get_gun(_num):
	if _num == 1:
		return gun_01
	elif _num == 2:
		return gun_02
	elif _num == 3:
		return gun_03
	elif _num == 4:
		return gun_04
	elif _num == 5:
		return gun_05
	elif _num == 6:
		return gun_06
	elif _num == 7:
		return gun_07
	elif _num == 8:
		return gun_08

func get_nade(_num):
	if _num == 1:
		return nade_01
	elif _num == 2:
		return nade_02
	elif _num == 3:
		return nade_03
	elif _num == 4:
		return nade_04

func get_power_up(_num):
	if _num == 1:
		return power_up_01
	elif _num == 2:
		return power_up_02
	elif _num == 3:
		return power_up_03
	elif _num == 4:
		return power_up_04

func remove_spawn_pos(_pos):
	if spawn_spots.has(_pos):
		spawn_spots.erase(_pos)

func add_spawn_pos(_pos):
	if !spawn_spots.has(_pos):
		spawn_spots.append(_pos)

func remove_map():
	reset()

func reset():
	propagate_call("queue_free",[],false)

func activate_BG(_num, _player):
	emit_signal("activate",_num, _player)
	print("map calling BGs go kill")

func get_pipe(_num):
	if pipes:
		var pc = pipes.get_child_count()
		if pc > 0:
			for pipe in pc:
				if pipes.get_child(pipe).my_pipe_number == _num:
					return pipes.get_child(pipe)
			return null
		return null
	return null

func _on_Start_Timer_timeout():
	emit_signal("start")
	# parts.propagate_call("start")
