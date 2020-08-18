extends VBoxContainer

onready var igb_01_player = $HBox_Player
onready var igb_01_player_num = $HBox_Player/Label_Player_Count
onready var igb_02_insert = $Label_Insert_Coin
onready var igb_03_press = $Label_Press_Start
onready var igb_04_select =$HBox_Select
onready var igb_04_select_count =$HBox_Select/Label_Select_Count
onready var igb_05_ready = $Label_Ready
onready var igb_06_coin = $HBox_Coin
onready var igb_06_coin_count = $HBox_Coin/Label_Coin_Count
onready var igb_07_dead = $Label_Dead
onready var igb_08_continue = $HBox_Continue
onready var igb_09_pawn_menu = $Pawn_Menu
onready var igb_10_game_box = $VBox_Game
onready var igb_10_game_box_player = $VBox_Game/HBox_Player
onready var igb_10_game_box_player_num = $VBox_Game/HBox_Player/Label_Player_Count
onready var igb_10_game_box_score = $VBox_Game/HBox_Score
onready var igb_10_game_box_score_count = $VBox_Game/HBox_Score/Label_Score_Count
onready var igb_10_game_box_nrg_box = $VBox_Game/HBox_for_NRG
onready var igb_10_game_box_nrg_bar = $VBox_Game/HBox_for_NRG/NRG_Bar
onready var igb_10_game_box_ammo = $VBox_Game/HBox_Ammo
onready var igb_10_game_box_ammo_count = $VBox_Game/HBox_Ammo/Label_Ammo_Count
onready var anim = $AnimationPlayer

var pri = 1
var sec = 0

func _ready():
	pass # Replace with function body.

func set_state(_pri:int, _sec:int):
	pri = _pri
	sec = _sec
	update_state(_pri)

func set_state_pri(_pri:int):
	pri = _pri
	update_state(_pri)

func set_state_sec(_sec:int):
	sec = _sec

func player_num_update(_num:int):
	igb_01_player_num.text = str(_num)
	igb_10_game_box_player_num.text = str(_num)
	igb_10_game_box_nrg_bar.self_modulate = Player_Stats.get_body_color(_num)

func ammo_update(_ammo:int):
	igb_10_game_box_ammo_count.text = str(_ammo)

func coin_count_update(_num:int):
	igb_06_coin_count.text = str(_num)

func score_update(_num:int):
	igb_10_game_box_score_count.text = str(_num)

func nrg_update(_num:int):
	igb_10_game_box_nrg_bar.value = _num

func update_state(_state:int):
	var state = _state
	all_out()
	if state != 10:
		igb_01_player.visible = true
		if state == 2:
			igb_02_insert.visible = true
		elif state == 3:
			igb_03_press.visible = true
		elif state == 4:
			igb_04_select.visible = true
		elif state == 5:
			igb_05_ready.visible = true
		elif state == 6:
			igb_06_coin.visible = true
		elif state == 7:
			igb_07_dead.visible = true
		elif state == 8:
			igb_08_continue.visible = true
		elif state == 9:
			igb_09_pawn_menu.visible = true
		elif state == 0:
			pass
		else:
			print("invalid state in hud_02 update state. State = ", state)
	else:
		igb_10_game_box.visible = true
	
func all_out():
	igb_01_player.visible = false
	igb_02_insert.visible = false
	igb_03_press.visible = false
	igb_04_select.visible = false
	igb_05_ready.visible = false
	igb_06_coin.visible = false
	igb_07_dead.visible = false
	igb_08_continue.visible = false
	igb_09_pawn_menu.visible = false
	igb_10_game_box.visible = false