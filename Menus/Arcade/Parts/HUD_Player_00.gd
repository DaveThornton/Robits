extends VBoxContainer

onready var anim = $AnimationPlayer
onready var game_box = $VBox_In_Game
onready var player_num_ig = $VBox_In_Game/HBox_Player/Label_Player_Count
onready var ammo_count_ig = $VBox_In_Game/HBox_Ammo/Label_Ammo_Count
onready var coin_count_ig = $VBox_In_Game/HBox_Coin/Label_Coin_Count
onready var score_count_ig = $VBox_In_Game/HBox_Score/Label_Score_Count
onready var menu_box = $VBox_In_Menu
onready var player_num_im = $VBox_In_Menu/HBox_Player/Label_Player_Count
onready var coin_count_im = $VBox_In_Menu/HBox_Coin/Label_Coin_Count
onready var nrg_bar = $VBox_In_Game/HBox_for_NRG/NRG_Bar
onready var game_over_box = $VBox_Game_over
onready var game_over_stats = $VBox_Game_over/Player_End_VS_Stats
onready var player_num_count_go = $VBox_Game_over/HBox_Player/Label_Player_Count
onready var player_num_go = $VBox_Game_over/HBox_Player
onready var player_done_go = $VBox_Game_over/Label_Done

export var player_num = 0

var game_done = false

func _ready():
	set_player_num(player_num)

func reset():
	game_done = false
	in_menu()
	show_player()

func in_menu():
	game_over_box.visible = false
	game_box.visible = false
	menu_box.visible = true
#	anim.play("IN_MENU")

func in_game():
	game_over_box.visible = false
	game_box.visible = true
	menu_box.visible = false

func game_over():
	game_over_box.visible = true
	game_box.visible = false
	menu_box.visible = false
	game_over_stats.update()
	game_over_not_done()
	
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

func set_player_num(_num):
	player_num_ig.text = str(_num)
	nrg_bar.self_modulate = Player_Stats.get_body_color(_num)
	player_num_im.text = str(_num)
	player_num_count_go.text = str(_num)
	game_over_stats.set_player_num(_num)

func set_ammo_count(_amount):
	ammo_count_ig.text = str(_amount)

func set_coin_count(_amount):
	coin_count_ig.text = str(_amount)
	coin_count_im.text = str(_amount)

func set_score_count(_amount):
	score_count_ig.text = str(_amount)

func set_nrg_bar(_amount):
	nrg_bar.value = _amount

func set_place(_place):
	var _place_name = Player_Stats.get_place_name(_place)
	game_over_stats.set_place_text(_place_name)

func in_play():
	in_game()
	anim.play("IN_PLAY")

func insert_coin():
	anim.play("INSERT_COIN")
#	timer.wait_time = time_out
#	timer.start()

func player_ready():
	anim.play("PLAYER_READY")

func player_select():
	anim.play("PLAYER_SELECT")

func coin_up():
	anim.play("COIN_UP")

func press_start():
	anim.play("PRESS_START")

func show_player():
	anim.play("PLAYER")
