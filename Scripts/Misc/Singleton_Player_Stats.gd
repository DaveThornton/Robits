extends Node
#look in ready func for demo pawn selection
var p1 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 25,
	color_2 = Color8(76, 255, 142, 255),
	color_1 = Color8(232, 32, 75, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p2 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 26,
	color_2 = Color8(255, 0, 195, 255),
	color_1 = Color8(103, 255, 85, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p3 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 27,
	color_2 = Color8(255, 151, 15, 255),
	color_1 = Color8(25, 145, 255, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p4 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 28,
	color_2 = Color8(82, 235, 0, 255),
	color_1 = Color8(255, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p5 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 29,
	color_2 = Color8(255, 232, 0, 255),
	color_1 = Color8(119, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p6 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 30,
	color_2 = Color8(225, 98, 15, 255),
	color_1 = Color8(0, 255, 244, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p7 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 31,
	color_2 = Color8(0, 30, 255, 255),
	color_1 = Color8(255, 220, 72, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p8 = {
	my_name = "!!!!",
	continuing = false,
	can_spawn = true,
	in_play = false,
	in_game = false,
	exist = false,
	done = true,
	credit = 0,
	lives = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0.0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	collision_layer = 32,
	color_2 = Color8(20, 255, 254, 255),
	color_1 = Color8(255, 105, 45, 255),
	color_3 = Color8(255, 225, 225, 222),
	player_indi_vis = false,
	team = 0,
	weap_kill_w = {},
	weap_killed_by = {}
}

var p_in_p = 0

signal player_count_change

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error Singleton Player Stats connecting to reset from world gd")
	if get_tree().get_current_scene().game_mode == 3: #thats in world not in game
		print_debug("pawns set in player stats")
		p1["pawn_num"] = 10
		p2["pawn_num"] = 6
		p3["pawn_num"] = 14
		p4["pawn_num"] = 14
		p5["pawn_num"] = 13
		p6["pawn_num"] = 5
		p7["pawn_num"] = 2
		p8["pawn_num"] = 2

func add_kill(_killed, _killer, _point, _by_what):
	# print_debug(_killed," by ",_killer," for ",_point, " points with ",_by_what)
	if _killer > 0:
		add_score(_killer, _point)
		get_player_stats(_killer)["kill"] += 1
	if _point > 1 && Settings.get_multi_minus_on_death():
		add_score(_killed,(-1 * (_point -1)))
	add_killed_by(_killed, _by_what)
	add_kill_w(_killer, _by_what)
	# get_player_stats(_killer).weap_kill_w.append(Vector2(_by_what,1))
	# get_player_stats(_killed).weap_kill_by.append(Vector2(_by_what,1))
	add_death(_killed)

func add_death(_player):
	get_player_stats(_player)["death"] += 1
	if Settings.get_multi_minus_on_death():
		add_score(_player,-1)
	if Game.use_lives():
		var _ps = get_player_stats(_player)
		_ps["lives"] -= 1
		HUD.set_lives(_player,_ps["lives"])
		if _ps["lives"] == 0:
			HUD.set_continue(_player, true)

func add_score(_player, _score_amount):
	if _player > 0:
		get_player_stats(_player)["score"] += _score_amount
	elif _player == -1:
		print_debug("singleton_player_stats map kill")
	HUD.set_score(_player)

func add_shot(_player, _shot_amount): get_player_stats(_player)["shot"] += _shot_amount

func add_hit(_player, _hit_amount):
	if _player > 0:
		get_player_stats(_player)["hit"] += _hit_amount

func coin_insert( _player):
	if _player > 0:
		get_player_stats(_player)["credit"] += 1
	elif  _player == -1:
		p1["credit"] += 1
		p2["credit"] += 1
		p3["credit"] += 1
		p4["credit"] += 1
		p5["credit"] += 1
		p6["credit"] += 1
		p7["credit"] += 1
		p8["credit"] += 1
	else:
		print_debug("invalid player in player stats coin insert ... _player --> ", _player)
	HUD.coin_up(_player)

func use_credit( _player):
	set_lives_up(_player)
	var _ps = get_player_stats(_player)
	_ps["credit"] -= 1
	_ps["in_play"] = true
	_ps["done"] = false
	HUD.coin_update(_player)
	emit_signal("player_count_change")

func nrg_update(_player, _nrg, _nrg_max):
	var _current_nrg = int((float(_nrg) / _nrg_max)* 100)
	HUD.set_nrg(_player, _current_nrg)

func ammo_update(_player, _ammo):
	HUD.set_ammo(_player, _ammo)

func can_player_start(_player):
	if get_player_stats(_player)["credit"] > 0:
		return true
	else:
		return false

func can_spawn(_player): return get_player_stats(_player)["can_spawn"]#maybe do away with

func set_in_game(_player,_in_game): get_player_stats(_player)["in_game"] = _in_game

func set_all_in_game(in_game):
	if p1:
		p1["in_game"] = in_game
	if p2:
		p2["in_game"] = in_game	
	if p3:
		p3["in_game"] = in_game
	if p4:
		p4["in_game"] = in_game	
	if p5:
		p5["in_game"] = in_game
	if p6:
		p6["in_game"] = in_game	
	if p7:
		p7["in_game"] = in_game
	if p8:
		p8["in_game"] = in_game	
	
func set_lives_up(_player): get_player_stats(_player)["lives"] += Settings.lives_per_credit

func add_lives(_player,_amount): get_player_stats(_player)["lives"] += _amount

func set_lives_to(_player,_amount): get_player_stats(_player)["lives"] = _amount

func check_lives():# might not be used look in to it
	if p1["lives"] == 0:
		p1["in_play"] = false
		p1["in_game"] = false
	if p2["lives"] == 0:
		p2["in_play"] = false
		p2["in_game"] = false
	if p3["lives"] == 0:
		p3["in_play"] = false
		p3["in_game"] = false
	if p4["lives"] == 0:
		p4["in_play"] = false
		p4["in_game"] = false
	if p5["lives"] == 0:
		p5["in_play"] = false
		p5["in_game"] = false
	if p6["lives"] == 0:
		p6["in_play"] = false
		p6["in_game"] = false
	if p7["lives"] == 0:
		p7["in_play"] = false
		p7["in_game"] = false
	if p8["lives"] == 0:
		p8["in_play"] = false
		p8["in_game"] = false
	HUD.state_machine()

func set_in_play(_player, _in_play):
	get_player_stats(_player)["in_play"] = _in_play
	if Game.use_lives(): HUD.set_lives(_player,get_player_stats(_player)["lives"])

func set_all_in_play(_in_play):
	if p1:
		p1["in_play"] = _in_play
	if p2:
		p2["in_play"] = _in_play	
	if p3:
		p3["in_play"] = _in_play
	if p4:
		p4["in_play"] = _in_play	
	if p5:
		p5["in_play"] = _in_play
	if p6:
		p6["in_play"] = _in_play	
	if p7:
		p7["in_play"] = _in_play
	if p8:
		p8["in_play"] = _in_play	

func set_done(_player,_done): get_player_stats(_player)["done"] = _done

func set_can_spawn(_player, _spawn): get_player_stats(_player)["can_spawn"] = _spawn #maybe do away with

func set_player_indi_vis(_player, _vis): get_player_stats(_player)["get_player_indi_vis"] = _vis

func set_team(_player, _team): get_player_stats(_player)["team"] = _team

func set_continuing(_player, _continue): get_player_stats(_player)["continuing"] = _continue

func add_killed_by(_player, _weap):
	if _weap < 100:
		if get_player_stats(_player).weap_killed_by.has(_weap):
			get_player_stats(_player).weap_killed_by[_weap] += 1
		else:
			get_player_stats(_player).weap_killed_by[_weap] = 1
	else:
		print_debug("didnt add kill bc weap number wasnt reconized")
	print(get_player_stats(_player).weap_killed_by, "     killed by ", _player)

func add_kill_w(_player, _weap):
	if _weap < 100:
		if get_player_stats(_player).weap_kill_w.has(_weap):
			var p = get_player_stats(_player).weap_kill_w[_weap]
			get_player_stats(_player).weap_kill_w[_weap] = p + 1
		else:
			get_player_stats(_player).weap_kill_w[_weap] = 1
	else:
		print_debug("didnt add kill bc weap number wasnt reconized")
	print(get_player_stats(_player).weap_kill_w, "     kill with ", _player)
func get_killed_by(_player):
	return get_player_stats(_player).weap_killed_by

func get_killed_w(_player):
	return get_player_stats(_player).weap_kill_w

func get_continuing(_player): return get_player_stats(_player)["continuing"]

func get_team(_player): return get_player_stats(_player)["team"]

func get_in_game(_player): return get_player_stats(_player)["in_game"]

func get_num_in_game():
	var _num_in_game = 0
	if p1["in_game"]:
		_num_in_game += 1
	if p2["in_game"]:
		_num_in_game += 1
	if p3["in_game"]:
		_num_in_game += 1
	if p4["in_game"]:
		_num_in_game += 1
	if p5["in_game"]:
		_num_in_game += 1
	if p6["in_game"]:
		_num_in_game += 1
	if p7["in_game"]:
		_num_in_game += 1
	if p8["in_game"]:
		_num_in_game += 1
	return _num_in_game

func get_in_play(_player): return get_player_stats(_player)["in_play"]

func get_num_in_play():
	var _num_in_play = 0
	if p1["in_play"]:
		_num_in_play += 1
	if p2["in_play"]:
		_num_in_play += 1
	if p3["in_play"]:
		_num_in_play += 1
	if p4["in_play"]:
		_num_in_play += 1
	if p5["in_play"]:
		_num_in_play += 1
	if p6["in_play"]:
		_num_in_play += 1
	if p7["in_play"]:
		_num_in_play += 1
	if p8["in_play"]:
		_num_in_play += 1
	return _num_in_play

func get_done(_player): return get_player_stats(_player)["done"]

func get_all_done():
	if p1["done"] && p2["done"] && p3["done"] && p4["done"] && p5["done"] && p6["done"] && p7["done"] && p8["done"]:
		return true
	else:
		return false

func get_body_color(_player): return get_player_stats(_player)["color_1"]

func get_sec_color(_player): return get_player_stats(_player)["color_2"]

func get_pawn_num(_player):return get_player_stats(_player)["pawn_num"]

func get_lives_left(_player):return get_player_stats(_player)["lives"]

func get_score(_player):return get_player_stats(_player)["score"]

func get_credit(_player): return get_player_stats(_player)["credit"]

func get_player_indi_vis(_player): return get_player_stats(_player)["player_indi_vis"]

func get_player_stats(_num):
	if _num == 1:
		return p1
	elif _num == 2:
		return p2
	elif _num == 3:
		return p3
	elif _num == 4:
		return p4
	elif _num == 5:
		return p5
	elif _num == 6:
		return p6
	elif _num == 7:
		return p7
	elif _num == 8:
		return p8
	else:
		print_debug("invalid get player stats, get player stats thats dumb  -->  ", _num)
		return p8

func get_player_collision_layer(_player): return get_player_stats(_player)["collision_layer"]

func get_place_name(_place):
	if _place == 0:
		return "first Place"
	elif _place == 1:
		return "Second P!!!"
	elif _place == 2:
		return "Turd Place"
	elif _place == 3:
		return "Fourth Spot"
	elif _place == 4:
		return "5ish place"
	elif _place == 5:
		return "Deep Six"
	elif _place == 6:
		return "Almost 7ast"
	elif _place == 7:
		return "Last"
	else:
		return "error not a valaid number"

func get_places():
	p_in_p = 0
	var _places =[]
	if p1["in_play"]:
		var _p1score = Vector2(1, p1["score"])
		_places.append(_p1score)
		p_in_p += 1
	if p2["in_play"]:
		var _p2score = Vector2(2, p2["score"])
		_places.append(_p2score)
		p_in_p += 1
	if p3["in_play"]:
		var _p3score = Vector2(3, p3["score"])
		_places.append(_p3score)
		p_in_p += 1
	if p4["in_play"]:
		var _p4score = Vector2(4, p4["score"])
		_places.append(_p4score)
		p_in_p += 1
	if p5["in_play"]:
		var _p5score = Vector2(5, p5["score"])
		_places.append(_p5score)
		p_in_p += 1
	if p6["in_play"]:
		var _p6score = Vector2(6, p6["score"])
		_places.append(_p6score)
		p_in_p += 1
	if p7["in_play"]:
		var _p7score = Vector2(7, p7["score"])
		_places.append(_p7score)
		p_in_p += 1
	if p8["in_play"]:
		var _p8score = Vector2(8, p8["score"])
		_places.append(_p8score)
		p_in_p += 1

	_places.sort_custom(self,"sort_place")
	return _places

func sort_place(a, b):
	if a.y < b.y:
		return false
	return true

func reset():
	reset_player(1)
	reset_player(2)
	reset_player(3)
	reset_player(4)
	reset_player(5)
	reset_player(6)
	reset_player(7)
	reset_player(8)

func reset_player(_player):
	get_player_stats(_player)["name"] = "!!!!"
	get_player_stats(_player)["continuing"] = false
	get_player_stats(_player)["can_spawn"]= true
	get_player_stats(_player)["in_play"] = false
	get_player_stats(_player)["in_game"] = false
	get_player_stats(_player)["done"] = true
	get_player_stats(_player)["exist"] = false
	get_player_stats(_player)["kill"] = 0
	get_player_stats(_player)["lives"] = 0
	get_player_stats(_player)["death"] = 0
	get_player_stats(_player)["score"] = 0
	get_player_stats(_player)["shot"] = 0
	get_player_stats(_player)["hit"] = 0
	get_player_stats(_player)["ammo"] = 0
	get_player_stats(_player)["nrg"] = 100
	get_player_stats(_player)["pawn_num"] = -1
	get_player_stats(_player)["get_player_indi_vis"] = false
	get_player_stats(_player)["team"] = 0
	get_player_stats(_player)["weap_kill_w"].clear()
	get_player_stats(_player)["weap_killed_by"].clear()

func reset_player_not_score(_player):# or name or player indi or team or killed by and with
	get_player_stats(_player)["continuing"] = false
	get_player_stats(_player)["can_spawn"]= true
	get_player_stats(_player)["in_play"] = false
	get_player_stats(_player)["in_game"] = false
	get_player_stats(_player)["done"] = true
	get_player_stats(_player)["exist"] = false
	get_player_stats(_player)["kill"] = 0
	get_player_stats(_player)["lives"] = 0
	get_player_stats(_player)["death"] = 0
	get_player_stats(_player)["shot"] = 0
	get_player_stats(_player)["hit"] = 0
	get_player_stats(_player)["ammo"] = 0
	get_player_stats(_player)["nrg"] = 100
	get_player_stats(_player)["pawn_num"] = -1
