extends HBoxContainer

onready var p1 = $VBox_Player_01
onready var p2 = $VBox_Player_02
onready var p3 = $VBox_Player_03
onready var p4 = $VBox_Player_04
onready var p5 = $VBox_Player_05
onready var p6 = $VBox_Player_06
onready var p7 = $VBox_Player_07
onready var p8 = $VBox_Player_08

var p1state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p2state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p3state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p4state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p5state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p6state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p7state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var p8state = {
	mode = 1,
	pri = 2,
	sec = 0
}
var mode = 1
var splash_screen = "res://Menus/Parts/M10-Splash.tscn"
var screen_loaded

signal input_to_screen #movement up:1 left:2 right:3 down:4 start:5 back:6
signal screen_update

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error Singleton HUD connecting to reset from world gd")
	reset()

func state_machine():
	if Game.started && !Game.over:
		mode = 2
		game_state()
	elif !Game.started && !Game.over:
		mode = 1
		menu_state()
	elif Game.started && Game.over:
		if Game.mode > 0:
			print("game mode is set to not 0 in hud")
			mode = 0
		elif Game.mode == 0:
			print("game mode is set to 0 in hud")
			mode = 3
		game_over_state()
	else:
		print("error in state machine hud values not met")
		print("game started = ", Game.started)
		print("game over = ", Game.over)

func start():
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	p1state["mode"] = 1
	p1state["sec"] = 0
	if Player_Stats.can_player_start(1): p1state["pri"] = 3
	else: p1state["pri"] = 2
	if Player_Stats.can_player_start(2): p2state["pri"] = 3
	else: p2state["pri"] = 2
	if Player_Stats.can_player_start(3): p3state["pri"] = 3
	else: p3state["pri"] = 2
	if Player_Stats.can_player_start(4): p4state["pri"] = 3
	else: p4state["pri"] = 2
	if Player_Stats.can_player_start(5): p5state["pri"] = 3
	else: p5state["pri"] = 2
	if Player_Stats.can_player_start(6): p6state["pri"] = 3
	else: p6state["pri"] = 2
	if Player_Stats.can_player_start(7): p7state["pri"] = 3
	else: p7state["pri"] = 2
	if Player_Stats.can_player_start(8): p8state["pri"] = 3
	else: p8state["pri"] = 2
	p1.update_state(p1state)
	p2.update_state(p2state)
	p3.update_state(p3state)
	p4.update_state(p4state)
	p5.update_state(p5state)
	p6.update_state(p6state)
	p7.update_state(p7state)
	p8.update_state(p8state)

func update_player(_player):
	if _player == 1:
		p1.update_state(p1state)
	elif _player == 2:
		p2.update_state(p2state)
	elif _player == 3:
		p3.update_state(p3state)
	elif _player == 4:
		p4.update_state(p4state)
	elif _player == 5:
		p5.update_state(p5state)
	elif _player == 6:
		p6.update_state(p6state)
	elif _player == 7:
		p7.update_state(p7state)
	elif _player == 8:
		p8.update_state(p8state)

func update_players():
	p1.update_state(p1state)
	p2.update_state(p2state)
	p3.update_state(p3state)
	p4.update_state(p4state)
	p5.update_state(p5state)
	p6.update_state(p6state)
	p7.update_state(p7state)
	p8.update_state(p8state)

func set_mode(_mode): mode = _mode

func set_pri(_player, _pri):
	if _player == 1:
		p1state["pri"] = _pri
	elif _player == 2:
		p2state["pri"] = _pri
	elif _player == 3:
		p3state["pri"] = _pri
	elif _player == 4:
		p4state["pri"] = _pri
	elif _player == 5:
		p5state["pri"] = _pri
	elif _player == 6:
		p6state["pri"] = _pri
	elif _player == 7:
		p7state["pri"] = _pri
	elif _player == 8:
		p8state["pri"] = _pri
	update_player(_player)

func game_over_state():
	if mode == 0 && Game.mode > 0:
		p1state["pri"] = 11
		p2state["pri"] = 11
		p3state["pri"] = 11
		p4state["pri"] = 11
		p5state["pri"] = 11
		p6state["pri"] = 11
		p7state["pri"] = 11
		p8state["pri"] = 11
		update_players()
	elif mode == 3 && Game.mode == 0:
		print("gameover state mode")
		update_players()
		

func menu_state():
	if mode == 1:
		if !Player_Stats.get_in_play(1) && Player_Stats.can_player_start(1):
			p1state["pri"] = 3
		elif Player_Stats.get_in_play(1) && screen_loaded.p1_ready:
			p1state["pri"] = 5
		elif Player_Stats.get_in_play(1) && !screen_loaded.p1_ready:
			p1state["pri"] = 4
		else:
			p1state["pri"] = 2
		
		if !Player_Stats.get_in_play(2) && Player_Stats.can_player_start(2):
			p2state["pri"] = 3
		elif Player_Stats.get_in_play(2) && screen_loaded.p2_ready:
			p2state["pri"] = 5
		elif Player_Stats.get_in_play(2) && !screen_loaded.p2_ready:
			p2state["pri"] = 4
		else:
			p2state["pri"] = 2
	
		if !Player_Stats.get_in_play(3) && Player_Stats.can_player_start(3):
			p3state["pri"] = 3
		elif Player_Stats.get_in_play(3) && screen_loaded.p3_ready:
			p3state["pri"] = 5
		elif Player_Stats.get_in_play(3) && !screen_loaded.p3_ready:
			p3state["pri"] = 4
		else:
			p3state["pri"] = 2
		
		if !Player_Stats.get_in_play(4) && Player_Stats.can_player_start(4):
			p4state["pri"] = 3
		elif Player_Stats.get_in_play(4) && screen_loaded.p4_ready:
			p4state["pri"] = 5
		elif Player_Stats.get_in_play(4) && !screen_loaded.p4_ready:
			p4state["pri"] = 4
		else:
			p4state["pri"] = 2
	
		if !Player_Stats.get_in_play(5) && Player_Stats.can_player_start(5):
			p5state["pri"] = 3
		elif Player_Stats.get_in_play(5) && screen_loaded.p5_ready:
			p5state["pri"] = 5
		elif Player_Stats.get_in_play(5) && !screen_loaded.p5_ready:
			p5state["pri"] = 4
		else:
			p5state["pri"] = 2
		
		if !Player_Stats.get_in_play(6) && Player_Stats.can_player_start(6):
			p6state["pri"] = 3
		elif Player_Stats.get_in_play(6) && screen_loaded.p6_ready:
			p6state["pri"] = 5
		elif Player_Stats.get_in_play(6) && !screen_loaded.p6_ready:
			p6state["pri"] = 4
		else:
			p6state["pri"] = 2
	
		if !Player_Stats.get_in_play(7) && Player_Stats.can_player_start(7):
			p7state["pri"] = 3
		elif Player_Stats.get_in_play(7) && screen_loaded.p7_ready:
			p7state["pri"] = 5
		elif Player_Stats.get_in_play(7) && !screen_loaded.p7_ready:
			p7state["pri"] = 4
		else:
			p7state["pri"] = 2
		
		if !Player_Stats.get_in_play(8) && Player_Stats.can_player_start(8):
			p8state["pri"] = 3
		elif Player_Stats.get_in_play(8) && screen_loaded.p8_ready:
			p8state["pri"] = 5
		elif Player_Stats.get_in_play(8) && !screen_loaded.p8_ready:
			p8state["pri"] = 4
		else:
			p8state["pri"] = 2
	update_players()

func game_state():
	if mode == 2:
		if Player_Stats.p1["in_game"]:
			set_pri(1,10)
		elif Player_Stats.get_in_play(1) && !Player_Stats.p1["in_game"]:
			set_pri(1, 9)
		elif !Player_Stats.get_in_play(1) && !Player_Stats.p1["in_game"] && Player_Stats.can_player_start(1):
			set_pri(1, 3)
		elif !Player_Stats.get_in_play(1) && !Player_Stats.can_player_start(1):
			set_pri(1, 2)
	
		if Player_Stats.p2["in_game"]:
			set_pri(2,10)
		elif Player_Stats.get_in_play(2) && !Player_Stats.p2["in_game"]:
			set_pri(2, 9)
		elif !Player_Stats.get_in_play(2) && !Player_Stats.p2["in_game"] && Player_Stats.can_player_start(2):
			set_pri(2, 3)
		elif !Player_Stats.get_in_play(2) && !Player_Stats.can_player_start(2):
			set_pri(2, 2)
	
		if Player_Stats.p3["in_game"]:
			set_pri(3,10)
		elif Player_Stats.get_in_play(3) && !Player_Stats.p3["in_game"]:
			set_pri(3, 9)
		elif !Player_Stats.get_in_play(3) && !Player_Stats.p3["in_game"] && Player_Stats.can_player_start(3):
			set_pri(3, 3)
		elif !Player_Stats.get_in_play(3) && !Player_Stats.can_player_start(3):
			set_pri(3, 2)
	
		if Player_Stats.p4["in_game"]:
			set_pri(4,10)
		elif Player_Stats.get_in_play(4) && !Player_Stats.p4["in_game"]:
			set_pri(4, 9)
		elif !Player_Stats.get_in_play(4) && !Player_Stats.p4["in_game"] && Player_Stats.can_player_start(4):
			set_pri(4, 3)
		elif !Player_Stats.get_in_play(4) && !Player_Stats.can_player_start(4):
			set_pri(4, 2)
	
		if Player_Stats.p5["in_game"]:
			set_pri(5,10)
		elif Player_Stats.get_in_play(5) && !Player_Stats.p5["in_game"]:
			set_pri(5, 9)
		elif !Player_Stats.get_in_play(5) && !Player_Stats.p5["in_game"] && Player_Stats.can_player_start(5):
			set_pri(5, 3)
		elif !Player_Stats.get_in_play(5) && !Player_Stats.can_player_start(5):
			set_pri(5, 2)
	
		if Player_Stats.p6["in_game"]:
			set_pri(6,10)
		elif Player_Stats.get_in_play(6) && !Player_Stats.p6["in_game"]:
			set_pri(6, 9)
		elif !Player_Stats.get_in_play(6) && !Player_Stats.p6["in_game"] && Player_Stats.can_player_start(6):
			set_pri(6, 3)
		elif !Player_Stats.get_in_play(6) && !Player_Stats.can_player_start(6):
			set_pri(6, 2)
	
		if Player_Stats.p7["in_game"]:
			set_pri(7,10)
		elif Player_Stats.get_in_play(7) && !Player_Stats.p7["in_game"]:
			set_pri(7, 9)
		elif !Player_Stats.get_in_play(7) && !Player_Stats.p7["in_game"] && Player_Stats.can_player_start(7):
			set_pri(7, 3)
		elif !Player_Stats.get_in_play(7) && !Player_Stats.can_player_start(7):
			set_pri(7, 2)
	
		if Player_Stats.p8["in_game"]:
			set_pri(8,10)
		elif Player_Stats.get_in_play(8) && !Player_Stats.p8["in_game"]:
			set_pri(8, 9)
		elif !Player_Stats.get_in_play(8) && !Player_Stats.p8["in_game"] && Player_Stats.can_player_start(8):
			set_pri(8, 3)
		elif !Player_Stats.get_in_play(8) && !Player_Stats.can_player_start(8):
			set_pri(8, 2)

func in_game_player(_player):
	if _player == 1:
		if Player_Stats.p1["pawn_num"] == -1:
			p1.not_in_play()
		elif Player_Stats.p1["pawn_num"] > -1:
			p1.in_play()
	elif _player == 2:
		if Player_Stats.p2["pawn_num"] == -1:
			p2.not_in_play()
		elif Player_Stats.p2["pawn_num"] > -1:
			p2.in_play()
	elif _player == 3:
		if Player_Stats.p3["pawn_num"] == -1:
			p3.not_in_play()
		elif Player_Stats.p3["pawn_num"] > -1:
			p3.in_play()
	elif _player == 4:
		if Player_Stats.p4["pawn_num"] == -1:
			p4.not_in_play()
		elif Player_Stats.p4["pawn_num"] > -1:
			p4.in_play()
	elif _player == 5:
		if Player_Stats.p5["pawn_num"] == -1:
			p5.not_in_play()
		elif Player_Stats.p5["pawn_num"] > -1:
			p5.in_play()
	elif _player == 6:
		if Player_Stats.p6["pawn_num"] == -1:
			p6.not_in_play()
		elif Player_Stats.p6["pawn_num"] > -1:
			p6.in_play()
	elif _player == 7:
		if Player_Stats.p7["pawn_num"] == -1:
			p7.not_in_play()
		elif Player_Stats.p7["pawn_num"] > -1:
			p7.in_play()
	elif _player == 8:
		if Player_Stats.p8["pawn_num"] == -1:
			p8.not_in_play()
		elif Player_Stats.p8["pawn_num"] > -1:
			p8.in_play()

func check_in_game(_num):
	if _num == 1:
		if Player_Stats.p1["in_play"]: p1.in_play()
		else: p1.in_game()
	elif _num == 2:
		if Player_Stats.p2["in_play"]: p2.in_play()
		else: p2.in_game()
	elif _num == 3:
		if Player_Stats.p3["in_play"]: p3.in_play()
		else: p3.in_game()
	elif _num == 4:
		if Player_Stats.p4["in_play"]: p4.in_play()
		else: p4.in_game()
	elif _num == 5:
		if Player_Stats.p5["in_play"]: p5.in_play()
		else: p5.in_game()
	elif _num == 6:
		if Player_Stats.p6["in_play"]: p6.in_play()
		else: p6.in_game()
	elif _num == 7:
		if Player_Stats.p7["in_play"]: p7.in_play()
		else: p7.in_game()
	elif _num == 8:
		if Player_Stats.p8["in_play"]: p8.in_play()
		else: p8.in_game()

func set_score(_player):
	if _player == 1: p1.set_score_count(Player_Stats.p1["score"])
	elif _player == 2: p2.set_score_count(Player_Stats.p2["score"])
	elif _player == 3: p3.set_score_count(Player_Stats.p3["score"])
	elif _player == 4: p4.set_score_count(Player_Stats.p4["score"])
	elif _player == 5: p5.set_score_count(Player_Stats.p5["score"])
	elif _player == 6: p6.set_score_count(Player_Stats.p6["score"])
	elif _player == 7: p7.set_score_count(Player_Stats.p7["score"])
	elif _player == 8: p8.set_score_count(Player_Stats.p8["score"])
	else: print("error in set score player number not valid. player : ",_player)

func set_nrg(_player, _amount):
	if _player == 1: p1.set_nrg_bar(_amount)
	elif _player == 2: p2.set_nrg_bar(_amount)
	elif _player == 3: p3.set_nrg_bar(_amount)
	elif _player == 4: p4.set_nrg_bar(_amount)
	elif _player == 5: p5.set_nrg_bar(_amount)
	elif _player == 6: p6.set_nrg_bar(_amount)
	elif _player == 7: p7.set_nrg_bar(_amount)
	elif _player == 8: p8.set_nrg_bar(_amount)
	else: print("error in nrg_update player number not valid. player : ",_player, ". amount :", _amount)

func set_lives(_player, _amount):
	if _player == 1: p1.set_lives(_amount)
	elif _player == 2: p2.set_lives(_amount)
	elif _player == 3: p3.set_lives(_amount)
	elif _player == 4: p4.set_lives(_amount)
	elif _player == 5: p5.set_lives(_amount)
	elif _player == 6: p6.set_lives(_amount)
	elif _player == 7: p7.set_lives(_amount)
	elif _player == 8: p8.set_lives(_amount)
	else: print("error in set_lives player number not valid. player : ",_player, ". amount :", _amount)

func set_ammo(_player, _amount):
	if _player == 1: p1.set_ammo_count(_amount)
	elif _player == 2: p2.set_ammo_count(_amount)
	elif _player == 3: p3.set_ammo_count(_amount)
	elif _player == 4: p4.set_ammo_count(_amount)
	elif _player == 5: p5.set_ammo_count(_amount)
	elif _player == 6: p6.set_ammo_count(_amount)
	elif _player == 7: p7.set_ammo_count(_amount)
	elif _player == 8: p8.set_ammo_count(_amount)
	else: print("error in set_ammo player number not valid. player : ",_player, ". amount :", _amount)

func set_places():
	var _places = Player_Stats.get_places()
	var _set_back = 1
	var last_y = null
	var last_place_y = _places.back().y
	for p in _places.size():
		var o = p
		if _places[p].y == last_place_y:
			if _places[p].x == 1:
				p1.set_place(8)
			elif _places[p].x == 2:
				p2.set_place(8)
			elif _places[p].x == 3:
				p3.set_place(8)
			elif _places[p].x == 4:
				p4.set_place(8)
			elif _places[p].x == 5:
				p5.set_place(8)
			elif _places[p].x == 6:
				p6.set_place(8)
			elif _places[p].x == 7:
				p7.set_place(8)
			elif _places[p].x == 8:
				p8.set_place(8)
		else:
			if _places[p].y != last_y:
				last_y = _places[p].y
				_set_back = 0
			else:
				_set_back += 1
			o = p - _set_back
			if _places[p].x == 1:
				p1.set_place(o)
			elif _places[p].x == 2:
				p2.set_place(o)
			elif _places[p].x == 3:
				p3.set_place(o)
			elif _places[p].x == 4:
				p4.set_place(o)
			elif _places[p].x == 5:
				p5.set_place(o)
			elif _places[p].x == 6:
				p6.set_place(o)
			elif _places[p].x == 7:
				p7.set_place(o)
			elif _places[p].x == 8:
				p8.set_place(o)

func show_lives(_show:bool):
	p1.show_lives(_show)
	p2.show_lives(_show)
	p3.show_lives(_show)
	p4.show_lives(_show)
	p5.show_lives(_show)
	p6.show_lives(_show)
	p7.show_lives(_show)
	p8.show_lives(_show)

func game_over():
	print("game over doesnt do much in hud so fun!")
	pass

func game_over_input(_player, _input):
#	print("game over input")
#	print(Game.over,"  ",Game.mode, "  ",_player,"   in gameover input hud")
	if Game.mode < 0:
		if _player == 1:
			if _input == 5:
				p1.game_over_done()
			elif _input ==6:
				p1.game_over_not_done()
		elif _player == 2:
			if _input == 5:
				p2.game_over_done()
			elif _input ==6:
				p2.game_over_not_done()
		elif _player == 3:
			if _input == 5:
				p3.game_over_done()
			elif _input ==6:
				p3.game_over_not_done()
		elif _player == 4:
			if _input == 5:
				p4.game_over_done()
			elif _input ==6:
				p4.game_over_not_done()
		elif _player == 5:
			if _input == 5:
				p5.game_over_done()
			elif _input ==6:
				p5.game_over_not_done()
		elif _player == 6:
			if _input == 5:
				p6.game_over_done()
			elif _input ==6:
				p6.game_over_not_done()
		elif _player == 7:
			if _input == 5:
				p7.game_over_done()
			elif _input ==6:
				p7.game_over_not_done()
		elif _player == 8:
			if _input == 5:
				p8.game_over_done()
			elif _input ==6:
				p8.game_over_not_done()
		else:
			print("error game over input player number not valid. player : ",_player, ". input :", _input)
		var _in_play = Player_Stats.get_num_in_play()
		var _done = get_game_over_done_count()
		if _in_play == _done && Game.mode < 0:
			get_tree().get_current_scene().arcade_reset()
	
	elif Game.mode == 0 && !Player_Stats.get_done(_player):
		if _player == 1:
			if _input == 1:
				p1.go_up()
			elif _input == 4:
				p1.go_down()
			elif _input == 5:
				p1.go_select()
			elif _input == 6:
				p1.go_back()
		elif _player == 2:
			if _input == 1:
				p2.go_up()
			elif _input == 4:
				p2.go_down()
			elif _input == 5:
				p2.go_select()
			elif _input == 6:
				p2.go_back()
		elif _player == 3:
			if _input == 1:
				p3.go_up()
			elif _input == 4:
				p3.go_down()
			elif _input == 5:
				p3.go_select()
			elif _input == 6:
				p3.go_back()
		elif _player == 4:
			if _input == 1:
				p4.go_up()
			elif _input == 4:
				p4.go_down()
			elif _input == 5:
				p4.go_select()
			elif _input == 6:
				p4.go_back()
		elif _player == 5:
			if _input == 1:
				p5.go_up()
			elif _input == 4:
				p5.go_down()
			elif _input == 5:
				p5.go_select()
			elif _input == 6:
				p5.go_back()
		elif _player == 6:
			if _input == 1:
				p6.go_up()
			elif _input == 4:
				p6.go_down()
			elif _input == 5:
				p6.go_select()
			elif _input == 6:
				p6.go_back()
		elif _player == 7:
			if _input == 1:
				p7.go_up()
			elif _input == 4:
				p7.go_down()
			elif _input == 5:
				p7.go_select()
			elif _input == 6:
				p7.go_back()
		elif _player == 8:
			if _input == 1:
				p8.go_up()
			elif _input == 4:
				p8.go_down()
			elif _input == 5:
				p8.go_select()
			elif _input == 6:
				p8.go_back()

func get_game_over_done_count():
	var _done = 0
	if p1.in_game_over_box.game_done: _done += 1
	if p2.in_game_over_box.game_done: _done += 1
	if p3.in_game_over_box.game_done: _done += 1
	if p4.in_game_over_box.game_done: _done += 1
	if p5.in_game_over_box.game_done: _done += 1
	if p6.in_game_over_box.game_done: _done += 1
	if p7.in_game_over_box.game_done: _done += 1
	if p8.in_game_over_box.game_done: _done += 1
	return _done

func coin_up(_player):
	SFX.play("Menu_Coin")
	coin_update(_player)
	
func coin_update(_player):
	if _player == 1:
		p1.set_coin_count(Player_Stats.p1["credit"])
	elif _player == 2:
		p2.set_coin_count(Player_Stats.p2["credit"])
	elif _player == 3:
		p3.set_coin_count(Player_Stats.p3["credit"])
	elif _player == 4:
		p4.set_coin_count(Player_Stats.p4["credit"])
	elif _player == 5:
		p5.set_coin_count(Player_Stats.p5["credit"])
	elif _player == 6:
		p6.set_coin_count(Player_Stats.p6["credit"])
	elif _player == 7:
		p7.set_coin_count(Player_Stats.p7["credit"])
	elif _player == 8:
		p8.set_coin_count(Player_Stats.p8["credit"])
	elif _player == 1:
		p1.set_coin_count(Player_Stats.p1["credit"])
		p2.set_coin_count(Player_Stats.p2["credit"])
		p3.set_coin_count(Player_Stats.p3["credit"])
		p4.set_coin_count(Player_Stats.p4["credit"])
		p5.set_coin_count(Player_Stats.p5["credit"])
		p6.set_coin_count(Player_Stats.p6["credit"])
		p7.set_coin_count(Player_Stats.p7["credit"])
		p8.set_coin_count(Player_Stats.p8["credit"])
	state_machine()

func set_continue(_player, _continue):
	if _player == 1: p1.set_continue(_continue)
	elif _player == 2: p2.set_continue(_continue)
	elif _player == 3: p3.set_continue(_continue)
	elif _player == 4: p4.set_continue(_continue)
	elif _player == 5: p5.set_continue(_continue)
	elif _player == 6: p6.set_continue(_continue)
	elif _player == 7: p7.set_continue(_continue)
	elif _player == 8: p8.set_continue(_continue)
	else: print("error in set score player number not valid. player : ",_player)

func reset():
	start()
#	coin_count()
	p1.reset()
	p2.reset()
	p3.reset()
	p4.reset()
	p5.reset()
	p6.reset()
	p7.reset()
	p8.reset()

func load_screen(_screen_to_load):
	var s = _screen_to_load.instance()
	add_child(s)
	screen_loaded = s
	state_machine()

func splash(_top, _body, _time, _pause):
	var s = load(splash_screen).instance()
	add_child(s)
	s.init(_top, _body, _time, _pause)

func input( _player, _dir):#movement up:1 left:2 right:3 down:4 start:5 back:6
	print(_player, Game.started,"   ",Player_Stats.get_in_play(_player),"   ", Player_Stats.get_in_game(_player),"  ",Player_Stats.get_continuing(_player))
	if !Game.started && !Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player) && !Player_Stats.get_continuing(_player):
		if _dir == 0 && Player_Stats.can_player_start(_player):
			Player_Stats.reset_player(_player)
			Player_Stats.use_credit(_player)
			set_pri(_player,3)
			update_player(_player)
			emit_signal("screen_update")
		elif _dir != 0 && Player_Stats.can_player_start(_player):
			set_pri(_player,3)
		elif !Player_Stats.can_player_start(_player):
			set_pri(_player,2)
		else:
			print("error in input HUD no parameters met 0002")

	elif !Player_Stats.get_continuing(_player) && !Game.started && Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player):
		print("input to screen hud")
		emit_signal("input_to_screen",_player, _dir)

	elif Player_Stats.get_continuing(_player) && !Player_Stats.can_player_start(_player): print("Hud no credit  tring to continue error 0007")

	elif Player_Stats.get_continuing(_player) && Player_Stats.can_player_start(_player):
		print("continuing?")
		if _dir == 0 && Player_Stats.can_player_start(_player):
			set_continue(_player, false)
			Player_Stats.reset_player_not_score(_player)
			Player_Stats.set_in_play(_player,true)
			Player_Stats.use_credit(_player)
			p1.pawn_menu_vis(true)
#		elif _dir != 0 && Player_Stats.can_player_start(_player):
#			set_pri(_player,3)
#		elif !Player_Stats.can_player_start(_player):
#			set_pri(_player,2)
#		else:
#			print("error in input HUD no parameters met 0005")

	elif Game.started && !Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player) && !Player_Stats.get_continuing(_player):
		if _dir == 0 && Player_Stats.can_player_start(_player):
			Player_Stats.set_in_play(_player,true)
			Player_Stats.use_credit(_player)
			p1.pawn_menu_vis(true)
		elif _dir != 0 && Player_Stats.can_player_start(_player):
			set_pri(_player,3)
		elif !Player_Stats.can_player_start(_player):
			set_pri(_player,2)
		else:
			print("error in input HUD no parameters met 0004")

#pawn menu in game
	elif Game.started && Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player)&& !Player_Stats.get_continuing(_player):
		if _player == 1: 
			if _dir == 2:
				p1.go_left()
			elif _dir == 3:
				p1.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p1["pawn_num"] = p1.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p1.spawn_pawn()
				p1.pawn_menu_vis(false)
		elif _player == 2:
			if _dir == 2:
				p2.go_left()
			elif _dir == 3:
				p2.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p2["pawn_num"] = p2.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p2.spawn_pawn()
				p2.pawn_menu_vis(false)
		elif _player == 3:
			if _dir == 2:
				p3.go_left()
			elif _dir == 3:
				p3.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p3["pawn_num"] = p3.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p3.spawn_pawn()
				p3.pawn_menu_vis(false)
		elif _player == 4:
			if _dir == 2:
				p4.go_left()
			elif _dir == 3:
				p4.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p4["pawn_num"] = p4.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p4.spawn_pawn()
				p4.pawn_menu_vis(false)
		elif _player == 5:
			if _dir == 2:
				p5.go_left()
			elif _dir == 3:
				p5.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p5["pawn_num"] = p5.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p5.spawn_pawn()
				p5.pawn_menu_vis(false)
		elif _player == 6:
			if _dir == 2:
				p6.go_left()
			elif _dir == 3:
				p6.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p6["pawn_num"] = p6.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p6.spawn_pawn()
				p6.pawn_menu_vis(false)
		elif _player == 7:
			if _dir == 2:
				p7.go_left()
			elif _dir == 3:
				p7.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p7["pawn_num"] = p7.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p7.spawn_pawn()
				p7.pawn_menu_vis(false)
		elif _player == 8: 
			if _dir == 2:
				p8.go_left()
			elif _dir == 3:
				p8.go_right()
			elif _dir == 0 || _dir == 6:
				Player_Stats.p8["pawn_num"] = p8.go_start()
				Player_Stats.set_in_game(_player,true)
				Controllers.p8.spawn_pawn()
				p8.pawn_menu_vis(false)

	elif Game.started && Player_Stats.get_in_play(_player) && Player_Stats.get_in_game(_player):
		print("error in hud input shouldnt see this you should be playing a game 0003")
	else:
		print("error in hud input no parameters met 0001 --- ","game started = ", Game.started,"in play = ",Player_Stats.get_in_play(_player),"in game = ",Player_Stats.get_in_game(_player))
	state_machine()
