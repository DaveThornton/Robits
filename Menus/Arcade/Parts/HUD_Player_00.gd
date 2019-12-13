extends VBoxContainer

onready var anim = $AnimationPlayer
onready var timer = $Timer
onready var game_box = $VBox_In_Game
onready var player_num_ig = $VBox_In_Game/HBox_Player/Label_Player_Count
onready var ammo_count_ig = $VBox_In_Game/HBox_Ammo/Label_Ammo_Count
onready var coin_count_ig = $VBox_In_Game/HBox_Coin/Label_Coin_Count
onready var score_count_ig = $VBox_In_Game/HBox_Score/Label_Score_Count
onready var menu_box = $VBox_In_Menu
onready var player_num_im = $VBox_In_Menu/HBox_Player/Label_Player_Count
onready var coin_count_im = $VBox_In_Menu/HBox_Coin/Label_Coin_Count
onready var nrg_bar =$VBox_In_Game/NRG_Bar

export var time_out = 5
export var player_num = 0

func _ready():
	set_player_num(player_num)

func in_menu():
	game_box.visible = false
	menu_box.visible = true
#	anim.play("IN_MENU")

func in_game():
	game_box.visible = true
	menu_box.visible = false


func set_player_num(_num):
	player_num_ig.text = str(_num)
	player_num_im.text = str(_num)

func set_ammo_count(_amount):
	ammo_count_ig.text = str(_amount)

func set_coin_count(_amount):
	coin_count_ig.text = str(_amount)
	coin_count_im.text = str(_amount)

func set_score_count(_amount):
	score_count_ig.text = str(_amount)

func set_nrg_bar(_amount):
	nrg_bar.value = _amount

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

func _on_Timer_timeout():
	show_player()
