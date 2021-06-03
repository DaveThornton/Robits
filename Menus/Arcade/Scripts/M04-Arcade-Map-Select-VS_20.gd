extends Node2D

export(PackedScene) var player_select_vs
export(PackedScene) var map
export(PackedScene) var map_01
export(PackedScene) var map_02
export(PackedScene) var map_03
export(PackedScene) var map_04
export(PackedScene) var map_05
export(PackedScene) var map_06
export(PackedScene) var map_07
export(PackedScene) var map_08
export(PackedScene) var map_09
export(PackedScene) var map_10
export(PackedScene) var map_11
export(PackedScene) var map_12
export(PackedScene) var map_13
export(PackedScene) var map_14
export(PackedScene) var map_15
export(PackedScene) var map_16
export(PackedScene) var map_17
export(PackedScene) var map_18
export(PackedScene) var map_19
export(PackedScene) var map_20
export(PackedScene) var map_21
export(PackedScene) var map_22
export(PackedScene) var map_23
export(PackedScene) var map_24
export(PackedScene) var map_25
export(PackedScene) var map_26
export(PackedScene) var map_27
export(PackedScene) var map_28
export(PackedScene) var map_29
export(PackedScene) var map_30
export(PackedScene) var map_31
export(PackedScene) var map_32
export(PackedScene) var map_33
export(PackedScene) var map_34
export(PackedScene) var map_35
export(PackedScene) var map_36
export(PackedScene) var map_37
export(PackedScene) var map_38
export(PackedScene) var map_39
export(PackedScene) var map_40

onready var p1_menu = $Menu_5x4_01
onready var p2_menu = $Menu_5x4_02
onready var p3_menu = $Menu_5x4_03
onready var p4_menu = $Menu_5x4_04
onready var p5_menu = $Menu_5x4_05
onready var p6_menu = $Menu_5x4_06
onready var p7_menu = $Menu_5x4_07
onready var p8_menu = $Menu_5x4_08
onready var maps_pics = $Menu_5x4_Map

var maps = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27]
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
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print("error M04 Arcade map select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade map select VS connect input to screen")
	HUD.menu_state()
	menu_check()
	randomize()
	maps.shuffle()
	_set_maps()

func _start(_player):
	_set_ready(_player)
	HUD.set_pri(_player, 5)
	SFX.play("Menu_Select_02")
	if _get_ready_num() == Player_Stats.get_num_in_play():
		_next_screen()

func _next_screen():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var map_num_to_load = rng.randi_range(0,(map_array.size() - 1))
	var _map_to_load = map_array[map_num_to_load]
	Map_Hand.set_next_map(_map_to_load)
	HUD.load_screen(player_select_vs)
#	Map_Hand.load_map(_map_to_load)
#	HUD.mode = 2
	call_deferred("free")

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

func _add_to_map_array(_num):
	map_array.append(_get_map(maps_pics.return_map_from_spot(_num)))

func _remove_from_map_array(_num):
	map_array.erase(_get_map(_num))

func _get_map(_num):
	if _num == 1:
		return map_01
	elif _num == 2:
		return map_02
	elif _num == 3:
		return map_03
	elif _num == 4:
		return map_04
	elif _num == 5:
		return map_05
	elif _num == 6:
		return map_06
	elif _num == 7:
		return map_07
	elif _num == 8:
		return map_08
	elif _num == 9:
		return map_09
	elif _num == 10:
		return map_10
	elif _num == 11:
		return map_11
	elif _num == 12:
		return map_12
	elif _num == 13:
		return map_13
	elif _num == 14:
		return map_14
	elif _num == 15:
		return map_15
	elif _num == 16:
		return map_16
	elif _num == 17:
		return map_17
	elif _num == 18:
		return map_18
	elif _num == 19:
		return map_19
	elif _num == 20:
		return map_20
	elif _num == 21:
		return map_21
	elif _num == 22:
		return map_22
	elif _num == 23:
		return map_23
	elif _num == 24:
		return map_24
	elif _num == 25:
		return map_25
	elif _num == 26:
		return map_26
	elif _num == 27:
		return map_27
	elif _num == 28:
		return map_28
	elif _num == 29:
		return map_29
	elif _num == 30:
		return map_30
	elif _num == 31:
		return map_31
	elif _num == 32:
		return map_32
	elif _num == 33:
		return map_33
	elif _num == 34:
		return map_34
	elif _num == 35:
		return map_35
	elif _num == 36:
		return map_36
	elif _num == 37:
		return map_37
	elif _num == 38:
		return map_38
	elif _num == 39:
		return map_39
	elif _num == 40:
		return map_40
	else:
		print("invalid _num on _map_get in Arcade Map Select VS")
		return map

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
	SFX.play("Menu_Error_13")
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

func _set_maps():
	maps.resize(20)
	for m in maps.size():
		maps_pics.set_map( (m + 1) ,maps.pop_front())


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
