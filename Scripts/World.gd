extends Node

export(PackedScene) var player_controller
export(PackedScene) var arcade_start
export(PackedScene) var arcade_end
export(PackedScene) var console_start
export(PackedScene) var console_end
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

var p1_exists = false
var p2_exists = false
var p3_exists = false
var p4_exists = false
var p5_exists = false
var p6_exists = false
var p7_exists = false
var p8_exists = false

var p1_controller
var p2_controller
var p3_controller
var p4_controller
var p5_controller
var p6_controller
var p7_controller
var p8_controller

var is_game_over = false 
var end_game_score = 2

var map
var hud
var screen_loaded
var arcade_start_screen
var console_start_screen

signal game_over
signal coin_up
signal input_to_screen #movement up:1 left:2 right:3 down:4 start:5 back:6
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
#		_start(how_many_players)
	
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
	for j in range(_players):
		spawn_player_contoller(j+1, auto_respawn)
	
func _game_over(_winner):
	if !is_game_over:
#		print("Game Over Winner is ",_winner)
		emit_signal("game_over", _winner)
		is_game_over = true 
		if hud:
			hud.visible = false
		if map:
#			print("deleting map at the reset")
			map.propagate_call("queue_free")
			map = null
		if game_mode == 1:
			load_screen(arcade_end)
		elif game_mode == 2:
			load_screen(console_end)

func spawn_player_contoller(player_num, _auto_respawn):
	var z = player_controller.instance()
	players.add_child(z)
#	z.connect("change_spawn_pos",self,"get_spawn_spot")
	z.connect("in_play",self,"set_in_play")
#	z.connect("player_score", self, "player_scores") 
	z.connect("coin_insert", self, "coin_insert")
	z.connect("use_credit", self, "use_credit")
#warning-ignore:return_value_discarded
	self.connect("game_over", z, "game_over")
#warning-ignore:return_value_discarded
	self.connect("reset",z,"reset")
#	print("spawned player")
	if player_num == 1:
		p1_controller = z
	elif player_num == 2:
		p2_controller = z
	elif player_num == 3:
		p3_controller = z
	elif player_num == 4:
		p4_controller = z
	elif player_num == 5:
		p5_controller = z
	elif player_num == 6:
		p6_controller = z
	elif player_num == 7:
		p7_controller = z
	elif player_num == 8:
		p8_controller = z
		
	z.init(player_num, _auto_respawn, game_mode, play_type)
	
#func player_scores( _dead_player, _player, _points, _with):
#	Player_Stats.add_kill(_dead_player, _player, _points, _with)

func check_game_over():
	if game_mode == 1:
		if Player_Stats.p1["score"] >= end_game_score:
			_game_over(1)
		elif Player_Stats.p2["score"] >= end_game_score:
			_game_over(2)
		elif Player_Stats.p3["score"] >= end_game_score:
			_game_over(3)
		elif Player_Stats.p4["score"] >= end_game_score:
			_game_over(4)
		elif Player_Stats.p5["score"] >= end_game_score:
			_game_over(5)
		elif Player_Stats.p6["score"] >= end_game_score:
			_game_over(6)
		elif Player_Stats.p7["score"] >= end_game_score:
			_game_over(7)
		elif Player_Stats.p8["score"] >= end_game_score:
			_game_over(8)
	elif game_mode == 2:
		pass
	elif game_mode == 3:
		pass
	else:
		print("error in game mode type (world.gd) _check_game_over")

func spawn_started():
#	Menu_Hand.load_hud(in_game_hud)
	if Player_Stats.p1["in_play"]:
		p1_controller.spawn_pawn()
	if Player_Stats.p2["in_play"]:
		p2_controller.spawn_pawn()
	if Player_Stats.p3["in_play"]:
		p3_controller.spawn_pawn()
	if Player_Stats.p4["in_play"]:
		p4_controller.spawn_pawn()
	if Player_Stats.p5["in_play"]:
		p5_controller.spawn_pawn()
	if Player_Stats.p6["in_play"]:
		p6_controller.spawn_pawn()
	if Player_Stats.p7["in_play"]:
		p7_controller.spawn_pawn()
	if Player_Stats.p8["in_play"]:
		p8_controller.spawn_pawn()
	if hud:
		update_hud()
	else:
		print("error no hud in world load map")

func load_hud(_hud_to_load):
	if hud:
		hud.queue_free()
	var h = _hud_to_load.instance()
	add_child(h)
	hud = h

func load_screen(_screen_to_load):
	var s = _screen_to_load.instance()
	add_child(s)
	screen_loaded = s

func screen_input( _player, _dir):
	if screen_loaded:
		emit_signal("input_to_screen",_player, _dir)

func update_hud():
	if !is_game_over:
		hud.update_player_hud_vis(Player_Stats.p1["exist"],
		Player_Stats.p2["exist"], Player_Stats.p3["exist"],
		Player_Stats.p4["exist"], Player_Stats.p5["exist"],
		Player_Stats.p6["exist"], Player_Stats.p7["exist"],
		Player_Stats.p8["exist"])

func add_kid_to_map(_obj):
	if map:
		map.add_child(_obj)
	else:
		clearing_house.add_child(_obj)

func _clean_house():
	for child in clearing_house.get_children():
		child.call_deferred("free")

func out_of_menu():
	if p1_controller:
		p1_controller.in_menu = false
	if p2_controller:
		p2_controller.in_menu = false
	if p3_controller:
		p3_controller.in_menu = false
	if p4_controller:
		p4_controller.in_menu = false
	if p5_controller:
		p5_controller.in_menu = false
	if p6_controller:
		p6_controller.in_menu = false
	if p7_controller:
		p7_controller.in_menu = false
	if p8_controller:
		p8_controller.in_menu = false

func in_to_menu():
	if p1_controller:
		p1_controller.in_menu = true
	if p2_controller:
		p2_controller.in_menu = true
	if p3_controller:
		p3_controller.in_menu = true
	if p4_controller:
		p4_controller.in_menu = true
	if p5_controller:
		p5_controller.in_menu = true
	if p6_controller:
		p6_controller.in_menu = true
	if p7_controller:
		p7_controller.in_menu = true
	if p8_controller:
		p8_controller.in_menu = true

func set_in_play(_player):
	print("set all in play world.gd")
	if _player == 1:
		Player_Stats.p1["exist"] = true
	elif _player == 2:
		Player_Stats.p2["exist"] = true
	elif _player == 3:
		Player_Stats.p3["exist"] = true
	elif _player == 4:
		Player_Stats.p4["exist"] = true
	elif _player == 5:
		Player_Stats.p5["exist"] = true
	elif _player == 6:
		Player_Stats.p6["exist"] = true
	elif _player == 7:
		Player_Stats.p7["exist"] = true
	elif _player == 8:
		Player_Stats.p8["exist"] = true
	if hud:
		update_hud()
		
func set_all_out_of_play():
	print("set all out of play world.gd i broke it on purpose whats wrong now")
#	p1_exists = false
#	p2_exists = false
#	p3_exists = false
#	p4_exists = false
#	p5_exists = false
#	p6_exists = false
#	p7_exists = false
#	p8_exists = false

func coin_insert( _player):
	if _player == 1:
		Player_Stats.p1["credit"] += 1
	elif _player == 2:
		Player_Stats.p2["credit"] += 1
	elif _player == 3:
		Player_Stats.p3["credit"] += 1
	elif _player == 4:
		Player_Stats.p4["credit"] += 1
	elif _player == 5:
		Player_Stats.p5["credit"] += 1
	elif _player == 6:
		Player_Stats.p6["credit"] += 1
	elif _player == 7:
		Player_Stats.p7["credit"] += 1
	elif _player == 8:
		Player_Stats.p8["credit"] += 1
	emit_signal("coin_up")
	can_player_start_arcade(_player)
	
func use_credit( _player):
	if _player == 1:
		Player_Stats.p1["credit"] -= 1
	elif _player == 2:
		Player_Stats.p2["credit"] -= 1
	elif _player == 3:
		Player_Stats.p3["credit"] -= 1
	elif _player == 4:
		Player_Stats.p4["credit"] -= 1
	elif _player == 5:
		Player_Stats.p5["credit"] -= 1
	elif _player == 6:
		Player_Stats.p6["credit"] -= 1
	elif _player == 7:
		Player_Stats.p7["credit"] -= 1
	elif _player == 8:
		Player_Stats.p8["credit"] -= 1
	can_player_start_arcade(_player)

func can_player_start_arcade( _player):
	if _player == 1:
		if Player_Stats.p1["credit"] >= 1:
			p1_controller.can_start = true
		else:
			p1_controller.can_start = false
	elif _player == 2:
		if Player_Stats.p2["credit"] >= 1:
			p2_controller.can_start = true
		else:
			p2_controller.can_start = false
	elif _player == 3:
		if Player_Stats.p3["credit"] >= 1:
			p3_controller.can_start = true
		else:
			p3_controller.can_start = false
	elif _player == 4:
		if Player_Stats.p4["credit"] >= 1:
			p4_controller.can_start = true
		else:
			p4_controller.can_start = false
	elif _player == 5:
		if Player_Stats.p5["credit"] >= 1:
			p5_controller.can_start = true
		else:
			p5_controller.can_start = false
	elif _player == 6:
		if Player_Stats.p6["credit"] >= 1:
			p6_controller.can_start = true
		else:
			p6_controller.can_start = false
	elif _player == 7:
		if Player_Stats.p7["credit"] >= 1:
			p7_controller.can_start = true
		else:
			p7_controller.can_start = false
	elif _player == 8:
		if Player_Stats.p8["credit"] >= 1:
			p8_controller.can_start = true
		else:
			p8_controller.can_start = false
	else:
		print("error in world can player start arcade")
#
#func nrg_update(_player, _nrg):
#	if _player == 1:
#		hud.update_p1_nrg(_nrg)
#	elif _player == 2:
#		hud.update_p2_nrg(_nrg)
#	elif _player == 3:
#		hud.update_p3_nrg(_nrg)
#	elif _player == 4:
#		hud.update_p4_nrg(_nrg)
#	elif _player == 5:
#		hud.update_p5_nrg(_nrg)
#	elif _player == 6:
#		hud.update_p6_nrg(_nrg)
#	elif _player == 7:
#		hud.update_p7_nrg(_nrg)
#	elif _player == 8:
#		hud.update_p8_nrg(_nrg)
#	else:
#		print("error on nrg update")
#func ammo_update(_player, _ammo):
#	if !is_game_over:
#		if _player == 1:
#			hud.update_p1_ammo(_ammo)
#		elif _player == 2:
#			hud.update_p2_ammo(_ammo)
#		elif _player == 3:
#			hud.update_p3_ammo(_ammo)
#		elif _player == 4:
#			hud.update_p4_ammo(_ammo)
#		elif _player == 5:
#			hud.update_p5_ammo(_ammo)
#		elif _player == 6:
#			hud.update_p6_ammo(_ammo)
#		elif _player == 7:
#			hud.update_p7_ammo(_ammo)
#		elif _player == 8:
#			hud.update_p8_ammo(_ammo)

func arcade_reset():
	emit_signal("reset")
	if hud:
		hud.queue_free()
		hud = null
	if map:
		map.propagate_call("queue_free")
		map = null
	else:
		pass
	Player_Stats.reset()
	is_game_over = false 
	init()

func _on_Timer_timeout():
	emit_signal("second")