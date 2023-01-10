extends HBoxContainer

onready var p1 = $VBox_Player_01
onready var p2 = $VBox_Player_02
onready var p3 = $VBox_Player_03
onready var p4 = $VBox_Player_04
onready var p5 = $VBox_Player_05
onready var p6 = $VBox_Player_06
onready var p7 = $VBox_Player_07
onready var p8 = $VBox_Player_08
onready var count = $CanvasLayer/Count_Down_Text

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
var mode = 1 #0 game over vs     1 menu     2 in game      3 gameover campagin
var splash_screen = "res://Menus/Parts/M10-Splash.tscn"
var screen_loaded
var player_in_control = 0

signal input_to_screen #movement up:1 left:2 right:3 down:4 start:5 back:6
signal screen_update

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error Singleton HUD connecting to reset from world gd")
	reset()
	var test2 = count.connect("time_out", self, "time_out")
	if test2 != 0:
		print_debug(test2,"error Singleton HUD connecting to reset from count")

func state_machine():
	if Game.get_started() && !Game.get_game_over():
		mode = 2
		game_state()
	elif !Game.get_started() && !Game.get_game_over():
		mode = 1
		menu_state()
	elif Game.get_started() && Game.get_game_over():
		if Game.get_mode() > 0:
			mode = 0
		elif Game.get_mode() == 0:
			mode = 3
		game_over_state()
	else:
		print_debug("error in state machine hud values not met")
		print_debug("game started = ", Game.get_started())
		print_debug("game over = ", Game.get_game_over())

func start():
	p1state["mode"] = 1
	p1state["sec"] = 0
	p2state["mode"] = 1
	p2state["sec"] = 0
	p3state["mode"] = 1
	p3state["sec"] = 0
	p4state["mode"] = 1
	p4state["sec"] = 0
	p5state["mode"] = 1
	p5state["sec"] = 0
	p6state["mode"] = 1
	p6state["sec"] = 0
	p7state["mode"] = 1
	p7state["sec"] = 0
	p8state["mode"] = 1
	p8state["sec"] = 0
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
	update_players()

func update_player(_player): get_player_hud(_player).update_state(get_player_state(_player))

func update_players():
	for p in Settings.max_num_of_player:
		get_player_hud(p + 1).update_state(get_player_state(p + 1))

func set_mode(_mode):
	mode = _mode
	state_machine()

func set_pri(_player, _pri):
	get_player_state(_player)["pri"] = _pri
	update_player(_player)

func game_over_state():
	if mode == 0 && Game.get_mode() > 0:
		p1state["pri"] = 11
		p2state["pri"] = 11
		p3state["pri"] = 11
		p4state["pri"] = 11
		p5state["pri"] = 11
		p6state["pri"] = 11
		p7state["pri"] = 11
		p8state["pri"] = 11
		update_players()
	elif mode == 3 && Game.get_mode() == 0:
		print_debug("gameover state mode")
		update_players()

func menu_state():
	if mode == 1:
		for p in Settings.get_max_num_players():
			if !Player_Stats.get_in_play(p + 1) && Player_Stats.can_player_start(p + 1):
				get_player_state(p + 1)["pri"] = 3
			elif Player_Stats.get_in_play(p + 1) && screen_loaded.get_ready(p + 1):
				get_player_state(p + 1)["pri"] = 5
			elif Player_Stats.get_in_play(p + 1) && !screen_loaded.get_ready(p + 1):
				get_player_state(p + 1)["pri"] = 4
			else:
				get_player_state(p + 1)["pri"] = 2
	update_players()

func game_state():
	if mode == 2:
		for p in Settings.get_max_num_players():
			if Player_Stats.get_in_game(p + 1):
				set_pri(p + 1, 10)
			elif Player_Stats.get_in_play(p + 1) && !Player_Stats.get_in_game(p + 1):
				set_pri(p + 1, 9)
			elif !Player_Stats.get_in_play(p + 1) && !Player_Stats.get_in_game(p + 1) && Player_Stats.can_player_start(p + 1):
				set_pri(p + 1,3)
			elif !Player_Stats.get_in_play(p + 1) && !Player_Stats.can_player_start(p + 1):
				set_pri(p + 1, 2)

func set_player_in_control(_player):
	player_in_control = _player

func set_score(_player): get_player_hud(_player).set_score_count(Player_Stats.get_score(_player))

func set_nrg(_player, _amount): get_player_hud(_player).set_nrg_bar(_amount)

func set_lives(_player, _amount): get_player_hud(_player).set_lives(_amount)

func set_ammo(_player, _amount): get_player_hud(_player).set_ammo_count(_amount)

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

func game_over(): print_debug("game over doesnt do much in hud so fun!")

func game_over_input(_player, _input):
	print_debug(" game over input " , _player,"   ", _input)
	if Game.get_mode() > 0:
		if _input == 5:
			count.change_count(-1)
		elif _input ==6:
			count.change_count(1)

	elif Game.get_mode() == 0 && !Player_Stats.get_done(_player):
		if _input == 1:
			get_player_hud(_player).go_up()
		elif _input == 4:
			get_player_hud(_player).go_down()
		elif _input == 5:
			get_player_hud(_player).go_select()
		elif _input == 6:
			get_player_hud(_player).go_back()

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
	SFX.menu(0)
	coin_update(_player)
	
func coin_update(_player):
	if _player > 0:
		get_player_hud(_player).set_coin_count(Player_Stats.get_credit(_player))
	else:
		p1.set_coin_count(Player_Stats.p1["credit"])
		p2.set_coin_count(Player_Stats.p2["credit"])
		p3.set_coin_count(Player_Stats.p3["credit"])
		p4.set_coin_count(Player_Stats.p4["credit"])
		p5.set_coin_count(Player_Stats.p5["credit"])
		p6.set_coin_count(Player_Stats.p6["credit"])
		p7.set_coin_count(Player_Stats.p7["credit"])
		p8.set_coin_count(Player_Stats.p8["credit"])
	state_machine()

func set_continue(_player, _continue): get_player_hud(_player).set_continue(_continue)

func reset():
	start()
	p1.reset()
	p2.reset()
	p3.reset()
	p4.reset()
	p5.reset()
	p6.reset()
	p7.reset()
	p8.reset()
	set_player_in_control(0)

func time_out():
	get_tree().get_current_scene().arcade_reset()

func load_screen(_screen_to_load):
	var s = _screen_to_load.instance()
	add_child(s)
	screen_loaded = s
	state_machine()

func splash(_top, _body, _time, _pause):
	var s = load(splash_screen).instance()
	add_child(s)
	s.init(_top, _body, _time, _pause)

func get_player_state(_player):
	if _player == 1:
		return p1state
	elif _player == 2:
		return p2state
	elif _player == 3:
		return p3state
	elif _player == 4:
		return p4state
	elif _player == 5:
		return p5state
	elif _player == 6:
		return p6state
	elif _player == 7:
		return p7state
	elif _player == 8:
		return p8state
	else:
		print_debug("get player state error invaild player in hud")

func get_player_hud(_player):
	if _player == 1:
		return p1
	elif _player == 2:
		return p2
	elif _player == 3:
		return p3
	elif _player == 4:
		return p4
	elif _player == 5:
		return p5
	elif _player == 6:
		return p6
	elif _player == 7:
		return p7
	elif _player == 8:
		return p8
	else:
		print_debug("get player hud error invaild player in hud so I'll return player 1")
		return p1

func start_count():
	count.init()		

func input( _player, _dir):#movement up:1 left:2 right:3 down:4 start:5 back:6
	if !Game.get_started() && !Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player) && !Player_Stats.get_continuing(_player):
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
			print_debug("error in input HUD no parameters met 0002")

	elif !Player_Stats.get_continuing(_player) && !Game.get_started() && Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player):
		print_debug("input to screen hud")
		emit_signal("input_to_screen",_player, _dir)

	elif Player_Stats.get_continuing(_player) && Player_Stats.can_player_start(_player):
		print_debug("continuing? in hud singleton")
		if _dir == 0 && Player_Stats.can_player_start(_player):
			set_continue(_player, false)
			Player_Stats.reset_player_not_score(_player)
			Player_Stats.set_in_play(_player,true)
			Player_Stats.use_credit(_player)
			get_player_hud(_player).pawn_menu_vis(true)

	elif Player_Stats.get_continuing(_player) && !Player_Stats.can_player_start(_player):
		print_debug("not continuing in hud singleton")
		if _dir == 6:
			get_player_hud(_player).add_to_continue(-1)
		elif _dir == 5:
			get_player_hud(_player).add_to_continue(1)
	
	elif Game.get_started() && !Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player) && !Player_Stats.get_done(_player):#movement up:1 left:2 right:3 down:4 start:5 back:6
		print_debug("trying to send up down select signal to hud for in game high score (in hud arcade input)")
		if _dir == 1:
			get_player_hud(_player).go_up()
		elif _dir == 4:
			get_player_hud(_player).go_down()
		elif _dir == 5:
			get_player_hud(_player).go_select()
		elif _dir == 6:
			get_player_hud(_player).go_back()

	elif Game.get_started() && !Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player) && !Player_Stats.get_continuing(_player):
		if _dir == 0 && Player_Stats.can_player_start(_player):
			Player_Stats.set_in_play(_player,true)
			Player_Stats.use_credit(_player)
			var p = get_player_hud(_player)
			p.pawn_menu_vis(true)
		elif _dir != 0 && Player_Stats.can_player_start(_player):
			set_pri(_player,3)
		elif !Player_Stats.can_player_start(_player):
			print_debug("cant start in hud arcade")
			set_pri(_player,2)
		else:
			print_debug("error in input HUD no parameters met 0004")

#pawn menu in game
	elif Game.get_started() && Player_Stats.get_in_play(_player) && !Player_Stats.get_in_game(_player)&& !Player_Stats.get_continuing(_player):
		var p = get_player_hud(_player)
		if _dir == 2:
			p.go_left()
		elif _dir == 3:
			p.go_right()
		elif _dir == 0 || _dir == 6:
			var ps = Player_Stats.get_player_stats(_player)
			ps["pawn_num"] = p.go_start()

			Player_Stats.set_in_game(_player,true)
			var c = Controllers.get_controller(_player)
			c.spawn_pawn()
			p.pawn_menu_vis(false)
	state_machine()







	# 	if _player == 1: 
	# 		if _dir == 2:
	# 			p1.go_left()
	# 		elif _dir == 3:
	# 			p1.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p1["pawn_num"] = p1.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p1.spawn_pawn()
	# 			p1.pawn_menu_vis(false)
	# 	elif _player == 2:
	# 		if _dir == 2:
	# 			p2.go_left()
	# 		elif _dir == 3:
	# 			p2.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p2["pawn_num"] = p2.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p2.spawn_pawn()
	# 			p2.pawn_menu_vis(false)
	# 	elif _player == 3:
	# 		if _dir == 2:
	# 			p3.go_left()
	# 		elif _dir == 3:
	# 			p3.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p3["pawn_num"] = p3.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p3.spawn_pawn()
	# 			p3.pawn_menu_vis(false)
	# 	elif _player == 4:
	# 		if _dir == 2:
	# 			p4.go_left()
	# 		elif _dir == 3:
	# 			p4.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p4["pawn_num"] = p4.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p4.spawn_pawn()
	# 			p4.pawn_menu_vis(false)
	# 	elif _player == 5:
	# 		if _dir == 2:
	# 			p5.go_left()
	# 		elif _dir == 3:
	# 			p5.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p5["pawn_num"] = p5.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p5.spawn_pawn()
	# 			p5.pawn_menu_vis(false)
	# 	elif _player == 6:
	# 		if _dir == 2:
	# 			p6.go_left()
	# 		elif _dir == 3:
	# 			p6.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p6["pawn_num"] = p6.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p6.spawn_pawn()
	# 			p6.pawn_menu_vis(false)
	# 	elif _player == 7:
	# 		if _dir == 2:
	# 			p7.go_left()
	# 		elif _dir == 3:
	# 			p7.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p7["pawn_num"] = p7.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p7.spawn_pawn()
	# 			p7.pawn_menu_vis(false)
	# 	elif _player == 8: 
	# 		if _dir == 2:
	# 			p8.go_left()
	# 		elif _dir == 3:
	# 			p8.go_right()
	# 		elif _dir == 0 || _dir == 6:
	# 			Player_Stats.p8["pawn_num"] = p8.go_start()
	# 			Player_Stats.set_in_game(_player,true)
	# 			Controllers.p8.spawn_pawn()
	# 			p8.pawn_menu_vis(false)

	# elif Game.get_started() && Player_Stats.get_in_play(_player) && Player_Stats.get_in_game(_player):
	# 	print_debug("error in hud input shouldnt see this you should be playing a game 0003")
	# else:
	# 	print_debug("error in hud input no parameters met 0001 --- ","game started = ", Game.get_started(),"in play = ",Player_Stats.get_in_play(_player),"in game = ",Player_Stats.get_in_game(_player))
	# state_machine()


# func get_player_hud(_player):
	# if _player == 1:
