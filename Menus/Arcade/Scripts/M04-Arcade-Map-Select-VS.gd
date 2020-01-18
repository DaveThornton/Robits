extends Node2D

#export(PackedScene) var game
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

onready var p1_menu = $Menu_8x4_01
onready var p2_menu = $Menu_8x4_02
onready var p3_menu = $Menu_8x4_03
onready var p4_menu = $Menu_8x4_04
onready var p5_menu = $Menu_8x4_05
onready var p6_menu = $Menu_8x4_06
onready var p7_menu = $Menu_8x4_07
onready var p8_menu = $Menu_8x4_08

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
	var test3 = Menu_Hand.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade map select VS connect input to screen")
	HUD.in_play_to_select()
	menu_check()

func _vote(_player,_map_num):
	_add_to_map_array(_map_num)

func _start():
	if _get_ready_num() == Player_Stats.get_num_in_play():
		_next_screen()

func _next_screen():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var map_num_to_load = rng.randi_range(0,(map_array.size() - 1))
	print(map_num_to_load)
#	map_num_to_load -= 1
	var _map_to_load = map_array[map_num_to_load]
	print("map stuff  ", map_num_to_load,"  ", _map_to_load,"  ", map_array,"  " ,map_array.size())
	Map_Hand.load_map(_map_to_load)
	HUD.in_game()
	call_deferred("free")

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
				elif _dir == 5:
					p1_ready = true
					HUD.player_ready(_player)
					_vote(_player, p1_menu.get_pos())
					_start()
			elif _dir == 6:
				p1_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p1["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 2:
		if Player_Stats.p2["in_play"]:
			if !p2_ready:
				if _dir ==1:
					p2_menu.move_up()
				elif _dir ==2:
					p2_menu.move_left()
				elif _dir ==3:
					p2_menu.move_right()
				elif _dir ==4:
					p2_menu.move_down()
				elif _dir ==5:
					p2_ready = true
					HUD.player_ready(_player)
					_vote(_player, p2_menu.get_pos())
					_start()
			elif _dir == 6:
				p2_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p2["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 3:
		if Player_Stats.p3["in_play"]:
			if !p3_ready:
				if _dir ==1:
					p3_menu.move_up()
				elif _dir ==2:
					p3_menu.move_left()
				elif _dir ==3:
					p3_menu.move_right()
				elif _dir ==4:
					p3_menu.move_down()
				elif _dir ==5:
					p3_ready = true
					HUD.player_ready(_player)
					_vote(_player, p3_menu.get_pos())
					_start()
			elif _dir == 6:
				p3_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p3["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 4:
		if Player_Stats.p4["in_play"]:
			if !p4_ready:
				if _dir ==1:
					p4_menu.move_up()
				elif _dir ==2:
					p4_menu.move_left()
				elif _dir ==3:
					p4_menu.move_right()
				elif _dir ==4:
					p4_menu.move_down()
				elif _dir ==5:
					p4_ready = true
					HUD.player_ready(_player)
					_vote(_player, p4_menu.get_pos())
					_start()
			elif _dir == 6:
				p4_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p4["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 5:
		if Player_Stats.p5["in_play"]:
			if !p5_ready:
				if _dir ==1:
					p5_menu.move_up()
				elif _dir ==2:
					p5_menu.move_left()
				elif _dir ==3:
					p5_menu.move_right()
				elif _dir ==4:
					p5_menu.move_down()
				elif _dir ==5:
					p5_ready = true
					HUD.player_ready(_player)
					_vote(_player, p5_menu.get_pos())
					_start()
			elif _dir == 6:
				p5_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p5["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 6:
		if Player_Stats.p6["in_play"]:
			if !p6_ready:
				if _dir ==1:
					p6_menu.move_up()
				elif _dir ==2:
					p6_menu.move_left()
				elif _dir ==3:
					p6_menu.move_right()
				elif _dir ==4:
					p6_menu.move_down()
				elif _dir ==5:
					p6_ready = true
					HUD.player_ready(_player)
					_vote(_player, p6_menu.get_pos())
					_start()
			elif _dir == 6:
				p6_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p6["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 7:
		if Player_Stats.p7["in_play"]:
			if !p7_ready:
				if _dir ==1:
					p7_menu.move_up()
				elif _dir ==2:
					p7_menu.move_left()
				elif _dir ==3:
					p7_menu.move_right()
				elif _dir ==4:
					p7_menu.move_down()
				elif _dir ==5:
					p7_ready = true
					HUD.player_ready(_player)
					_vote(_player, p7_menu.get_pos())
					_start()
			elif _dir == 6:
				p7_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p7["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	elif _player == 8:
		if Player_Stats.p8["in_play"]:
			if !p8_ready:
				if _dir ==1:
					p8_menu.move_up()
				elif _dir ==2:
					p8_menu.move_left()
				elif _dir ==3:
					p8_menu.move_right()
				elif _dir ==4:
					p8_menu.move_down()
				elif _dir ==5:
					p8_ready = true
					HUD.player_ready(_player)
					_vote(_player, p8_menu.get_pos())
					_start()
			elif _dir == 6:
				p8_ready = false
				HUD.player_select(_player)
		elif Player_Stats.p8["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	else:
		print("error invald player in arcade map select VS")

func _add_to_map_array(_num):
	if _num == 1:
		map_array.append(map_01)
	elif _num == 2:
		map_array.append(map_02)
	elif _num == 3:
		map_array.append(map_03)
	elif _num == 4:
		map_array.append(map_04)
	elif _num == 5:
		map_array.append(map_05)
	elif _num == 6:
		map_array.append(map_06)
	elif _num == 7:
		map_array.append(map_07)
	elif _num == 8:
		map_array.append(map_08)
	elif _num == 9:
		map_array.append(map_09)
	elif _num == 10:
		map_array.append(map_10)
	elif _num == 11:
		map_array.append(map_11)
	elif _num == 12:
		map_array.append(map_12)
	elif _num == 13:
		map_array.append(map_13)
	elif _num == 14:
		map_array.append(map_14)
	elif _num == 15:
		map_array.append(map_15)
	elif _num == 16:
		map_array.append(map)
	pass

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
