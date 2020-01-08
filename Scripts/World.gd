extends Node

export(PackedScene) var player_controller
export(PackedScene) var arcade_start
export(PackedScene) var console_start
export(PackedScene) var demo_map
export(PackedScene) var campaign_map
#game_mode (1 arcade mode) (2 console and pc mode) (3 demo mode)
export var game_mode = 1

onready var players = $players
#warning-ignore:unused_class_variable
onready var pawns = $Pawns
onready var clearing_house = $Clearing_House
# warning-ignore:unused_class_variable
onready var level_loader =$Level_Loader
onready var line = $Line2D

var auto_respawn = true
var play_type = 2

#var p1_controller
#var p2_controller
#var p3_controller
#var p4_controller
#var p5_controller
#var p6_controller
#var p7_controller
#var p8_controller

var end_game_score = 1
#var map
var screen_loaded
var arcade_start_screen
var console_start_screen

signal game_over
#signal coin_up
#signal input_to_screen #movement up:1 left:2 right:3 down:4 start:5 back:6
signal reset
signal second

func draw_line(value):
#	print("trying to draw line")
	line.points = value

func _ready():
	init()

func init():
	if game_mode == 1:
		print("arcade game mode selected")
		var a = arcade_start.instance()
		arcade_start_screen = a 
		add_child(a)
		screen_loaded = a
		_start(Settings.max_num_of_player)
	
	elif game_mode == 2:
		print("console game mode selected")
		var a = console_start.instance()
		console_start_screen = a 
		add_child(a)
		screen_loaded = a
		_start(Settings.max_num_of_player)
	
	elif game_mode == 3:
		print("game mode 3: demo mode selected")
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
		_start(Settings.max_num_of_player)
		Map_Hand.load_map(demo_map)
	
	elif game_mode == 4:
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
		_start(Settings.max_num_of_player)
		Map_Hand.load_map(campaign_map)
	else:
		print("error in game mode type may not exceed 4 (world.gd) _check_game_over")

func _start(_players):
	print("spawning player controllers")
	for j in range(_players):
		print("spawn player controller ", j + 1, "in _start in world gd this should be done in mode?")
		Controllers.spawn_player_contoller(j+1, auto_respawn)
	
#func _game_over(_winner):
#	print("game over has beeen called in world gd this is not the best spot fot this is it fix that")
#	if !Settings.is_game_over:
#		emit_signal("game_over", _winner)
#		Settings.set_game_over(true)
##		is_game_over = true 
#		Map_Hand.clear_map()
#		if game_mode == 1:
#			HUD.game_over()
#		elif game_mode == 2:
#			HUD.game_over()

#func spawn_player_contoller(player_num, _auto_respawn):
#	var z = player_controller.instance()
#	players.add_child(z)
##	z.connect("change_spawn_pos",self,"get_spawn_spot")
#	z.connect("in_play",self,"set_in_play")
##	z.connect("player_score", self, "player_scores") 
#	z.connect("coin_insert", self, "coin_insert")
#	z.connect("use_credit", self, "use_credit")
##	z.pawn_num = Player_Stats     #<-------------this changes the pawns in demo mode
#	self.connect("game_over", z, "game_over")
#	self.connect("reset",z,"reset")
#	if player_num == 1:
#		p1_controller = z
#	elif player_num == 2:
#		p2_controller = z
#	elif player_num == 3:
#		p3_controller = z
#	elif player_num == 4:
#		p4_controller = z
#	elif player_num == 5:
#		p5_controller = z
#	elif player_num == 6:
#		p6_controller = z
#	elif player_num == 7:
#		p7_controller = z
#	elif player_num == 8:
#		p8_controller = z
#	z.init(player_num, _auto_respawn, game_mode, play_type)

func spawn_started():
	print("spawn started in world is this the best place for it")
	if Player_Stats.p1["in_play"]:
		Controllers.p1.spawn_pawn()
	if Player_Stats.p2["in_play"]:
		Controllers.p2.spawn_pawn()
	if Player_Stats.p3["in_play"]:
		Controllers.p3.spawn_pawn()
	if Player_Stats.p4["in_play"]:
		Controllers.p4.spawn_pawn()
	if Player_Stats.p5["in_play"]:
		Controllers.p5.spawn_pawn()
	if Player_Stats.p6["in_play"]:
		Controllers.p6.spawn_pawn()
	if Player_Stats.p7["in_play"]:
		Controllers.p7.spawn_pawn()
	if Player_Stats.p8["in_play"]:
		Controllers.p8.spawn_pawn()
	else:
		print("error no hud in world load map")

func _clean_house():
	for child in clearing_house.get_children():
		child.call_deferred("free")
#
#func set_in_play(_player):
#	print("set player ", _player, " in play")
#	if _player == 1:
#		Player_Stats.p1["exist"] = true
#	elif _player == 2:
#		Player_Stats.p2["exist"] = true
#	elif _player == 3:
#		Player_Stats.p3["exist"] = true
#	elif _player == 4:
#		Player_Stats.p4["exist"] = true
#	elif _player == 5:
#		Player_Stats.p5["exist"] = true
#	elif _player == 6:
#		Player_Stats.p6["exist"] = true
#	elif _player == 7:
#		Player_Stats.p7["exist"] = true
#	elif _player == 8:
#		Player_Stats.p8["exist"] = true

func arcade_reset():
	emit_signal("reset")
#	Game.set_game_over(false)
	var a = arcade_start.instance()
	arcade_start_screen = a 
	add_child(a)
	screen_loaded = a
#	if map:
#		map.propagate_call("queue_free")
#		map = null
#	else:
#		pass
#	HUD.reset()
#	Player_Stats.reset()
#	Settings.set_game_over(false) #maybe change this to a reset
#	init()

func _on_Timer_timeout():
	emit_signal("second")