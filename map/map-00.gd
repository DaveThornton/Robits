extends Node2D

#onready var map = $TileMap
#onready var platforms = $TileMap2
onready var player_spawns = $Player_spawns
onready var parts = $Map_parts
var next_spawn_spot = 0
var nav_system

func _ready():
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print("map nav system found")
	else:
		print("map has no navigation")
#	print(map, platforms)
#	delete_square(player_spawns.get_child(next_spawn_spot).position)
#	print(player_spawns.get_child_count())
	# Called every time the node is added to the scene.
	# Initialization here
#	pass

func get_next_pos():
	var g = get_parent()
	g.set_spawn_spot(player_spawns.get_child(next_spawn_spot).position)
	next_spawn_spot += 1
#	print("next spawn spot  ", next_spawn_spot)
	if next_spawn_spot > player_spawns.get_child_count() - 1:
		next_spawn_spot = 0
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func remove_map():
	reset()

func reset():
	propagate_call("queue_free",[],false)

#
#func delete_square(_pos):
#	var _spot = map.world_to_map(_pos)
#	map.set_cellv(_spot, -1, false, false, false)

func _on_Start_Timer_timeout():
	parts.propagate_call("start")