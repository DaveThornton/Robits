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
	place_label.text = "unused so far need to sort player ranking"

func player1():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-01.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-01.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p1_score)
	var kills = float(get_tree().get_current_scene().p1_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p1_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p1_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p1_hits)
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
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-02.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-02.png")
#	my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn--01-02.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p2_score)
	var kills = float(get_tree().get_current_scene().p2_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p2_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p2_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p2_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "second"

func player3():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-03.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-03.png")
#	my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-03.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p3_score)
	var kills = float(get_tree().get_current_scene().p3_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p3_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p3_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p3_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text =  "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "third"

func player4():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-04.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-04.png")
#	my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-04.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p4_score)
	var kills = float(get_tree().get_current_scene().p4_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p4_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p4_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p4_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text = "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "forth"

func player5():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-05.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-05.png")
#	my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-05.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p5_score)
	var kills = float(get_tree().get_current_scene().p5_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p5_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p5_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p5_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text = "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "fifth"

func player6():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-06.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-06.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p6_score)
	var kills = float(get_tree().get_current_scene().p6_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p6_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p6_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p6_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text = "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "fifth"

func player7():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-07.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-07.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p7_score)
	var kills = float(get_tree().get_current_scene().p7_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p7_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p7_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p7_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text = "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "fifth"

func player8():
	pawn_num = player_con.pawn_num
	if pawn_num == 1 || pawn_num == 2 || pawn_num == 3 || pawn_num == 4:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01-08.png")
#	elif pawn_num == 2:
	else:
		my_sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-08.png")
	player_label.text = str(player_num)
	score_label.text = str(get_tree().get_current_scene().p8_score)
	var kills = float(get_tree().get_current_scene().p8_hits)
	kill_label.text = str(kills)
	var deaths = float(get_tree().get_current_scene().p8_deaths)
	death_label.text = str(deaths)
	var kdr = 0.0
	if deaths <= 0:
		kdr = kills
	else:
		kdr = kills / deaths
	kdr_label.text = str(stepify(kdr, 0.01))# * 100), "%")
	var shots = float(get_tree().get_current_scene().p8_shots)
	Shot_label.text = str(shots)
	var hits = float(get_tree().get_current_scene().p8_hits)
	hit_label.text = str(hits)
	var miss = shots - hits
	miss_label.text = str(miss)
	if hits == 0 || shots == 0:
		hitper_label.text = "0 %"
	else:
		hitper_label.text = str(stepify(hits / shots,0.01)* 100, "%")
#	place_label.text = "fifth"