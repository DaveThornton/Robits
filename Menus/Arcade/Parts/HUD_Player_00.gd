extends VBoxContainer

onready var in_game_over_box = $VBox_Game_Over# mode 0
onready var in_menu_box = $VBox_In_Menu#        mode 1
onready var in_game_box = $VBox_In_Game#        mode 2
onready var in_score_box = $VBox_In_Score#      mode 3
onready var pawn_menu = $VBox_In_Game/Pawn_Menu
export var player_num = 0


func _ready(): set_player_num(player_num)

func reset(): in_menu()
 
func update_state(_state):
	var mode = get_parent().mode
	var pri = _state["pri"]
	var sec = _state["sec"]
	if mode == 0:
		if Game.mode > 0:
			game_over()
	elif mode == 1:
		in_menu()
		in_menu_box.set_state(pri, sec)
	elif mode == 2:
		in_game()
		in_game_box.set_state(pri, sec)
	elif mode == 3:
#		print("mode 3 in hud player 00")
		in_score()
		in_score_box.set_state(pri, sec)

func game_over():
	in_game_over_box.visible = true
	in_menu_box.visible = false
	in_game_box.visible = false
	in_score_box.visible = false
	in_game_over_box.start()

func in_menu():
	in_game_over_box.visible = false
	in_menu_box.visible = true
	in_game_box.visible = false
	in_score_box.visible = false

func in_game():
	in_game_over_box.visible = false
	in_menu_box.visible = false
	in_game_box.visible = true
	in_score_box.visible = false

func in_score():
	in_game_over_box.visible = false
	in_menu_box.visible = false
	in_game_box.visible = false
	in_score_box.visible = true

func set_player_num(_num:int):
	in_game_box.player_num_update(_num)
	in_menu_box.player_num_update(_num)
	in_score_box.player_num_update(_num)
	in_game_over_box.player_num_update(_num)

func set_ammo_count(_amount:int):
	in_game_box.ammo_update(_amount)

func set_coin_count(_amount:int):
	in_game_box.coin_count_update(_amount)
	in_menu_box.coin_count_update(_amount)

func set_lives(_amount:int): in_game_box.lives_update()

func set_score_count(_amount:int): in_game_box.score_update(_amount)

func set_nrg_bar(_amount:int): in_game_box.nrg_update(_amount)

func set_place(_place): in_game_over_box.set_place(_place)

func show_lives(_show:bool): in_game_box.show_lives(_show)

func set_continue(_continue:bool): in_game_box.set_continue(_continue)

func parent_in_game(): get_parent().in_game_player(player_num)

func go_up(): in_score_box.up()

func go_down(): in_score_box.down()

func go_back(): in_score_box.back()

func go_select(): in_score_box.select()

func go_left(): pawn_menu.go_left()

func go_right(): pawn_menu.go_right()

func go_start():
	pawn_menu.go_start()
	return pawn_menu.pos

func game_over_done(): in_game_over_box.game_over_done()

func game_over_not_done(): in_game_over_box.game_over_not_done()

func pawn_menu_vis(_vis): pawn_menu.visible = _vis
