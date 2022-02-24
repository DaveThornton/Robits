extends Node2D
export var text_01 = "text 01"
export var text_02 = "text 02"
export var text_03 = "text 03"
export var text_04 = "text 04"
export var text_05 = "text 05"
export var text_06 = "text 06"
export var text_07 = "text 07"
export var text_08 = "text 08"
export var text_09 = "text 09"

onready var maps_menu = $Menu_3x3_Maps
onready var p1_menu = $Menu_3x3_01
onready var p2_menu = $Menu_3x3_02
onready var p3_menu = $Menu_3x3_03
onready var p4_menu = $Menu_3x3_04
onready var p5_menu = $Menu_3x3_05
onready var p6_menu = $Menu_3x3_06
onready var p7_menu = $Menu_3x3_07
onready var p8_menu = $Menu_3x3_08

onready var upper_text = $Label_Top
onready var lower_text = $Label_Bot

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false
var player = 0
var pos = 5

func _ready():
	player = Campaign.get_player_in_control()
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print("error M07 Arcade map select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade map select campaign connect input to screen")
	HUD.menu_state()
	menu_check()
	show_player(player)

func update_lower_text(_text):
	lower_text = _text

func _start(_player):
	_set_ready(_player)
	HUD.set_pri(_player, 5)
	SFX.menu(3)
	if _get_ready_num() == Player_Stats.get_num_in_play():
		_next_screen()

func _next_screen():
	var map_to_load = Campaign.get_map(pos)
	var t1 = Campaign.get_map_title(pos)
	var t2 = Campaign.get_map_discription(pos)
	Map_Hand.load_map_cam_first(map_to_load,t1,t2,1,true)
	Game.started = true
	# var rng = RandomNumberGenerator.new()
	# rng.randomize()
	# var map_num_to_load = rng.randi_range(0,(map_array.size() - 1))
	# var _map_to_load = map_array[map_num_to_load]
	# Map_Hand.set_next_map(_map_to_load)
	# Need to load map or what ever here
	call_deferred("free")

func update_pos(_pos):
	upper_text.text = Campaign.get_map_title(_pos)
	lower_text.text = Campaign.get_map_discription(_pos)
	maps_menu.update_pos(_pos)
	pos = _pos

func movement(_player, _dir):
	if player == _player:
		if _player == 1:
			if Player_Stats.p1["in_play"]:
				if !p1_ready:
					if _dir == 1:
						p1_menu.move_up()
					elif _dir == 2:
						p1_menu.move_left()
					elif _dir == 3:
						p1_menu.move_right()
					elif _dir == 4:
						p1_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p1["credit"] >= 1 && _dir == 0:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
			elif _dir == 0:
				HUD.ask_insert_coin(_player)
		elif _player == 2:
			if Player_Stats.p2["in_play"]:
				if !p2_ready:
					if _dir == 1:
						p2_menu.move_up()
					elif _dir == 2:
						p2_menu.move_left()
					elif _dir == 3:
						p2_menu.move_right()
					elif _dir == 4:
						p2_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p2["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 3:
			if Player_Stats.p3["in_play"]:
				if !p3_ready:
					if _dir == 1:
						p3_menu.move_up()
					elif _dir == 2:
						p3_menu.move_left()
					elif _dir == 3:
						p3_menu.move_right()
					elif _dir == 4:
						p3_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || 8:
						_back(_player)
			elif Player_Stats.p3["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 4:
			if Player_Stats.p4["in_play"]:
				if !p4_ready:
					if _dir == 1:
						p4_menu.move_up()
					elif _dir == 2:
						p4_menu.move_left()
					elif _dir == 3:
						p4_menu.move_right()
					elif _dir == 4:
						p4_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p4["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 5:
			if Player_Stats.p5["in_play"]:
				if !p5_ready:
					if _dir == 1:
						p5_menu.move_up()
					elif _dir == 2:
						p5_menu.move_left()
					elif _dir == 3:
						p5_menu.move_right()
					elif _dir == 4:
						p5_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p5["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 6:
			if Player_Stats.p6["in_play"]:
				if !p6_ready:
					if _dir == 1:
						p6_menu.move_up()
					elif _dir == 2:
						p6_menu.move_left()
					elif _dir == 3:
						p6_menu.move_right()
					elif _dir == 4:
						p6_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p6["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 7:
			if Player_Stats.p7["in_play"]:
				if !p7_ready:
					if _dir == 1:
						p7_menu.move_up()
					elif _dir == 2:
						p7_menu.move_left()
					elif _dir == 3:
						p7_menu.move_right()
					elif _dir == 4:
						p7_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p7["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		elif _player == 8:
			if Player_Stats.p8["in_play"]:
				if !p8_ready:
					if _dir == 1:
						p8_menu.move_up()
					elif _dir == 2:
						p8_menu.move_left()
					elif _dir == 3:
						p8_menu.move_right()
					elif _dir == 4:
						p8_menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				elif _dir == 7 || _dir == 8:
						_back(_player)
			elif Player_Stats.p8["credit"] >= 1:
				if _dir == 0:
					Player_Stats.use_credit(_player)
					menu_check()
					HUD.player_select(_player)
			else:
				if _dir == 0:
					HUD.ask_insert_coin(_player)
		else:
			print("error invald player in arcade player select VS")

	else:
		print("you are not in control player ", _player,". delete this it is in campaign map select screen")

func show_player(_player):
	p1_menu.visible = false
	p2_menu.visible = false
	p3_menu.visible = false
	p4_menu.visible = false
	p5_menu.visible = false
	p6_menu.visible = false
	p7_menu.visible = false
	p8_menu.visible = false
	if _player == 1:
		p1_menu.visible = true
	elif _player == 2:
		p2_menu.visible = true
	elif _player == 3:
		p3_menu.visible = true
	elif _player == 4:
		p4_menu.visible = true
	elif _player == 5:
		p5_menu.visible = true
	elif _player == 6:
		p6_menu.visible = true
	elif _player == 7:
		p7_menu.visible = true
	elif _player == 8:
		p8_menu.visible = true

func _set_ready(_player):
	if _player == 1:
		p1_ready = true
	elif _player == 2:
		p2_ready = true
	elif _player == 3:
		p3_ready = true
	elif _player == 4:
		p4_ready = true
	elif _player == 5:
		p5_ready = true
	elif _player == 6:
		p6_ready = true
	elif _player == 7:
		p7_ready = true
	elif _player == 8:
		p8_ready = true
	# _vote(_player)
	
func _back(_player):
	HUD.set_pri(_player,4)
	SFX.menu(4)
	if _player == 1:
		p1_ready = false
	elif _player == 2:
		p2_ready = false
	elif _player == 3:
		p3_ready = false
	elif _player == 4:
		p4_ready = false
	elif _player == 5:
		p5_ready = false
	elif _player == 6:
		p6_ready = false
	elif _player == 7:
		p7_ready = false
	elif _player == 8:
		p8_ready = false
	# _unvote(_player)

func _get_ready_num():
	var _ready_num = 0
	if p1_ready:
		_ready_num += 1
	if p2_ready:
		_ready_num += 1
	if p3_ready:
		_ready_num += 1
	if p4_ready:
		_ready_num += 1
	if p5_ready:
		_ready_num += 1
	if p6_ready:
		_ready_num += 1
	if p7_ready:
		_ready_num += 1
	if p8_ready:
		_ready_num += 1
	return _ready_num

func menu_check():
	if Player_Stats.p1["in_play"]:
		p1_menu.visible = true
	if Player_Stats.p2["in_play"]:
		p2_menu.visible = true
	if Player_Stats.p3["in_play"]:
		p3_menu.visible = true
	if Player_Stats.p4["in_play"]:
		p4_menu.visible = true
	if Player_Stats.p5["in_play"]:
		p5_menu.visible = true
	if Player_Stats.p6["in_play"]:
		p6_menu.visible = true
	if Player_Stats.p7["in_play"]:
		p7_menu.visible = true
	if Player_Stats.p8["in_play"]:
		p8_menu.visible = true

func get_text(_num):
	if _num == 1:
		return text_01
	elif _num == 2:
		return text_02
	elif _num == 3:
		return text_03
	elif _num == 4:
		return text_04
	elif _num == 5:
		return text_05
	elif _num == 6:
		return text_06
	elif _num == 7:
		return text_07
	elif _num == 8:
		return text_08
	elif _num == 9:
		return text_09
	else:
		return "error in the get text part of this script invalid number"




