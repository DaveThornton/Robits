extends HBoxContainer

onready var p1 = $VBox_Player_01
onready var p2 = $VBox_Player_02
onready var p3 = $VBox_Player_03
onready var p4 = $VBox_Player_04
onready var p5 = $VBox_Player_05
onready var p6 = $VBox_Player_06
onready var p7 = $VBox_Player_07
onready var p8 = $VBox_Player_08

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error Singleton HUD connecting to reset from world gd")
	reset()

func ask_insert_coin(_player):
#	SFX.play("Menu_Nagger_02")
	print("find a new sfx for no coins insterted in hud singlton")
	if _player == 1: p1.insert_coin()
	elif _player == 2: p2.insert_coin()
	elif _player == 3: p3.insert_coin()
	elif _player == 4: p4.insert_coin()
	elif _player == 5: p5.insert_coin()
	elif _player == 6: p6.insert_coin()
	elif _player == 7: p7.insert_coin()
	elif _player == 8: p8.insert_coin()

func coin_up(_player):
	SFX.play("Menu_Coin")
	if _player == 1:
		p1.set_coin_count(Player_Stats.p1["credit"])
		p1.coin_up()
	elif _player == 2:
		p2.set_coin_count(Player_Stats.p2["credit"])
		p2.coin_up()
	elif _player == 3:
		p3.set_coin_count(Player_Stats.p3["credit"])
		p3.coin_up()
	elif _player == 4:
		p4.set_coin_count(Player_Stats.p4["credit"])
		p4.coin_up()
	elif _player == 5:
		p5.set_coin_count(Player_Stats.p5["credit"])
		p5.coin_up()
	elif _player == 6:
		p6.set_coin_count(Player_Stats.p6["credit"])
		p6.coin_up()
	elif _player == 7:
		p7.set_coin_count(Player_Stats.p7["credit"])
		p7.coin_up()
	elif _player == 8:
		p8.set_coin_count(Player_Stats.p8["credit"])
		p8.coin_up()

func coin_count():
	p1.set_coin_count(Player_Stats.p1["credit"])
	p2.set_coin_count(Player_Stats.p2["credit"])
	p3.set_coin_count(Player_Stats.p3["credit"])
	p4.set_coin_count(Player_Stats.p4["credit"])
	p5.set_coin_count(Player_Stats.p5["credit"])
	p6.set_coin_count(Player_Stats.p6["credit"])
	p7.set_coin_count(Player_Stats.p7["credit"])
	p8.set_coin_count(Player_Stats.p8["credit"])

func use_credit(_player):
	SFX.play("Blip_05")

func player_ready(_player):
	if _player == 1: p1.player_ready()
	elif _player == 2: p2.player_ready()
	elif _player == 3: p3.player_ready()
	elif _player == 4: p4.player_ready()
	elif _player == 5: p5.player_ready()
	elif _player == 6: p6.player_ready()
	elif _player == 7: p7.player_ready()
	elif _player == 8: p8.player_ready()
	else: print("error in player_ready player number not valid. player : ",_player)

func player_select(_player):
	if _player == 1: p1.player_select()
	elif _player == 2: p2.player_select()
	elif _player == 3: p3.player_select()
	elif _player == 4: p4.player_select()
	elif _player == 5: p5.player_select()
	elif _player == 6: p6.player_select()
	elif _player == 7: p7.player_select()
	elif _player == 8: p8.player_select()
	else: print("error player_select player number not valid. player : ",_player)

func in_play_to_select():
	if Player_Stats.p1["in_play"]: p1.player_select()
	if Player_Stats.p2["in_play"]: p2.player_select()
	if Player_Stats.p3["in_play"]: p3.player_select()
	if Player_Stats.p4["in_play"]: p4.player_select()
	if Player_Stats.p5["in_play"]: p5.player_select()
	if Player_Stats.p6["in_play"]: p6.player_select()
	if Player_Stats.p7["in_play"]: p7.player_select()
	if Player_Stats.p8["in_play"]: p8.player_select()

func in_game():
	if Player_Stats.p1["in_play"]: p1.in_play()
	else: p1.in_game()
	if Player_Stats.p2["in_play"]: p2.in_play()
	else: p2.in_game()
	if Player_Stats.p3["in_play"]: p3.in_play()
	else: p3.in_game()
	if Player_Stats.p4["in_play"]: p4.in_play()
	else: p4.in_game()
	if Player_Stats.p5["in_play"]: p5.in_play()
	else: p5.in_game()
	if Player_Stats.p6["in_play"]: p6.in_play()
	else: p6.in_game()
	if Player_Stats.p7["in_play"]: p7.in_play()
	else: p7.in_game()
	if Player_Stats.p8["in_play"]: p8.in_play()
	else: p8.in_game()

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

func game_over():
	if Player_Stats.p1["in_play"]: p1.game_over()
	if Player_Stats.p2["in_play"]: p2.game_over()
	if Player_Stats.p3["in_play"]: p3.game_over()
	if Player_Stats.p4["in_play"]: p4.game_over()
	if Player_Stats.p5["in_play"]: p5.game_over()
	if Player_Stats.p6["in_play"]: p6.game_over()
	if Player_Stats.p7["in_play"]: p7.game_over()
	if Player_Stats.p8["in_play"]: p8.game_over()
	set_places()

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
	print(_places, _places.size())
	for p in _places.size():
		var o = p
		print(_places[p],"<---_places.  p---->", p," -  _places.size ----->",_places.size())
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

func game_over_input(_player, _input):
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
	
	if _in_play == _done:
		get_tree().get_current_scene().arcade_reset()

func get_game_over_done_count():
	var _done = 0
	if p1.game_done: _done += 1
	if p2.game_done: _done += 1
	if p3.game_done: _done += 1
	if p4.game_done: _done += 1
	if p5.game_done: _done += 1
	if p6.game_done: _done += 1
	if p7.game_done: _done += 1
	if p8.game_done: _done += 1
	return _done

func reset():
	coin_count()
	p1.reset()
	p2.reset()
	p3.reset()
	p4.reset()
	p5.reset()
	p6.reset()
	p7.reset()
	p8.reset()
