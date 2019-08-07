extends Node

var p1_kills = 0
var p2_kills = 0
var p3_kills = 0
var p4_kills = 0
var p5_kills = 0
var p6_kills = 0
var p7_kills = 0
var p8_kills = 0

var p1_deaths = 0
var p2_deaths = 0
var p3_deaths = 0
var p4_deaths = 0
var p5_deaths = 0
var p6_deaths = 0
var p7_deaths = 0
var p8_deaths = 0

var p1_score = 0
var p2_score = 0
var p3_score = 0
var p4_score = 0
var p5_score = 0
var p6_score = 0
var p7_score = 0
var p8_score = 0

var p1_shots = 0
var p2_shots = 0
var p3_shots = 0
var p4_shots = 0
var p5_shots = 0
var p6_shots = 0
var p7_shots = 0
var p8_shots = 0

var p1_hits = 0
var p2_hits = 0
var p3_hits = 0
var p4_hits = 0
var p5_hits = 0
var p6_hits = 0
var p7_hits = 0
var p8_hits = 0

func add_kill(_killed, _killer):
	add_score(_killer,1)
	add_score(_killed,-1)
	add_death(_killed)
		

func add_death(_player):
	if _player == 1:
		p1_deaths += 1
	elif _player == 2:
		p2_deaths += 1
	elif _player == 3:
		p3_deaths += 1
	elif _player == 4:
		p4_deaths += 1
	elif _player == 5:
		p5_deaths += 1
	elif _player == 6:
		p6_deaths += 1
	elif _player == 7:
		p7_deaths += 1
	elif _player == 8:
		p8_deaths += 1
	else:
		print("Error in Singleton_Player_Stats add_death function invalid player number. ", _player)

func add_score(_player, _score_amount):
	if _player == 1:
		p1_score += _score_amount
	elif _player == 2:
		p2_score += _score_amount
	elif _player == 3:
		p3_score += _score_amount
	elif _player == 4:
		p4_score += _score_amount
	elif _player == 5:
		p5_score += _score_amount
	elif _player == 6:
		p6_score += _score_amount
	elif _player == 7:
		p7_score += _score_amount
	elif _player == 8:
		p8_score += _score_amount
	else:
		print("Error in Singleton_Player_Stats add_score function invalid player number. ", _player, " <---player number.. score amount--->", _score_amount)

func add_shot(_player, _shot_amount):
	if _player == 1:
		p1_shots += _shot_amount
	elif _player == 2:
		p2_shots += _shot_amount
	elif _player == 3:
		p3_shots += _shot_amount
	elif _player == 4:
		p4_shots += _shot_amount
	elif _player == 5:
		p5_shots += _shot_amount
	elif _player == 6:
		p6_shots += _shot_amount
	elif _player == 7:
		p7_shots += _shot_amount
	elif _player == 8:
		p8_shots += _shot_amount
	else:
		print("Error in Singleton_Player_Stats add_shot function invalid player number. ", _player, " <---player number.. shot amount--->", _shot_amount)

func add_hit(_player, _hit_amount):
	if _player == 1:
		p1_hits += _hit_amount
	elif _player == 2:
		p2_hits += _hit_amount
	elif _player == 3:
		p3_hits += _hit_amount
	elif _player == 4:
		p4_hits += _hit_amount
	elif _player == 5:
		p5_hits += _hit_amount
	elif _player == 6:
		p6_hits += _hit_amount
	elif _player == 7:
		p7_hits += _hit_amount
	elif _player == 8:
		p8_hits += _hit_amount
	else:
		print("Error in Singleton_Player_Stats add_hit function invalid player number. ", _player, " <---player number.. hit amount--->", _hit_amount)
		

func reset():
	p1_kills = 0
	p2_kills = 0
	p3_kills = 0
	p4_kills = 0
	p5_kills = 0
	p6_kills = 0
	p7_kills = 0
	p8_kills = 0
	p1_deaths = 0
	p2_deaths = 0
	p3_deaths = 0
	p4_deaths = 0
	p5_deaths = 0
	p6_deaths = 0
	p7_deaths = 0
	p8_deaths = 0
	p1_score = 0
	p2_score = 0
	p3_score = 0
	p4_score = 0
	p5_score = 0
	p6_score = 0
	p7_score = 0
	p8_score = 0
	p1_shots = 0
	p2_shots = 0
	p3_shots = 0
	p4_shots = 0
	p5_shots = 0
	p6_shots = 0
	p7_shots = 0
	p8_shots = 0
	p1_hits = 0
	p2_hits = 0
	p3_hits = 0
	p4_hits = 0
	p5_hits = 0
	p6_hits = 0
	p7_hits = 0
	p8_hits = 0