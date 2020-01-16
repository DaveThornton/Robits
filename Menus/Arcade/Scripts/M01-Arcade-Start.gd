extends Node2D

export(PackedScene) var next_screen 

func _ready():
	var test = Menu_Hand.connect("input_to_screen", self, "movement")
	if test != 0:
		print("error M01 Arcade Start  connecting input to movement")

func movement(_player, _dir):
	if _player == 1:
		if Player_Stats.p1["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p1["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 2:
		if Player_Stats.p2["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p2["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 3:
		if Player_Stats.p3["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p3["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 4:
		if Player_Stats.p4["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p4["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 5:
		if Player_Stats.p5["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p5["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 6:
		if Player_Stats.p6["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p6["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 7:
		if Player_Stats.p7["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p7["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	elif _player == 8:
		if Player_Stats.p8["credit"] >= 1:
			if _dir == 5:
				Player_Stats.p8["in_play"] = true
				Player_Stats.use_credit(_player)
				Menu_Hand.load_screen(next_screen)
				queue_free()
		else:
			HUD.ask_insert_coin(_player)
	else:
		print("error invald player in arcade start")