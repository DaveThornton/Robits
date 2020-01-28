extends Node2D

export var splash = false
export var top_text = "top_text"
export var body_text = "body_text testing levely stuff blah blah ... blah!!!"
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

	if splash:
		Menu_Hand.splash(top_text, body_text, 1.5, true)

func next_spawn_pos():
	next_spawn_spot += 1
	if next_spawn_spot > player_spawns.get_child_count() - 1:
		next_spawn_spot = 0
	return player_spawns.get_child(next_spawn_spot).position

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