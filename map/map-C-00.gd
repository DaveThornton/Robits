extends Node2D

export var show_splash = false
export var title_text = "Title"
export var body_text = "Body"
export var splash_time = 1.5

onready var player_spawns = $Player_spawns
onready var parts = $Map_parts
#onready var splash_screen = $"Splash/Level_Load_Screen"

var next_spawn_spot = 0
var nav_system

signal activate(_num, _player)

func _ready():
	if show_splash:
		HUD.splash(title_text, body_text, splash_time, true)
	if $"MP-04-Nav2D":
		nav_system = $"MP-04-Nav2D"
		print("map nav system found")
	else:
		print("map has no navigation")
	var e = self.connect("reset",get_tree().get_current_scene(),"reset")
	if !e:
		print("error in map ready: error connecting reset")

func next_spawn_pos():
	next_spawn_spot += 1
	if next_spawn_spot > player_spawns.get_child_count() - 1:
		next_spawn_spot = 0
	return player_spawns.get_child(next_spawn_spot).position

func remove_map():
	reset()

func reset():
	propagate_call("queue_free",[],false)

func activate_BG(_num, _player):
	emit_signal("activate",_num, _player)
	print("map calling BGs go kill")

func _on_Start_Timer_timeout():
	parts.propagate_call("start")
