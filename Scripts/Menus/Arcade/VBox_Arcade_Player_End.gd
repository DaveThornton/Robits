extends VBoxContainer
onready var my_sprite = $MarginContainer/Sprite
onready var player_label = $VBoxContainer/HBoxName/Label2
onready var score_label = $VBoxContainer/HBoxScore/Label2
onready var kill_label = $VBoxContainer/HBoxKills/Label2
onready var death_label = $VBoxContainer/HBoxDeaths/Label2
onready var kdr_label = $VBoxContainer/HBoxKDR/Label2
onready var Shot_label = $VBoxContainer/HBoxShots/Label2
onready var hit_label = $VBoxContainer/HBoxHits/Label2
onready var miss_label = $VBoxContainer/HBoxMisses/Label2
onready var hitper_label = $VBoxContainer/HBoxHitPer/Label2
onready var place_label = $VBoxContainer/HBoxPlace/Label

export var player_num = 1
var player_con
var pawn_num = 1
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01.png")
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02.png")
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03.png")
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-04.png")
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-05.png")

func _ready():
	if player_num == 1:
		player_con = get_tree().get_current_scene().p1_controller
		player1()
	elif player_num == 2:
		player_con = get_tree().get_current_scene().p2_controller
		player2()
	elif player_num == 3:
		player_con = get_tree().get_current_scene().p3_controller
		player3()
	elif player_num == 4:
		player_con = get_tree().get_current_scene().p4_controller
		player4()
	elif player_num == 5:
		player_con = get_tree().get_current_scene().p5_controller
		player5()
	elif player_num == 6:
		player_con = get_tree().get_current_scene().p3_controller
		player6()
	elif player_num == 7:
		player_con = get_tree().get_current_scene().p4_controller
		player7()
	elif player_num == 8:
		player_con = get_tree().get_current_scene().p5_controller
		player8()
	print("arcade vbox says im pawn ", pawn_num)
	place_label.text = "first place"

func set_place(_place):
	if _place == 1:
		place_label.text = "  first place"
	elif _place == 2:
		place_label.text = "first looser"
	elif _place == 3:
		place_label.text = "turd place"
	elif _place == 4:
		place_label.text = "4th place"
	elif _place == 5:
		place_label.text = "fiveth place" 
	elif _place == 6:
		place_label.text = "sixth place"
	elif _place == 7:
		place_label.text = "7th"
	elif _place == 8:
		place_label.text = "Last!?!"

func player1():
	pawn_num = player_con.pawn_num
	
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-01.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-01.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-01.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-01.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p1["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p1["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p1["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p1["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p1["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player2():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-02.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-02.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-02.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-02.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p2["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p2["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p2["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p2["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p2["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player3():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-03.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-03.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-03.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-03.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p3["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p3["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p3["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p3["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p3["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player4():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-04.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-04.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-04.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-04.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p4["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p4["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p4["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p4["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p4["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player5():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-05.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-05.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-05.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-05.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p5["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p5["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p5["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p5["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p5["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player6():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-06.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-01.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-01.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-01.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p6["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p6["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p6["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p6["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p6["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player7():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-07.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-07.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-07.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-07.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p7["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p7["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p7["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p7["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p7["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"

func player8():
	pawn_num = player_con.pawn_num
	if pawn_num == 1:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-08.png")
	elif pawn_num == 2:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-08.png")
	elif pawn_num == 3:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03-08.png")
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-08.png")
	
	player_label.text = str(player_num)
	score_label.text = str(Player_Stats.p8["score"])
#	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(Player_Stats.p8["kill"])
	kill_label.text = str(kills)
	var deaths = float(Player_Stats.p8["death"])
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(Player_Stats.p8["shot"])
	Shot_label.text = str(shots)
	var hits = float(Player_Stats.p8["hit"])
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "first"