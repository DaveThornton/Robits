extends Node

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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(76, 255, 142, 255),
	color_1 = Color8(232, 32, 75, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(255, 0, 195, 255),
	color_1 = Color8(103, 255, 85, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(255, 151, 15, 255),
	color_1 = Color8(25, 145, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(82, 235, 0, 255),
	color_1 = Color8(255, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(255, 232, 0, 255),
	color_1 = Color8(119, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(225, 98, 15, 255),
	color_1 = Color8(0, 255, 244, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(0, 30, 255, 255),
	color_1 = Color8(255, 220, 72, 255),
	color_3 = Color8(255, 225, 225, 222)
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
	shot = 0,
	hit = 0.0,
	ammo = 0,
	nrg = 100,
	pawn_num = -1,
	color_2 = Color8(20, 255, 254, 255),
	color_1 = Color8(255, 105, 45, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p_in_p = 0

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error Singleton Player Stats connecting to reset from world gd")
	if get_tree().get_current_scene().game_mode == 3:
		print("pawns set in player stats")
		p1["pawn_num"] = 6
		p2["pawn_num"] = 4
		p3["pawn_num"] = 5
		p4["pawn_num"] = 9
		p5["pawn_num"] = 12
		p6["pawn_num"] = 10
		p7["pawn_num"] = 15
		p8["pawn_num"] = 13

func add_kill(_killed, _killer, _point, _by_what):
	print(_killed," by ",_killer," for ",_point, " points with ",_by_what)
	if _killer > 0:
		add_score(_killer, _point)
		get_player_stats(_killer)["kill"] += 1
	add_score(_killed,(-1 * _point))
	add_death(_killed)

func add_death(_player):
	get_player_stats(_player)["death"] += 1
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
		print("singleton_player_stats map kill")
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
		print("invalid player in player stats coin insert ... _player --> ", _player)
	HUD.coin_up(_player)

func use_credit( _player):
	set_lives_up(_player)
	var _ps = get_player_stats(_player)
	_ps["credit"] -= 1
	_ps["in_play"] = true
	_ps["done"] = false
	HUD.coin_update(_player)

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

func set_done(_player,_done): get_player_stats(_player)["done"] = _done

func set_can_spawn(_player, _spawn): get_player_stats(_player)["can_spawn"] = _spawn #maybe do away with 

func set_continuing(_player, _continue): get_player_stats(_player)["continuing"] = _continue

func get_continuing(_player): return get_player_stats(_player)["continuing"]

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
		print("invalid get player stats, get player stats thats dumb  -->  ", _num)

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
#	print("places before sort : ",_places, " in player stats")
#	_places.sort()
	_places.sort_custom(self,"sort_place")
#	print("places after sort : ",_places, " in player stats")
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
	
func reset_player_not_score(_player):# or name
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
