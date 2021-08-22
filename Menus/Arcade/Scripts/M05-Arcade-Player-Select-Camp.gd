extends Node2D

export(PackedScene) var camp_map

onready var p1_menu = $Menu_8x2_01
onready var p2_menu = $Menu_8x2_02
onready var p3_menu = $Menu_8x2_03
onready var p4_menu = $Menu_8x2_04
onready var p5_menu = $Menu_8x2_05
onready var p6_menu = $Menu_8x2_06
onready var p7_menu = $Menu_8x2_07
onready var p8_menu = $Menu_8x2_08

onready var p1_preview = $Preview_Pics/Robit_Preview_01
onready var p2_preview = $Preview_Pics/Robit_Preview_02
onready var p3_preview = $Preview_Pics/Robit_Preview_03
onready var p4_preview = $Preview_Pics/Robit_Preview_04
onready var p5_preview = $Preview_Pics/Robit_Preview_05
onready var p6_preview = $Preview_Pics/Robit_Preview_06
onready var p7_preview = $Preview_Pics/Robit_Preview_07
onready var p8_preview = $Preview_Pics/Robit_Preview_08

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false

func _init():
	HUD.menu_state()

func _ready():
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print("error M03 Arcade player select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade player select VS connect input to screen")
	HUD.menu_state()
	menu_check()
	_set_preview(1)
	_set_preview(2)
	_set_preview(3)
	_set_preview(4)
	_set_preview(5)
	_set_preview(6)
	_set_preview(7)
	_set_preview(8)

func _start(_player):
	HUD.set_pri(_player,5)
	_set_ready(_player)
	SFX.menu(2)
	if _get_ready_num() == Player_Stats.get_num_in_play():
		_next_screen()

func _next_screen():
	if Player_Stats.p1["in_play"]:
		Player_Stats.p1["pawn_num"] = p1_menu.pos
	if Player_Stats.p2["in_play"]:
		Player_Stats.p2["pawn_num"] = p2_menu.pos
	if Player_Stats.p3["in_play"]:
		Player_Stats.p3["pawn_num"] = p3_menu.pos
	if Player_Stats.p4["in_play"]:
		Player_Stats.p4["pawn_num"] = p4_menu.pos
	if Player_Stats.p5["in_play"]:
		Player_Stats.p5["pawn_num"] = p5_menu.pos
	if Player_Stats.p6["in_play"]:
		Player_Stats.p6["pawn_num"] = p6_menu.pos
	if Player_Stats.p7["in_play"]:
		Player_Stats.p7["pawn_num"] = p7_menu.pos
	if Player_Stats.p8["in_play"]:
		Player_Stats.p8["pawn_num"] = p8_menu.pos
#	Map_Hand.load_map(camp_map)
	Map_Hand.load_map_cam_first(camp_map,"in a world","jail break",1,true)
#	load_map_cam(_level, _label_1, _label_2, _time, _show)
#	Game.started = true
	HUD.mode = 2
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
				elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
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
	_set_preview(_player)

func _set_preview(_player):
	if _player == 1:
		p1_preview.set_pic(p1_menu.pos)
	elif _player == 2:
		p2_preview.set_pic(p2_menu.pos)
	elif _player == 3:
		p3_preview.set_pic(p3_menu.pos)
	elif _player == 4:
		p4_preview.set_pic(p4_menu.pos)
	elif _player == 5:
		p5_preview.set_pic(p5_menu.pos)
	elif _player == 6:
		p6_preview.set_pic(p6_menu.pos)
	elif _player == 7:
		p7_preview.set_pic(p7_menu.pos)
	elif _player == 8:
		p8_preview.set_pic(p8_menu.pos)

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
		p1_preview.visible = true
	if Player_Stats.p2["in_play"]:
		p2_menu.visible = true
		p2_preview.visible = true
	if Player_Stats.p3["in_play"]:
		p3_menu.visible = true
		p3_preview.visible = true
	if Player_Stats.p4["in_play"]:
		p4_menu.visible = true
		p4_preview.visible = true
	if Player_Stats.p5["in_play"]:
		p5_menu.visible = true
		p5_preview.visible = true
	if Player_Stats.p6["in_play"]:
		p6_menu.visible = true
		p6_preview.visible = true
	if Player_Stats.p7["in_play"]:
		p7_menu.visible = true
		p7_preview.visible = true
	if Player_Stats.p8["in_play"]:
		p8_menu.visible = true
		p8_preview.visible = true
