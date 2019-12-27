extends VBoxContainer

export var player_num = 0

onready var sprite_loco = $MarginContainer0/Sprite_Loco
onready var sprite_body = $MarginContainer0/Sprite_Body
onready var sprite_face = $MarginContainer0/Sprite_Face 

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
	grfx_update(_player)
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

func grfx_update(_player):
	sprite_body.modulate = _player["color_body"]
	sprite_face.modulate = _player["color_face"]
	sprite_loco.modulate = _player["color_loco"]
	if _player["pawn_num"] == 1:
		sprite_body.texture = load("res://Sprites/Pawns/Robit_Pawn-01-00.png")
		sprite_face.texture = load("res://Sprites/Pawns/Robit_Pawn-01-00-Face.png")
		sprite_loco.texture = load("res://Sprites/Pawns/Robit_Pawn-01-00-Wheel.png")
	elif _player["pawn_num"] == 2:
		sprite_body.texture = load("res://Sprites/Pawns/Robit_Pawn-02-00.png")
		sprite_face.texture = load("res://Sprites/Pawns/Robit_Pawn-02-00-Face.png")
		sprite_loco.texture = load("res://Sprites/Pawns/Robit_Pawn-02-00-Loco.png")
	elif _player["pawn_num"] == 3:
		sprite_body.texture = load("res://Sprites/Pawns/Robit_Pawn-03-00.png")
		sprite_face.texture = load("res://Sprites/Pawns/Robit_Pawn-03-00-Face.png")
		sprite_loco.texture = load("res://Sprites/Pawns/Robit_Pawn-03-00-Loco.png")
	elif _player["pawn_num"] == 4:
		sprite_body.texture = load("res://Sprites/Pawns/Robit_Pawn-04-00.png")
		sprite_face.texture = load("res://Sprites/Pawns/Robit_Pawn-04-00-Face.png")
		sprite_loco.texture = load("res://Sprites/Pawns/Robit_Pawn-04-00-Loco.png")
	elif _player["pawn_num"] == 5:
		pass
	elif _player["pawn_num"] == 6:
		pass
	elif _player["pawn_num"] == 7:
		pass
	elif _player["pawn_num"] == 8:
		pass
	elif _player["pawn_num"] == 9:
		pass
	elif _player["pawn_num"] == 10:
		pass
	elif _player["pawn_num"] == 11:
		pass
	elif _player["pawn_num"] == 12:
		pass
	elif _player["pawn_num"] == 13:
		pass
	elif _player["pawn_num"] == 14:
		pass
	elif _player["pawn_num"] == 15:
		pass
	elif _player["pawn_num"] == 16:
		pass
	else:
		pass