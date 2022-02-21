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

export(PackedScene) var map_01
export(PackedScene) var map_02
export(PackedScene) var map_03
export(PackedScene) var map_04
export(PackedScene) var map_05
export(PackedScene) var map_06
export(PackedScene) var map_07
export(PackedScene) var map_08
export(PackedScene) var map_09

onready var p1_menu = $Menu_3x3_01
onready var p2_menu = $Menu_3x3_02
onready var p3_menu = $Menu_3x3_03
onready var p4_menu = $Menu_3x3_04
onready var p5_menu = $Menu_3x3_05
onready var p6_menu = $Menu_3x3_06
onready var p7_menu = $Menu_3x3_07
onready var p8_menu = $Menu_3x3_08

onready var lower_text = $Label

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false
var map_array = []

func _ready():
	pass # Replace with function body.


func update_lower_text(_text):
	lower_text = _text

func _start(_player):
	_set_ready(_player)
	HUD.set_pri(_player, 5)
	SFX.menu(3)
	if _get_ready_num() == Player_Stats.get_num_in_play():
		_next_screen()

func _next_screen():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var map_num_to_load = rng.randi_range(0,(map_array.size() - 1))
	var _map_to_load = map_array[map_num_to_load]
	Map_Hand.set_next_map(_map_to_load)
	HUD.load_screen(player_select_vs)
	call_deferred("free")


func _vote(_player):
	if _player == 1:
		_add_to_map_array(p1_menu.get_pos())
	elif _player == 2:
		_add_to_map_array(p2_menu.get_pos())
	elif _player == 3:
		_add_to_map_array(p3_menu.get_pos())
	elif _player == 4:
		_add_to_map_array(p4_menu.get_pos())
	elif _player == 5:
		_add_to_map_array(p5_menu.get_pos())
	elif _player == 6:
		_add_to_map_array(p6_menu.get_pos())
	elif _player == 7:
		_add_to_map_array(p7_menu.get_pos())
	elif _player == 8:
		_add_to_map_array(p8_menu.get_pos())

func _unvote(_player):
	if _player == 1:
		_remove_from_map_array(p1_menu.get_pos())
	elif _player == 2:
		_remove_from_map_array(p2_menu.get_pos())
	elif _player == 3:
		_remove_from_map_array(p3_menu.get_pos())
	elif _player == 4:
		_remove_from_map_array(p4_menu.get_pos())
	elif _player == 5:
		_remove_from_map_array(p5_menu.get_pos())
	elif _player == 6:
		_remove_from_map_array(p6_menu.get_pos())
	elif _player == 7:
		_remove_from_map_array(p7_menu.get_pos())
	elif _player == 8:
		_remove_from_map_array(p8_menu.get_pos())

func movement(_player, _dir):
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
	_vote(_player)
	
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
	_unvote(_player)

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



