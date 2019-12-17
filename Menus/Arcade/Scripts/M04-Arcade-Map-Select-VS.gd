extends Node2D

export(PackedScene) var game
export(PackedScene) var map

onready var p1_menu = $Menu_8x4_01
onready var p2_menu = $Menu_8x4_02
onready var p3_menu = $Menu_8x4_03
onready var p4_menu = $Menu_8x4_04
onready var p5_menu = $Menu_8x4_05
onready var p6_menu = $Menu_8x4_06
onready var p7_menu = $Menu_8x4_07
onready var p8_menu = $Menu_8x4_08

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
	Map_Hand.load_map(map)
	HUD.in_game()
	call_deferred("free")
#	pass

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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p1["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p2["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p3["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p4["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p5["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p6["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p7["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
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
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p8["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				menu_check()
				HUD.player_select(_player)
	else:
		print("error invald player in arcade map select VS")