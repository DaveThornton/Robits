extends Node2D

export(PackedScene) var vs_map_select

onready var p1_menu = $Menu_8x2_01
onready var p2_menu = $Menu_8x2_02
onready var p3_menu = $Menu_8x2_03
onready var p4_menu = $Menu_8x2_04
onready var p5_menu = $Menu_8x2_05
onready var p6_menu = $Menu_8x2_06
onready var p7_menu = $Menu_8x2_07
onready var p8_menu = $Menu_8x2_08

var ready_count = 0

func _ready():
	var test3 = Menu_Hand.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade player select VS connect input to screen")
	HUD.in_play_to_select()
	menu_check()

func _start():
	ready_count += 1
	if ready_count >= Player_Stats.get_num_in_play():
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

	Menu_Hand.load_screen(vs_map_select)
	self.call_deferred("free")

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
			if _dir ==1:
				p1_menu.move_up()
			elif _dir ==2:
				p1_menu.move_left()
			elif _dir ==3:
				p1_menu.move_right()
			elif _dir ==4:
				p1_menu.move_down()
			elif _dir ==5:
				print("Ready!!!! player select vs menu p1")
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p1["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p1["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 2:
		if Player_Stats.p2["in_play"]:
			if _dir ==1:
				p2_menu.move_up()
			elif _dir ==2:
				p2_menu.move_left()
			elif _dir ==3:
				p2_menu.move_right()
			elif _dir ==4:
				p2_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p2["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p2["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 3:
		if Player_Stats.p3["in_play"]:
			if _dir ==1:
				p3_menu.move_up()
			elif _dir ==2:
				p3_menu.move_left()
			elif _dir ==3:
				p3_menu.move_right()
			elif _dir ==4:
				p3_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p3["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p3["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 4:
		if Player_Stats.p4["in_play"]:
			if _dir ==1:
				p4_menu.move_up()
			elif _dir ==2:
				p4_menu.move_left()
			elif _dir ==3:
				p4_menu.move_right()
			elif _dir ==4:
				p4_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p4["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p4["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 5:
		if Player_Stats.p5["in_play"]:
			if _dir ==1:
				p5_menu.move_up()
			elif _dir ==2:
				p5_menu.move_left()
			elif _dir ==3:
				p5_menu.move_right()
			elif _dir ==4:
				p5_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p5["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p5["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 6:
		if Player_Stats.p6["in_play"]:
			if _dir ==1:
				p6_menu.move_up()
			elif _dir ==2:
				p6_menu.move_left()
			elif _dir ==3:
				p6_menu.move_right()
			elif _dir ==4:
				p6_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p6["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p6["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 7:
		if Player_Stats.p7["in_play"]:
			if _dir ==1:
				p7_menu.move_up()
			elif _dir ==2:
				p7_menu.move_left()
			elif _dir ==3:
				p7_menu.move_right()
			elif _dir ==4:
				p7_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p7["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p7["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	elif _player == 8:
		if Player_Stats.p8["in_play"]:
			if _dir ==1:
				p8_menu.move_up()
			elif _dir ==2:
				p8_menu.move_left()
			elif _dir ==3:
				p8_menu.move_right()
			elif _dir ==4:
				p8_menu.move_down()
			elif _dir ==5:
#				if can_start:
#				menu_pos = menu.pos
#				started_num += 1
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p8["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p8["in_play"] = true
				menu_check()
				HUD.player_select(_player)
				emit_signal("use_credit",_player)
	else:
		print("error invald player in arcade start")
