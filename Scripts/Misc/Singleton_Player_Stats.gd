extends Node

var p1 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p2 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p3 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p4 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p5 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p6 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p7 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

var p8 = {
	kill = 0,
	death = 0,
	score = 0,
	shot = 0,
	hit = 0
}

func _ready():
	pass

func add_kill(_killed, _killer):
	add_score(_killer,1)
	add_score(_killed,-1)
	add_death(_killed)
		

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
	print(p1["shot"],"<--shot, hit--->", p1["hit"])


func reset():
	# might now work ? looks like it should work
	p1 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p2 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p3 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p4 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p5 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p6 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p7 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}
	
	p8 = {
		kill = 0,
		death = 0,
		score = 0,
		shot = 0,
		hit = 0
	}