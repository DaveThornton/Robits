extends Node

var p1 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 5,
	color_2 = Color8(255, 0, 0, 255),
	color_1 = Color8(145, 145, 145, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p2 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 7,
	color_2 = Color8(0, 255, 255, 255),
	color_1 = Color8(255, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p3 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 6,
	color_2 = Color8(255, 255, 0, 255),
	color_1 = Color8(255, 0, 0, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p4 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 5,
	color_2 = Color8(255, 255, 0, 255),
	color_1 = Color8(0, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p5 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 4,
	color_2 = Color8(255, 0, 0, 255),
	color_1 = Color8(255, 255, 0, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p6 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 3,
	color_2 = Color8(255, 0, 0, 255),
	color_1 = Color8(123, 0, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p7 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 2,
	color_2 = Color8(255, 0, 0, 255),
	color_1 = Color8(0, 255, 255, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p8 = {
	in_play = false,
	exist = false,
	credit = 0,
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0,
	ammo = 0,
	nrg = 100,
	pawn_num = 1,
	color_2 = Color8(255, 0, 0, 255),
	color_1 = Color8(0, 255, 0, 255),
	color_3 = Color8(255, 225, 225, 222)
}

var p_in_p = 0

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error Singleton Player Stats connecting to reset from world gd")

func update_hud():
	HUD.in_game()

func add_kill(_killed, _killer, _point, _by_what):
	add_score(_killer, _point)
	add_score(_killed,(-1 * _point))
	add_death(_killed)
	update_hud()

func add_death(_player):
	if _player == 1:
		p1["death"] += 1
	elif _player == 2:
		p2["death"] += 1
	elif _player == 3:
		p3["death"] += 1
	elif _player == 4:
		p4["death"] += 1
	elif _player == 5:
		p5["death"] += 1
	elif _player == 6:
		p6["death"] += 1
	elif _player == 7:
		p7["death"] += 1
	elif _player == 8:
		p8["death"] += 1
	else:
		print("Error in Singleton_Player_Stats add_death function invalid player number. ", _player)

func add_score(_player, _score_amount):
	if _player == 1:
		p1["score"] += _score_amount
	elif _player == 2:
		p2["score"] += _score_amount
	elif _player == 3:
		p3["score"] += _score_amount
	elif _player == 4:
		p4["score"] += _score_amount
	elif _player == 5:
		p5["score"] += _score_amount
	elif _player == 6:
		p6["score"] += _score_amount
	elif _player == 7:
		p7["score"] += _score_amount
	elif _player == 8:
		p8["score"] += _score_amount
	elif _player == -1:
		print("singleton_player_stats map kill")
	else:
		print("Error in Singleton_Player_Stats add_score function invalid player number. ", _player, " <---player number.. score amount--->", _score_amount)
	HUD.set_score(_player)

func add_shot(_player, _shot_amount):
	if _player == 1:
		p1["shot"] += _shot_amount
	elif _player == 2:
		p2["shot"] += _shot_amount
	elif _player == 3:
		p3["shot"] += _shot_amount
	elif _player == 4:
		p4["shot"] += _shot_amount
	elif _player == 5:
		p5["shot"] += _shot_amount
	elif _player == 6:
		p6["shot"] += _shot_amount
	elif _player == 7:
		p7["shot"] += _shot_amount
	elif _player == 8:
		p8["shot"] += _shot_amount
	else:
		print("Error in Singleton_Player_Stats add_shot function invalid player number. ", _player, " <---player number.. shot amount--->", _shot_amount)

func add_hit(_player, _hit_amount):
	if _player == 1:
		p1["hit"] += _hit_amount
	elif _player == 2:
		p2["hit"] += _hit_amount
	elif _player == 3:
		p3["hit"] += _hit_amount
	elif _player == 4:
		p4["hit"] += _hit_amount
	elif _player == 5:
		p5["hit"] += _hit_amount
	elif _player == 6:
		p6["hit"] += _hit_amount
	elif _player == 7:
		p7["hit"] += _hit_amount
	elif _player == 8:
		p8["hit"] += _hit_amount
	else:
		print("Error in Singleton_Player_Stats add_hit function invalid player number. ", _player, " <---player number.. hit amount--->", _hit_amount)

func coin_insert( _player):
	if _player == 1:
		p1["credit"] += 1
	elif _player == 2:
		p2["credit"] += 1
	elif _player == 3:
		p3["credit"] += 1
	elif _player == 4:
		p4["credit"] += 1
	elif _player == 5:
		p5["credit"] += 1
	elif _player == 6:
		p6["credit"] += 1
	elif _player == 7:
		p7["credit"] += 1
	elif _player == 8:
		p8["credit"] += 1
	else:
		print("invalid player in player stats coin insert ... _player --> ", _player)
	HUD.coin_up(_player)

func use_credit( _player):
	if _player == 1:
		p1["credit"] -= 1
		p1["in_play"] = true
	elif _player == 2:
		p2["credit"] -= 1
		p2["in_play"] = true
	elif _player == 3:
		p3["credit"] -= 1
		p3["in_play"] = true
	elif _player == 4:
		p4["credit"] -= 1
		p4["in_play"] = true
	elif _player == 5:
		p5["credit"] -= 1
		p5["in_play"] = true
	elif _player == 6:
		p6["credit"] -= 1
		p6["in_play"] = true
	elif _player == 7:
		p7["credit"] -= 1
		p7["in_play"] = true
	elif _player == 8:
		p8["credit"] -= 1
		p8["in_play"] = true
	else:
		print("invalid player in player stats use credit... _player --> ", _player)
	HUD.use_credit(_player)

func nrg_update(_player, _nrg, _nrg_max):
	var _current_nrg = int((float(_nrg) / _nrg_max)* 100)
	HUD.set_nrg(_player, _current_nrg)

func ammo_update(_player, _ammo):
	HUD.set_ammo(_player, _ammo)

func can_player_start(_player):
	if _player == 1 && p1["credit"] > 0:
		return true
	elif _player == 2 && p2["credit"] > 0:
		return true
	elif _player == 3 && p3["credit"] > 0:
		return true
	elif _player == 4 && p4["credit"] > 0:
		return true
	elif _player == 5 && p5["credit"] > 0:
		return true
	elif _player == 6 && p6["credit"] > 0:
		return true
	elif _player == 7 && p7["credit"] > 0:
		return true
	elif _player == 8 && p8["credit"] > 0:
		return true
	else:
		return false

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

func get_body_color(_player):
	if _player == 1:
		return p1["color_1"]
	elif _player == 2:
		return p2["color_1"]
	elif _player == 3:
		return p3["color_1"]
	elif _player == 4:
		return p4["color_1"]
	elif _player == 5:
		return p5["color_1"]
	elif _player == 6:
		return p6["color_1"]
	elif _player == 7:
		return p7["color_1"]
	elif _player == 8:
		return p8["color_1"]
	else:
		print("invalid player number in player stats , get body color so ill send player 1")
		return p1["color_1"]

func get_sec_color(_player):
	if _player == 1:
		return p1["color_2"]
	elif _player == 2:
		return p2["color_2"]
	elif _player == 3:
		return p3["color_2"]
	elif _player == 4:
		return p4["color_2"]
	elif _player == 5:
		return p5["color_2"]
	elif _player == 6:
		return p6["color_2"]
	elif _player == 7:
		return p7["color_2"]
	elif _player == 8:
		return p8["color_2"]
	else:
		print("invalid player number in player stats , get body color so ill send player 1")
		return p1["color_2"]

func get_pawn_num(_player):
	if _player == 1:
		return p1["pawn_num"]
	elif _player == 2:
		return p2["pawn_num"]
	elif _player == 3:
		return p3["pawn_num"]
	elif _player == 4:
		return p4["pawn_num"]
	elif _player == 5:
		return p5["pawn_num"]
	elif _player == 6:
		return p6["pawn_num"]
	elif _player == 7:
		return p7["pawn_num"]
	elif _player == 8:
		return p8["pawn_num"]
	else:
		print("invalid player number in get pawn num in player stats --> ", _player )

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
	elif _place == 8:
		return "why so Last"
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
	print("places before sort : ",_places, " in player stats")
#	_places.sort()
	_places.sort_custom(self,"sort_place")
	print("places after sort : ",_places, " in player stats")
	return _places

func sort_place(a, b):
	if a.y < b.y:
		return false
	return true

func reset():
	p1["kill"] = 0
	p1["death"] = 0
	p1["score"] = 0
	p1["shot"] = 0
	p1["hit"] = 0
	p1["in_play"] = false

	p2["kill"] = 0
	p2["death"] = 0
	p2["score"] = 0
	p2["shot"] = 0
	p2["hit"] = 0
	p2["in_play"] = false
	
	p3["kill"] = 0
	p3["death"] = 0
	p3["score"] = 0
	p3["shot"] = 0
	p3["hit"] = 0
	p3["in_play"] = false
	
	p4["kill"] = 0
	p4["death"] = 0
	p4["score"] = 0
	p4["shot"] = 0
	p4["hit"] = 0
	p4["in_play"] = false
	
	p5["kill"] = 0
	p5["death"] = 0
	p5["score"] = 0
	p5["shot"] = 0
	p5["hit"] = 0
	p5["in_play"] = false
	
	p6["kill"] = 0
	p6["death"] = 0
	p6["score"] = 0
	p6["shot"] = 0
	p6["hit"] = 0
	p6["in_play"] = false
	
	p7["kill"] = 0
	p7["death"] = 0
	p7["score"] = 0
	p7["shot"] = 0
	p7["hit"] = 0
	p7["in_play"] = false
	
	p8["kill"] = 0
	p8["death"] = 0
	p8["score"] = 0
	p8["shot"] = 0
	p8["hit"] = 0
	p8["in_play"] = false
