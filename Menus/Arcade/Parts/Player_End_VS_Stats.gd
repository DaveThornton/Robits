extends VBoxContainer

export var player_num = 0

onready var pawn_01 = $MarginContainer0/Pawn_01_Pic
onready var pawn_02 = $MarginContainer0/Pawn_02_Pic
onready var pawn_03 = $MarginContainer0/Pawn_03_Pic
onready var pawn_04 = $MarginContainer0/Pawn_04_Pic
onready var pawn_05 = $MarginContainer0/Pawn_05_Pic
onready var pawn_06 = $MarginContainer0/Pawn_06_Pic
onready var pawn_07 = $MarginContainer0/Pawn_07_Pic
onready var pawn_08 = $MarginContainer0/Pawn_08_Pic
onready var pawn_09 = $MarginContainer0/Pawn_09_Pic
onready var pawn_10 = $MarginContainer0/Pawn_10_Pic
onready var pawn_11 = $MarginContainer0/Pawn_11_Pic
onready var pawn_12 = $MarginContainer0/Pawn_12_Pic
onready var pawn_13 = $MarginContainer0/Pawn_13_Pic
onready var pawn_14 = $MarginContainer0/Pawn_14_Pic
onready var pawn_15 = $MarginContainer0/Pawn_15_Pic

onready var player = $HBox_Player/Label2
onready var score = $HBox_Score/Label2
onready var kills = $HBox_Kills/Label2
onready var deaths = $HBox_Deaths/Label2
onready var kdr = $HBox_KDR/Label2
onready var shots = $HBox_Shots/Label2
onready var hits = $HBox_Hits/Label2
onready var miss = $HBox_Miss/Label2
onready var place = $Place_Label

var my_place = 0

func _ready():
	pass

func set_player_num(_player):
	player_num = _player

func update():
	var _player = Player_Stats.get_player_stats(player_num)
	grfx_update()
	player.text = str(player_num)
	score.text = str(_player["score"])
	kills.text = str(_player["kill"])
	deaths.text = str(_player["death"])
	var _kdr = "0"
	if _player["death"] <= 0:
		_kdr = _player["kill"]
	else:
		_kdr = _player["kill"] / _player["death"]
	kdr.text = str(stepify(_kdr, 0.01))
	shots.text = str(_player["shot"])
	hits.text = str(_player["hit"])
	miss.text = str(_player["hit"] - _player["shot"])
	var _places = Player_Stats.get_places()
	for i in _places.size():
		if i == _places.size() - 1 || _places.back().y == _places[i].y:
			place.text = Player_Stats.get_place_name(7)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-1].y:
			place.text = Player_Stats.get_place_name(i)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-2].y:
			place.text = Player_Stats.get_place_name(i-1)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-3].y:
			place.text = Player_Stats.get_place_name(i-2)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-4].y:
			place.text = Player_Stats.get_place_name(i-3)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-5].y:
			place.text = Player_Stats.get_place_name(i-4)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-6].y:
			place.text = Player_Stats.get_place_name(i-5)
			return
		elif _places[i].x == player_num && _places[i].y != _places[i-7].y:
			place.text = Player_Stats.get_place_name(i-6)
			return

func set_place_text(_text):
	place.text = _text

func grfx_update():
	if player_num == 0:
		print("error in player end vs stats grfx update is getting called before it has a player number")
		return
	var _pawn = Player_Stats.get_pawn_num(player_num)
	visable_pawn(_pawn).init(player_num)
		
	
func visable_pawn(_num):
	pawn_01.visible = false
	pawn_02.visible = false
	pawn_03.visible = false
	pawn_04.visible = false
	pawn_05.visible = false
	pawn_06.visible = false
	pawn_07.visible = false
	pawn_08.visible = false
	pawn_09.visible = false
	pawn_10.visible = false
	pawn_11.visible = false
	pawn_12.visible = false
	pawn_13.visible = false
	pawn_14.visible = false
	pawn_15.visible = false
	#set all to false
	if _num == 1:
		pawn_01.visible = true
		return pawn_01
	elif _num == 2:
		pawn_02.visible = true
		return pawn_02
	elif _num == 3:
		pawn_03.visible = true
		return pawn_03
	elif _num == 4:
		pawn_04.visible = true
		return pawn_04
	elif _num == 5:
		pawn_05.visible = true
		return pawn_05
	elif _num == 6:
		pawn_06.visible = true
		return pawn_06
	elif _num == 7:
		pawn_07.visible = true
		return pawn_07
	elif _num == 8:
		pawn_08.visible = true
		return pawn_08
	elif _num == 9:
		pawn_09.visible = true
		return pawn_09
	elif _num == 10:
		pawn_10.visible = true
		return pawn_10
	elif _num == 11:
		pawn_11.visible = true
		return pawn_11
	elif _num == 12:
		pawn_12.visible = true
		return pawn_12
	elif _num == 13:
		pawn_13.visible = true
		return pawn_13
	elif _num == 14:
		pawn_14.visible = true
		return pawn_14
	elif _num == 15:
		pawn_15.visible = true
		return pawn_15
	else:
		print("invalid pawn number in visible pawn in end game stats so i give you pawn 05")
		return pawn_05
