extends Node

export(PackedScene) var player_controller
#export(PackedScene) var boom
export(PackedScene) var in_game_hud
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

var p1_exists = false
var p2_exists = false
var p3_exists = false
var p4_exists = false
var p5_exists = false
var p6_exists = false
var p7_exists = false
var p8_exists = false

var p1_started = false
var p2_started = false
var p3_started = false
var p4_started = false
var p5_started = false
var p6_started = false
var p7_started = false
var p8_started = false

var p1_controller
var p2_controller
var p3_controller
var p4_controller
var p5_controller
var p6_controller
var p7_controller
var p8_controller

var p1_kills = 0
var p2_kills = 0
var p3_kills = 0
var p4_kills = 0
var p5_kills = 0
var p6_kills = 0
var p7_kills = 0
var p8_kills = 0

var p1_deaths = 0
var p2_deaths = 0
var p3_deaths = 0
var p4_deaths = 0
var p5_deaths = 0
var p6_deaths = 0
var p7_deaths = 0
var p8_deaths = 0

var p1_score = 0
var p2_score = 0
var p3_score = 0
var p4_score = 0
var p5_score = 0
var p6_score = 0
var p7_score = 0
var p8_score = 0

var p1_shots = 0
var p2_shots = 0
var p3_shots = 0
var p4_shots = 0
var p5_shots = 0
var p6_shots = 0
var p7_shots = 0
var p8_shots = 0

var p1_hits = 0
var p2_hits = 0
var p3_hits = 0
var p4_hits = 0
var p5_hits = 0
var p6_hits = 0
var p7_hits = 0
var p8_hits = 0

var p1_credits = 0
var p2_credits = 0
var p3_credits = 0
var p4_credits = 0
var p5_credits = 0
var p6_credits = 0
var p7_credits = 0
var p8_credits = 0

#var credits = 0
var is_game_over = false 
var end_game_score = 10

var how_many_players = 2
#var spawn_spot
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
#	pass

func _ready():
	init()

func init():
	if game_mode == 1:
		print("arcade game mode selected")
		var a = arcade_start.instance()
		arcade_start_screen = a 
		add_child(a)
		screen_loaded = a
		_start(how_many_players)
	
	elif game_mode == 2:
		print("console game mode selected")
		var a = console_start.instance()
		console_start_screen = a 
		add_child(a)
		screen_loaded = a
		_start(how_many_players)
	
	elif game_mode == 3:
		print("game mode 3: demo mode selected")
		if how_many_players == 1:
			p1_started = true
		elif how_many_players == 2:
			p1_started = true
			p2_started = true
		elif how_many_players == 3:
			p1_started = true
			p2_started = true
			p3_started = true
		elif how_many_players == 4:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
		elif how_many_players == 5:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
		elif how_many_players == 6:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
		elif how_many_players == 7:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
			p7_started = true
		else:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
			p7_started = true
			p8_started = true
		_start(how_many_players)
		load_map(demo_map)
	
	elif game_mode == 4:
		if how_many_players == 1:
			p1_started = true
		elif how_many_players == 2:
			p1_started = true
			p2_started = true
		elif how_many_players == 3:
			p1_started = true
			p2_started = true
			p3_started = true
		elif how_many_players == 4:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
		elif how_many_players == 5:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
		elif how_many_players == 6:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
		elif how_many_players == 7:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
			p7_started = true
		else:
			p1_started = true
			p2_started = true
			p3_started = true
			p4_started = true
			p5_started = true
			p6_started = true
			p7_started = true
			p8_started = true
		_start(how_many_players)
		load_map(campaign_map)
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
	z.connect("change_spawn_pos",self,"get_spawn_spot")
	z.connect("in_play",self,"set_in_play")
	z.connect("player_score", self, "player_scores") 
	z.connect("coin_insert", self, "coin_insert")
	z.connect("use_credit", self, "use_credit")
	z.connect("menu_signal", self, "screen_input")
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
		
	z.init(player_num, _auto_respawn, game_mode)
	
func player_scores( _dead_player, _player, _points, _with):
	print(_player," scores ", _points, " with a ", _with," on player ", _dead_player)
	if !is_game_over:
		if _dead_player == 1:
			p1_score -= 1
			p1_deaths += 1
			hud.change_player_score(_dead_player, p1_score)
		elif _dead_player == 2:
			p2_score -= 1
			p2_deaths += 1
			hud.change_player_score(_dead_player, p2_score)
		elif _dead_player == 3:
			p3_score -= 1
			p3_deaths += 1
			hud.change_player_score(_dead_player, p3_score)
		elif _dead_player == 4:
			p4_score -= 1
			p4_deaths += 1
			hud.change_player_score(_dead_player, p4_score)
		elif _dead_player == 5:
			p5_score -= 1
			p5_deaths += 1
			hud.change_player_score(_dead_player, p5_score)
		elif _dead_player == 6:
			p6_score -= 1
			p6_deaths += 1
			hud.change_player_score(_dead_player, p6_score)
		elif _dead_player == 7:
			p7_score -= 1
			p7_deaths += 1
			hud.change_player_score(_dead_player, p7_score)
		elif _dead_player == 8:
			p8_score -= 1
			p8_deaths += 1
			hud.change_player_score(_dead_player, p8_score)
		else:
			print("error in world player _scores")

		if _player == 1:
			p1_score += _points
			p1_hits += 1
			hud.change_player_score(_player, p1_score)
			if p1_score >= end_game_score:
				_game_over(_player)
		elif _player == 2:
			p2_score += _points
			p2_hits += 1
			hud.change_player_score(_player, p2_score)
			if p2_score >= end_game_score:
				_game_over(_player)
		elif _player == 3:
			p3_score += _points
			p3_hits += 1
			hud.change_player_score(_player, p3_score)
			if p3_score >= end_game_score:
				_game_over(_player)
		elif _player == 4:
			p4_score += _points
			p4_hits += 1
			hud.change_player_score(_player, p4_score)
			if p4_score >= end_game_score:
				_game_over(_player)
		elif _player == 5:
			p5_score += _points
			p5_hits += 1
			hud.change_player_score(_player, p5_score)
			if p5_score >= end_game_score:
				_game_over(_player)
		elif _player == 6:
			p6_score += _points
			p6_hits += 1
			hud.change_player_score(_player, p6_score)
			if p6_score >= end_game_score:
				_game_over(_player)
		elif _player == 7:
			p7_score += _points
			p7_hits += 1
			hud.change_player_score(_player, p7_score)
			if p7_score >= end_game_score:
				_game_over(_player)
		elif _player == 8:
			p8_score += _points
			p8_hits += 1
			hud.change_player_score(_player, p8_score)
			if p8_score >= end_game_score:
				_game_over(_player)
#	else:
#		print("game over cant score")
		
	

#func _process(delta):
#	if Input.is_action_pressed("Exit"):
#		get_tree().quit()
#	print(pawns.get_child_count()) #pawns.get_children().size())

func _check_game_over():
	if game_mode == 1:
		pass
	elif game_mode == 2:
		pass
	elif game_mode == 3:
		pass
	else:
		print("error in game mode type (world.gd) _check_game_over")

func get_spawn_spot():
	if map:
		map.get_next_pos()

func set_spawn_spot(_pos):
	if p1_controller:
		p1_controller.set_spawn_spot(_pos)
	if p2_controller:
		p2_controller.set_spawn_spot(_pos)
	if p3_controller:
		p3_controller.set_spawn_spot(_pos)
	if p4_controller:
		p4_controller.set_spawn_spot(_pos)
	if p5_controller:
		p5_controller.set_spawn_spot(_pos)
	if p6_controller:
		p6_controller.set_spawn_spot(_pos)
	if p7_controller:
		p7_controller.set_spawn_spot(_pos)
	if p8_controller:
		p8_controller.set_spawn_spot(_pos)

func load_map( _map_to_load):
	var m = _map_to_load.instance()
	add_child(m)
#warning-ignore:return_value_discarded
	self.connect("reset",m,"reset")
	map = m
	get_spawn_spot()
	load_hud(in_game_hud)
	out_of_menu()
	if p1_started:
		p1_controller.spawn_pawn()
	if p2_started:
		p2_controller.spawn_pawn()
	if p3_started:
		p3_controller.spawn_pawn()
	if p4_started:
		p4_controller.spawn_pawn()
	if p5_started:
		p5_controller.spawn_pawn()
	if p6_started:
		p6_controller.spawn_pawn()
	if p7_started:
		p7_controller.spawn_pawn()
	if p8_started:
		p8_controller.spawn_pawn()
	if hud:
		update_hud()
	else:
		print("error no hud in world load map")

func load_hud(_hud_to_load):
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
		hud.update_player_hud_vis(p1_exists,p2_exists,p3_exists,p4_exists,p5_exists,p6_exists,p7_exists,p8_exists)

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
	if _player == 1:
		p1_exists = true 
	elif _player == 2:
		p2_exists = true 
	elif _player == 3:
		p3_exists = true 
	elif _player == 4:
		p4_exists = true 
	elif _player == 5:
		p5_exists = true 
	elif _player == 6:
		p6_exists = true 
	elif _player == 7:
		p7_exists = true 
	elif _player == 8:
		p8_exists = true 
	if hud:
		update_hud()
		
func set_all_out_of_play():
	p1_exists = false
	p2_exists = false
	p3_exists = false
	p4_exists = false
	p5_exists = false
	p6_exists = false
	p7_exists = false
	p8_exists = false

func coin_insert( _player):
#	print("coin inserted for player ",_player)
	if _player == 1:
		p1_credits += 1
	elif _player == 2:
		p2_credits += 1
	elif _player == 3:
		p3_credits += 1
	elif _player == 4:
		p4_credits += 1
	elif _player == 5:
		p5_credits += 1
	elif _player == 6:
		p6_credits += 1
	elif _player == 7:
		p7_credits += 1
	elif _player == 8:
		p8_credits += 1
	emit_signal("coin_up")
	can_player_start_arcade(_player)
	
func use_credit( _player):
#	print("coin used for player ", _player)
	if _player == 1:
		p1_credits -= 1
	elif _player == 2:
		p2_credits -= 1
	elif _player == 3:
		p3_credits -= 1
	elif _player == 4:
		p4_credits -= 1
	elif _player == 5:
		p5_credits -= 1
	elif _player == 6:
		p6_credits -= 1
	elif _player == 7:
		p7_credits -= 1
	elif _player == 8:
		p8_credits -= 1
	can_player_start_arcade(_player)

func can_player_start_arcade( _player):
	if _player == 1:
		if p1_credits >= 1:
			p1_controller.can_start = true
		else:
			p1_controller.can_start = false
	elif _player == 2:
		if p2_credits >= 1:
			p2_controller.can_start = true
		else:
			p2_controller.can_start = false
	elif _player == 3:
		if p3_credits >= 1:
			p3_controller.can_start = true
		else:
			p3_controller.can_start = false
	elif _player == 4:
		if p4_credits >= 1:
			p4_controller.can_start = true
		else:
			p4_controller.can_start = false
	elif _player == 5:
		if p5_credits >= 1:
			p5_controller.can_start = true
		else:
			p5_controller.can_start = false
	elif _player == 6:
		if p6_credits >= 1:
			p6_controller.can_start = true
		else:
			p6_controller.can_start = false
	elif _player == 7:
		if p7_credits >= 1:
			p7_controller.can_start = true
		else:
			p7_controller.can_start = false
	elif _player == 8:
		if p8_credits >= 1:
			p8_controller.can_start = true
		else:
			p8_controller.can_start = false
	else:
		print("error in world can player start arcade")

func shot(_player):
	if _player == 1:
		p1_shots += 1
	elif _player == 2:
		p2_shots += 1
	elif _player == 3:
		p3_shots += 1
	elif _player == 4:
		p4_shots += 1
	elif _player == 5:
		p5_shots += 1
	elif _player == 6:
		p6_shots += 1
	elif _player == 7:
		p7_shots += 1
	elif _player == 8:
		p8_shots += 1
	else:
		print("error in world shot")
#fix pointers
func nrg_update(_player, _nrg):
	if _player == 1:
		hud.update_p1_nrg(_nrg)
	elif _player == 2:
		hud.update_p2_nrg(_nrg)
	elif _player == 3:
		hud.update_p3_nrg(_nrg)
	elif _player == 4:
		hud.update_p4_nrg(_nrg)
	elif _player == 5:
		hud.update_p5_nrg(_nrg)
	elif _player == 6:
		hud.update_p6_nrg(_nrg)
	elif _player == 7:
		hud.update_p7_nrg(_nrg)
	elif _player == 8:
		hud.update_p8_nrg(_nrg)
	else:
		print("error on nrg update")

func ammo_update(_player, _ammo):
	if !is_game_over:
		if _player == 1:
			hud.update_p1_ammo(_ammo)
		elif _player == 2:
			hud.update_p2_ammo(_ammo)
		elif _player == 3:
			hud.update_p3_ammo(_ammo)
		elif _player == 4:
			hud.update_p4_ammo(_ammo)
		elif _player == 5:
			hud.update_p5_ammo(_ammo)
		elif _player == 6:
			hud.update_p6_ammo(_ammo)
		elif _player == 7:
			hud.update_p7_ammo(_ammo)
		elif _player == 8:
			hud.update_p8_ammo(_ammo)

#func delete_map_square(_pos):
#	var x = boom.instance()
#	add_child(x)
#	x.position = _pos
#	x.play()
#	print(_pos)
#	map.delete_square(_pos)
	
func arcade_reset():
	emit_signal("reset")
	if hud:
		hud.queue_free()
#		print("queue free the hud in reset func")
		hud = null
	if map:
#		print("deleting map at the reset")
		map.propagate_call("queue_free")
		map = null
	else:
		pass
#		print("map already deleted at arcade reset")
		
	p1_exists = false
	p2_exists = false
	p3_exists = false
	p4_exists = false
	p5_exists = false
	p6_exists = false
	p7_exists = false
	p8_exists = false
	
	p1_started = false
	p2_started = false
	p3_started = false
	p4_started = false
	p5_started = false
	p6_started = false
	p7_started = false
	p8_started = false

	p1_kills = 0
	p2_kills = 0
	p3_kills = 0
	p4_kills = 0
	p5_kills = 0
	p6_kills = 0
	p7_kills = 0
	p8_kills = 0
	
	p1_deaths = 0
	p2_deaths = 0
	p3_deaths = 0
	p4_deaths = 0
	p5_deaths = 0
	p6_deaths = 0
	p7_deaths = 0
	p8_deaths = 0
	
	p1_score = 0
	p2_score = 0
	p3_score = 0
	p4_score = 0
	p5_score = 0
	p6_score = 0
	p7_score = 0
	p8_score = 0
	
	p1_shots = 0
	p2_shots = 0
	p3_shots = 0
	p4_shots = 0
	p5_shots = 0
	p6_shots = 0
	p7_shots = 0
	p8_shots = 0
	
	p1_hits = 0
	p2_hits = 0
	p3_hits = 0
	p4_hits = 0
	p5_hits = 0
	p6_hits = 0
	p7_hits = 0
	p8_hits = 0
	
	is_game_over = false 
	init()

func _on_Timer_timeout():
	emit_signal("second")