extends VBoxContainer

export var player_num = 0

onready var pawn_05 = $MarginContainer0/Pawn_05_Pic
onready var pawn_06 = $MarginContainer0/Pawn_06_Pic
onready var pawn_07 = $MarginContainer0/Pawn_07_Pic
onready var pawn_08 = $MarginContainer0/Pawn_08_Pic
onready var pawn_09 = $MarginContainer0/Pawn_09_Pic
onready var pawn_12 = $MarginContainer0/Pawn_12_Pic
onready var pawn_11 = $MarginContainer0/Pawn_11_Pic
onready var pawn_13 = $MarginContainer0/Pawn_13_Pic

onready var player = $HBox_Player/Label2
onready var score = $HBox_Score/Label2
onready var kills = $HBox_Kills/Label2
onready var deaths = $HBox_Deaths/Label2
onready var kdr = $HBox_KDR/Label2
onready var shots = $HBox_Shots/Label2
onready var hits = $HBox_Hits/Label2
onready var miss = $HBox_Miss/Label2
onready var place = $Place_Label

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
	miss.text = str(_player["shot"] - _player["hit"])
#	print(Player_Stats.get_places())
	place.text = "fix this"

func set_place_text(_text):
	place.text = _text

func grfx_update():
	if player_num == 0:
		print("error in player end vs stats grfx update is getting called before it has a player number")
		return
	var _pawn = Player_Stats.get_pawn_num(player_num)
	visable_pawn(_pawn).init(player_num)
		
	
func visable_pawn(_num):
	pawn_05.visible = false
	pawn_06.visible = false
	pawn_07.visible = false
	pawn_08.visible = false
	pawn_09.visible = false
	pawn_11.visible = false
	pawn_12.visible = false
	pawn_13.visible = false
	#set all to false
	if _num == 5:
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
	elif _num == 11:
		pawn_11.visible = true
		return pawn_11
	elif _num == 12:
		pawn_12.visible = true
		return pawn_12
	elif _num == 13:
		pawn_13.visible = true
		return pawn_13
	else:
		print("invalid pawn number in visible pawn in end game stats")
		return pawn_05
