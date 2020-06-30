extends Node2D

export(PackedScene) var campaign
export(PackedScene) var vs_mode

onready var menu = $menu_1X3_01

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false

var menu_pos = 2

func _ready():
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade game select connect input to screen")
	HUD.menu_state()

func _start(_player):
	if menu_pos == 1:
		SFX.play("Menu_Select_02")
		HUD.load_screen(campaign)
		call_deferred("free")
	elif menu_pos == 2:
		SFX.play("Menu_Error_02")
	elif menu_pos == 3:
		SFX.play("Menu_Select_02")
		HUD.load_screen(vs_mode)
		call_deferred("free")

func movement(_player, _dir):
	if _player == 1:
		if Player_Stats.p1["in_play"]:
			if _dir == 1:
				menu.move_up()
			elif _dir == 2:
				menu.move_left()
			elif _dir == 3:
				menu.move_right()
			elif _dir == 4:
				menu.move_down()
			elif _dir == 5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p1["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p2["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p3["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p4["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p5["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p6["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p7["credit"] >= 1:
			if _dir == 0:
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
			elif _dir ==5 || 6 || 7 || 8:
				menu_pos = menu.pos
				_start(_player)
		elif Player_Stats.p8["credit"] >= 1:
			if _dir == 0:
				Player_Stats.use_credit(_player)
				HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	else:
		print("error invald player in arcade mode select")
