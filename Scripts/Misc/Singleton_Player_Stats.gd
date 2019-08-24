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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
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
	nrg = 100
}

var hud
var p_in_p = 0

signal hud_update(_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8)

func _ready():
	pass

func update_hud():
	emit_signal("hud_update", p1, p2, p3, p4, p5, p6, p7, p8)
	
func set_hud(_hud):
	hud = _hud

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
	else:
		print("Error in Singleton_Player_Stats add_score function invalid player number. ", _player, " <---player number.. score amount--->", _score_amount)

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
#	print(p1["shot"],"<--shot, hit--->", p1["hit"])

func nrg_update(_player, _nrg):
	if _player == 1:
		hud.update_p1_nrg(_nrg)
	elif _player == 2:
		hud.update_p2_nrg(_nrg)
	elif _player == 3:
		hud.update_p3_nrg(_nrg)
	elif _player == 4:
		hud.update_p4_nrg(_nrg)
	elif _player == 5:
		hud.update_p5_nrg(_nrg)
	elif _player == 6:
		hud.update_p6_nrg(_nrg)
	elif _player == 7:
		hud.update_p7_nrg(_nrg)
	elif _player == 8:
		hud.update_p8_nrg(_nrg)
	else:
		print("error on nrg update")

func ammo_update(_player, _ammo):
	if _player == 1:
		hud.update_p1_ammo(_ammo)
	elif _player == 2:
		hud.update_p2_ammo(_ammo)
	elif _player == 3:
		hud.update_p3_ammo(_ammo)
	elif _player == 4:
		hud.update_p4_ammo(_ammo)
	elif _player == 5:
		hud.update_p5_ammo(_ammo)
	elif _player == 6:
		hud.update_p6_ammo(_ammo)
	elif _player == 7:
		hud.update_p7_ammo(_ammo)
	elif _player == 8:
		hud.update_p8_ammo(_ammo)

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
	if a.y > b.y:
		return a.y

func reset():
	# might now work ? looks like it should work
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