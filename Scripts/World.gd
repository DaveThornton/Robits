extends Node

export(PackedScene) var arcade_start
export(PackedScene) var console_start
export(PackedScene) var demo_map

export var game_mode = 1 #     1 arcade       2 console       3 demo
export var max_players_in_demo = 8

onready var pawns = $Pawns
onready var clearing_house = $Clearing_House
onready var players = $players
onready var line = $Line2D

var screen_loaded
var arcade_start_screen 
var console_start_screen

signal reset
signal second

func draw_line(value):
	line.points = value

func _ready():
	init()

func init():
	if game_mode == 1:
		print_debug("arcade game mode selected")
		HUD.load_screen(arcade_start)
		Game.start(Settings.max_num_of_player)
	
	elif game_mode == 2:
		print_debug("console game mode selected this mode needs a lot of work before you go ahead")
		var a = console_start.instance()
		console_start_screen = a 
		add_child(a)
		screen_loaded = a
		Game.start(Settings.max_num_of_player)
	
	elif game_mode == 3:
		Settings.set_max_num_players(max_players_in_demo)
		print_debug("game mode 3: demo mode selected")
		if Settings.max_num_of_player == 1:
			Player_Stats.p1["in_play"] = true
		elif Settings.max_num_of_player == 2:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
		elif Settings.max_num_of_player == 3:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
		elif Settings.max_num_of_player == 4:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
			Player_Stats.p4["in_play"] = true
		elif Settings.max_num_of_player == 5:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
			Player_Stats.p4["in_play"] = true
			Player_Stats.p5["in_play"] = true
		elif Settings.max_num_of_player == 6:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
			Player_Stats.p4["in_play"] = true
			Player_Stats.p5["in_play"] = true
			Player_Stats.p6["in_play"] = true
		elif Settings.max_num_of_player == 7:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
			Player_Stats.p4["in_play"] = true
			Player_Stats.p5["in_play"] = true
			Player_Stats.p6["in_play"] = true
			Player_Stats.p7["in_play"] = true
		else:
			Player_Stats.p1["in_play"] = true
			Player_Stats.p2["in_play"] = true
			Player_Stats.p3["in_play"] = true
			Player_Stats.p4["in_play"] = true
			Player_Stats.p5["in_play"] = true
			Player_Stats.p6["in_play"] = true
			Player_Stats.p7["in_play"] = true
			Player_Stats.p8["in_play"] = true
		Game.start(Settings.max_num_of_player)
		Map_Hand.load_map(demo_map)
	else:
		print_debug("error in game mode type may not exceed 4 (world.gd) _check_game_over")

func _clean_house():
	for child in clearing_house.get_children():
		child.call_deferred("free")

func arcade_reset():
	High_Score.set_visible(false)
	print_debug("reset called in world")
	emit_signal("reset")
	HUD.load_screen(arcade_start)
	# Map_Hand.clear_map()

func _on_Timer_timeout():
	emit_signal("second")

func get_pawns():
	return pawns
