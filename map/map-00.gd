extends Node2D

export var splash = false
export var top_text = "top_text"
export var body_text = "body_text testing levely stuff blah blah ... blah!!!"
export var camera_move = false
export var camera_max_right = 1920
export var background = 1
onready var player_spawns = $Player_spawns
onready var parts = $Map_parts 
var next_spawn_spot = 0
var spawn_spots = []
var nav_system
var first = true
var num_in_play = 0

func _ready():
#	Game.mode = 2
	Game.use_lives() #checks if number of lives are used
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print("map nav system found")
	else:
		print("map has no navigation")
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
#	var spot = spawn_spots.pop_front()
	return spawn_spots.pop_front().position
#	if first:
#		num_in_play += 1
#		next_spawn_spot += 1
#		if num_in_play >= Player_Stats.get_num_in_game():
#			first = false
#		print(num_in_play,"   ",next_spawn_spot, "   ",first)
#		return player_spawns.get_child(next_spawn_spot).position
#
#	for i in player_spawns.get_child_count():
#		if player_spawns.get_child(i).can_spawn():
##			print("next spawn spot should be true  = ",player_spawns.get_child(i).can_spawn())
#			spawn_spots.append(player_spawns.get_child(i))

#	next_spawn_spot += 1
#	if spawn_spots.size() <= next_spawn_spot:
#		next_spawn_spot = 0 
	
#	var this_pos = randi() % (spawn_spots.size())
#	print(this_pos)
#	spawn_spots[this_pos].set_spawn(false)
#	return spawn_spots[this_pos].position
#	return spawn_spots[int(rand_range(0,spawn_spots.size()))].position

#	if next_spawn_spot > player_spawns.get_child_count() - 1:
#		next_spawn_spot = 0
#	return player_spawns.get_child(next_spawn_spot).position

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

#func delete_square(_pos):
#	var _spot = map.world_to_map(_pos)
#	map.set_cellv(_spot, -1, false, false, false)

func _on_Start_Timer_timeout():
	parts.propagate_call("start")
