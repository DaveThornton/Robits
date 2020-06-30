extends VBoxContainer

onready var game_over_stats = $Player_End_VS_Stats
onready var player_num_count = $HBox_Player/Label_Player_Count
onready var player_num_go = $HBox_Player
onready var player_done_go = $Label_Done

var game_done = false
var player = 0

func start():
	if Player_Stats.get_in_game(player):
		game_over_not_done()
		game_over_stats.update()
	else:
		not_in_game()

func player_num_update(_num):
	player = _num
	player_num_count = str(_num)
	game_over_stats.set_player_num(_num)

func set_place(_place):
	var _place_name = Player_Stats.get_place_name(_place)
	game_over_stats.set_place_text(_place_name)

func not_in_game():
	player_done_go.visible = false
	player_num_go.visible = false
	game_over_stats.visible = false

func game_over_done():
	player_done_go.visible = true
	player_num_go.visible = true
	game_over_stats.visible = false
	game_done = true

func game_over_not_done():
	player_done_go.visible = false
	player_num_go.visible = false
	game_over_stats.visible = true
	game_done = false
