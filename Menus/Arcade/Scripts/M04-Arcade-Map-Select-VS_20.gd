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

var maps = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
# var maps = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,32,33,34,35,36,37,38,39,40]
var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false

var map_array = []

var loading_next_screen = false

func _ready():
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print_debug("error M04 Arcade map select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print_debug("error in arcade map select VS connect input to screen")
	HUD.menu_state()
	menu_check()
	randomize()
	maps.shuffle()
	_set_maps()

func _start(_player):
	_set_ready(_player)
	HUD.set_pri(_player, 5)
	SFX.menu(2)
	if _get_ready_num() == Player_Stats.get_num_in_play() && !loading_next_screen:
		loading_next_screen = true
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
	if _player > 0 && _player < (Settings.get_max_num_players() + 1):
		if Player_Stats.get_in_play(_player):
			if !get_ready(_player):
				if _dir == 1:
					get_menu(_player).move_up()
				elif _dir == 2:
					get_menu(_player).move_left()
				elif _dir == 3:
					get_menu(_player).move_right()
				elif _dir == 4:
					get_menu(_player).move_down()
				elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
					_start(_player)
			elif _dir == 7 || _dir == 8:
					_back(_player)
		elif Player_Stats.get_credit(_player) >= 1 && _dir == 0: 
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
		elif _dir == 0:
			HUD.ask_insert_coin(_player)
	else:
		print_debug("error invald player in arcade player select VS")

func _vote(_player):
	match _player:
		1: _add_to_map_array(p1_menu.get_pos())
		2: _add_to_map_array(p2_menu.get_pos())
		3: _add_to_map_array(p3_menu.get_pos())
		4: _add_to_map_array(p4_menu.get_pos())
		5: _add_to_map_array(p5_menu.get_pos())
		6: _add_to_map_array(p6_menu.get_pos())
		7: _add_to_map_array(p7_menu.get_pos())
		8: _add_to_map_array(p8_menu.get_pos())

func _unvote(_player):
	match _player:
		1: _remove_from_map_array(p1_menu.get_pos())
		2: _remove_from_map_array(p2_menu.get_pos())
		3: _remove_from_map_array(p3_menu.get_pos())
		4: _remove_from_map_array(p4_menu.get_pos())
		5: _remove_from_map_array(p5_menu.get_pos())
		6: _remove_from_map_array(p6_menu.get_pos())
		7: _remove_from_map_array(p7_menu.get_pos())
		8: _remove_from_map_array(p8_menu.get_pos())

func _add_to_map_array(_num):
	map_array.append(_get_map(maps_pics.return_map_from_spot(_num)))

func _remove_from_map_array(_num):
	map_array.erase(_get_map(_num))

func _get_map(_num):
	match _num:
		1: return map_01
		2: return map_02
		3: return map_03
		4: return map_04
		5: return map_05
		6: return map_06
		7: return map_07
		8: return map_08
		9: return map_09
		10: return map_10
		11: return map_11
		12: return map_12
		13: return map_13
		14: return map_14
		15: return map_15
		16: return map_16
		17: return map_17
		18: return map_18
		19: return map_19
		20: return map_20
		21: return map_21
		22: return map_22
		23: return map_23
		24: return map_24
		25: return map_25
		26: return map_26
		27: return map_27
		28: return map_28
		29: return map_29
		30: return map_30
		31: return map_31
		32: return map_32
		33: return map_33
		34: return map_34
		35: return map_35
		36: return map_36
		37: return map_37
		38: return map_38
		39: return map_39
		40: return map_40

func _set_ready(_player):
	match _player:
		1: p1_ready = true
		2: p2_ready = true
		3: p3_ready = true
		4: p4_ready = true 
		5: p5_ready = true
		6: p6_ready = true
		7: p7_ready = true
		8: p8_ready = true
	_vote(_player)

func _back(_player):
	HUD.set_pri(_player,4)
	SFX.menu(4)
	match _player:
		1: p1_ready = false
		2: p2_ready = false
		3: p3_ready = false
		4: p4_ready = false 
		5: p5_ready = false
		6: p6_ready = false
		7: p7_ready = false
		8: p8_ready = false
	_unvote(_player)

func _get_ready_num():
	var _ready_num = (int(p1_ready) + int(p2_ready) + int(p3_ready) + int(p4_ready) + int(p5_ready) + int(p6_ready) + int(p7_ready) + int(p8_ready))
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

func get_ready(_player):
	match _player:
		1:return p1_ready 
		2:return p2_ready 
		3:return p3_ready 
		4:return p4_ready 
		5:return p5_ready 
		6:return p6_ready 
		7:return p7_ready 
		8:return p8_ready 

func get_menu(_player):
	match _player:
		1:return p1_menu 
		2:return p2_menu 
		3:return p3_menu 
		4:return p4_menu 
		5:return p5_menu 
		6:return p6_menu 
		7:return p7_menu 
		8:return p8_menu 
