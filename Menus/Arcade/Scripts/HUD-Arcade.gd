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
	p1.in_menu()
	p2.in_menu()
	p3.in_menu()
	p4.in_menu()
	p5.in_menu()
	p6.in_menu()
	p7.in_menu()
	p8.in_menu()
	p1.show_player()
	p2.show_player()
	p3.show_player()
	p4.show_player()
	p5.show_player()
	p6.show_player()
	p7.show_player()
	p8.show_player()

func ask_insert_coin(_player):
	if _player == 1:
		p1.insert_coin()
	elif _player == 2:
		p2.insert_coin()
	elif _player == 3:
		p3.insert_coin()
	elif _player == 4:
		p4.insert_coin()
	elif _player == 5:
		p5.insert_coin()
	elif _player == 6:
		p6.insert_coin()
	elif _player == 7:
		p7.insert_coin()
	elif _player == 8:
		p8.insert_coin()

#	if _player == 1:
#		p1["credit"] += 1
#		HUD.coin_count(1)
#		HUD.coin_up(_player,1)#_amount)

func coin_up(_player):
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

func use_credit(_player):
#	in_game()
	pass

func player_ready(_player):
	if _player == 1:
		p1.player_ready()
	elif _player == 2:
		p2.player_ready()
	elif _player == 3:
		p3.player_ready()
	elif _player == 4:
		p4.player_ready()
	elif _player == 5:
		p5.player_ready()
	elif _player == 6:
		p6.player_ready()
	elif _player == 7:
		p7.player_ready()
	elif _player == 8:
		p8.player_ready()

func player_select(_player):
	if _player == 1:
		p1.player_select()
	elif _player == 2:
		p2.player_select()
	elif _player == 3:
		p3.player_select()
	elif _player == 4:
		p4.player_select()
	elif _player == 5:
		p5.player_select()
	elif _player == 6:
		p6.player_select()
	elif _player == 7:
		p7.player_select()
	elif _player == 8:
		p8.player_select()

func in_play_to_select():
	if Player_Stats.p1["in_play"]:
		p1.player_select()
	if Player_Stats.p2["in_play"]:
		p2.player_select()
	if Player_Stats.p3["in_play"]:
		p3.player_select()
	if Player_Stats.p4["in_play"]:
		p4.player_select()
	if Player_Stats.p5["in_play"]:
		p5.player_select()
	if Player_Stats.p6["in_play"]:
		p6.player_select()
	if Player_Stats.p7["in_play"]:
		p7.player_select()
	if Player_Stats.p8["in_play"]:
		p8.player_select()

func in_game():
	if Player_Stats.p1["in_play"]:
		p1.in_play()
	else:
		p1.in_game()
	if Player_Stats.p2["in_play"]:
		p2.in_play()
	else:
		p2.in_game()
	if Player_Stats.p3["in_play"]:
		p3.in_play()
	else:
		p3.in_game()
	if Player_Stats.p4["in_play"]:
		p4.in_play()
	else:
		p4.in_game()
	if Player_Stats.p5["in_play"]:
		p5.in_play()
	else:
		p5.in_game()
	if Player_Stats.p6["in_play"]:
		p6.in_play()
	else:
		p6.in_game()
	if Player_Stats.p7["in_play"]:
		p7.in_play()
	else:
		p7.in_game()
	if Player_Stats.p8["in_play"]:
		p8.in_play()
	else:
		p8.in_game()

func game_over():
	if Player_Stats.p1["in_play"]:
		p1.game_over()
	if Player_Stats.p2["in_play"]:
		p2.game_over()
	if Player_Stats.p3["in_play"]:
		p3.game_over()
	if Player_Stats.p4["in_play"]:
		p4.game_over()
	if Player_Stats.p5["in_play"]:
		p5.game_over()
	if Player_Stats.p6["in_play"]:
		p6.game_over()
	if Player_Stats.p7["in_play"]:
		p7.game_over()
	if Player_Stats.p8["in_play"]:
		p8.game_over()

func set_score(_player):
	if _player == 1:
		p1.set_score_count(Player_Stats.p1["score"])
	elif _player == 2:
		p2.set_score_count(Player_Stats.p2["score"])
	elif _player == 3:
		p3.set_score_count(Player_Stats.p3["score"])
	elif _player == 4:
		p4.set_score_count(Player_Stats.p4["score"])
	elif _player == 5:
		p5.set_score_count(Player_Stats.p5["score"])
	elif _player == 6:
		p6.set_score_count(Player_Stats.p6["score"])
	elif _player == 7:
		p7.set_score_count(Player_Stats.p7["score"])
	elif _player == 8:
		p8.set_score_count(Player_Stats.p8["score"])

func set_nrg(_player, _amount):
	if _player == 1:
		p1.set_nrg_bar(_amount)
	elif _player == 2:
		p2.set_nrg_bar(_amount)
	elif _player == 3:
		p3.set_nrg_bar(_amount)
	elif _player == 4:
		p4.set_nrg_bar(_amount)
	elif _player == 5:
		p5.set_nrg_bar(_amount)
	elif _player == 6:
		p6.set_nrg_bar(_amount)
	elif _player == 7:
		p7.set_nrg_bar(_amount)
	elif _player == 8:
		p8.set_nrg_bar(_amount)
	else:
		print("error in nrg_update player number not valid. player : ",_player, ". amount :", _amount)

func set_ammo(_player, _amount):
	if _player == 1:
		p1.set_ammo_count(_amount)
	elif _player == 2:
		p2.set_ammo_count(_amount)
	elif _player == 3:
		p3.set_ammo_count(_amount)
	elif _player == 4:
		p4.set_ammo_count(_amount)
	elif _player == 5:
		p5.set_ammo_count(_amount)
	elif _player == 6:
		p6.set_ammo_count(_amount)
	elif _player == 7:
		p7.set_ammo_count(_amount)
	elif _player == 8:
		p8.set_ammo_count(_amount)

func reset():
	print("need to make reset in hud get on it lazy ass !!!")

#func _process(delta):
#	pass