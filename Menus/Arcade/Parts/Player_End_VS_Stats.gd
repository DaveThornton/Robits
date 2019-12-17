extends VBoxContainer

export var player_num = 0

onready var player = $HBox_Player/Label2.text
onready var score = $HBox_Score/Label2.text
onready var kills = $HBox_Kills/Label2.text
onready var deaths = $HBox_Deaths/Label2.text
onready var kdr = $HBox_KDR/Label2.text
onready var shots = $HBox_Shots/Label2.text
onready var hits = $HBox_Hits/Label2.text
onready var miss = $HBox_Miss/Label2.text
onready var place = $Place_Label.text

func _ready():
	pass # Replace with function body.

func set_player_num(_player):
	player_num = _player

func update():
	if player_num == 1:
		player = str(player_num)
		score = str(Player_Stats.p1["score"])
		kills = str(Player_Stats.p1["kills"])
		deaths = str(Player_Stats.p1["death"])
		kdr = str(Player_Stats.p1["kills"] / Player_Stats.p1["death"])
		shots = str(Player_Stats.p1["shot"])
		hits = str(Player_Stats.p1["hit"])
		miss = str(Player_Stats.p1["shot"] - Player_Stats.p1["hit"])
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#	in_play = false,
#	exist = false,
#	credit = 0,
#	kill = 0,
#	death = 0,
#	score = 0,
#	shot = 0,
#	hit = 0,
#	ammo = 0,
#	nrg = 100,
#	pawn_num = 0,