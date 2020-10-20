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
onready var igb_08_continue_count = $HBox_Continue/Label_Continue_Count
onready var igb_09_pawn_menu = $Pawn_Menu
onready var igb_10_game_box = $VBox_Game
onready var igb_10_game_box_player = $VBox_Game/HBox_Player
onready var igb_10_game_box_player_num = $VBox_Game/HBox_Player/Label_Player_Count
onready var igb_10_game_box_lives = $VBox_Game/HBox_Lives
onready var igb_10_game_box_lives_count = $VBox_Game/HBox_Lives/Label_Lives_Count
onready var igb_10_game_box_score = $VBox_Game/HBox_Score
onready var igb_10_game_box_score_count = $VBox_Game/HBox_Score/Label_Score_Count
onready var igb_10_game_box_nrg_box = $VBox_Game/HBox_for_NRG
onready var igb_10_game_box_nrg_bar = $VBox_Game/HBox_for_NRG/NRG_Bar
onready var igb_10_game_box_ammo = $VBox_Game/HBox_Ammo
onready var igb_10_game_box_ammo_count = $VBox_Game/HBox_Ammo/Label_Ammo_Count
onready var igb_10_game_box_coin = $VBox_Game/HBox_Coin/Label_Coin_Text
onready var igb_10_game_box_coin_count = $VBox_Game/HBox_Coin/Label_Coin_Count
onready var igb_10_game_box_coin2 = $VBox_Game/HBox_Coin/Label_Coin_Text2

onready var igb_11_name_box = $VBox_Name 
onready var igb_11_name_box_select = $VBox_Name
onready var igb_11_name_box_score = $VBox_Name

onready var anim = $AnimationPlayer
onready var anim_game_box = $VBox_Game/AnimationPlayer

var pri = 1
var sec = 0
var state = 0
var player = 0
var continue_started = false
var continue_count_num = 10

func _ready():
	var con = self.get_tree().get_current_scene().connect("second", self, "continue_count")
	if con != 0:
		print("error on connecting second to second in Thwomp")

func set_state(_pri:int, _sec:int):
	pri = _pri
	sec = _sec
	update_state(_pri)

func set_state_pri(_pri:int):
	pri = _pri
	update_state(_pri)

func set_state_sec(_sec:int): sec = _sec

func player_num_update(_num:int):
	player = _num
	igb_01_player_num.text = str(_num)
	igb_10_game_box_player_num.text = str(_num)
	igb_10_game_box_nrg_bar.self_modulate = Player_Stats.get_body_color(_num)

func coin_count_update(_num:int):
	igb_06_coin_count.text = str(_num)
	igb_10_game_box_coin_count.text = str(_num)
	anim_game_box.play("Coin_Up")

func ammo_update(_ammo:int): igb_10_game_box_ammo_count.text = str(_ammo)

func lives_update(_num:int): igb_10_game_box_lives_count.text = str(_num)

func score_update(_num:int): igb_10_game_box_score_count.text = str(_num)

func nrg_update(_num:int): igb_10_game_box_nrg_bar.value = _num

func continue_update(_num:int): igb_08_continue_count.text = str(_num)

func show_lives(_show:bool): igb_10_game_box_lives.visible = _show

func set_continue(_continue):
	continue_started = _continue
	if _continue:
		Player_Stats.set_continuing(player, true)
		Player_Stats.set_in_game(player, false)
#		Controllers.get_controller(player)
#		continue_count()
	else:
#		update_state(10)
		continue_count_num = 10
		print("dont know set_continue false in hud 02 in game")

func continue_count():
	if continue_started:
		update_state(8)
#		Player_Stats.set_continuing(player, true)
		if continue_count_num > 0:
			continue_count_num -= 1
			igb_08_continue_count.text = str(continue_count_num)
		elif continue_count_num <= 0:
			continue_started = false
#			print(Player_Stats.get_in_play(player), "<------in play --- in game------>",Player_Stats.get_in_game(player))
			Player_Stats.set_in_play(player,false) 
			Player_Stats.set_continuing(player, false)
#			Player_Stats.reset_player(player)
#			Player_Stats.set_can_spawn(player, true)
			Game.check_over()
			print("end continue if game over?  ", Game.over)
			if !Game.over:
				if High_Score.is_score_high(Player_Stats.get_score(player)):
					print("trying to add name to high scores in game lets see")
					
					
					
					
					pass
				else:
					Player_Stats.reset_player(player)
			else:
#				print("call high scores in hud after continue runs out")
				High_Score.set_visible(true)
			continue_count_num = 10
#			print("need to do somthing when continue runs out hud 02 vbox in game")
			

func update_state(_state:int):
	if !continue_count_num < 10:
		all_out()
		if _state != 10:
			igb_01_player.visible = true
			if _state == 2:
				igb_02_insert.visible = true
			elif _state == 3:
				igb_03_press.visible = true
			elif _state == 4:
				igb_04_select.visible = true
			elif _state == 5:
				igb_05_ready.visible = true
			elif _state == 6:
				igb_06_coin.visible = true
			elif _state == 7:
				igb_07_dead.visible = true
			elif _state == 8:
				igb_08_continue.visible = true
			elif _state == 9:
				igb_09_pawn_menu.visible = true
			elif _state == 0:
				pass
			else:
				print("invalid state in hud_02 update state. State = ", state)
		else:
			igb_10_game_box.visible = true
		state = _state
	
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
