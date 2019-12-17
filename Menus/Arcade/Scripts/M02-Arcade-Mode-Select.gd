extends Node2D

export(PackedScene) var campaign
export(PackedScene) var vs_mode

onready var menu = $menu_1X3_01

var menu_pos = 2

func _ready():
	var test3 = Menu_Hand.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade game select connect input to screen")
	HUD.in_play_to_select()

func _start():
	if menu_pos == 1:
		Menu_Hand.load_screen(campaign)
		call_deferred("free")
	if menu_pos == 2:
		pass
	if menu_pos == 3:
		Menu_Hand.load_screen(vs_mode)
		call_deferred("free")

func movement(_player, _dir):
	if _player == 1:
		if Player_Stats.p1["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p1["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 2:
		if Player_Stats.p2["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p2["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 3:
		if Player_Stats.p3["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p3["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 4:
		if Player_Stats.p4["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p4["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 5:
		if Player_Stats.p5["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p5["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 6:
		if Player_Stats.p6["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p6["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 7:
		if Player_Stats.p7["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p7["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 8:
		if Player_Stats.p8["in_play"]:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
				menu_pos = menu.pos
				HUD.player_ready(_player)
				_start()
		elif Player_Stats.p8["credit"] >= 1:
			if _dir == 5:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	else:
		print("error invald player in arcade mode select")