extends VBoxContainer

onready var imb_01_player = $HBox_Player
onready var imb_01_player_num = $HBox_Player/Label_Player_Count
onready var imb_02_insert = $Label_Insert_Coin
onready var imb_03_press = $Label_Press_Start
onready var imb_04_select =$HBox_Select
onready var imb_04_select_count =$HBox_Select/Label_Select_Count
onready var imb_05_ready = $Label_Ready
onready var imb_06_coin = $HBox_Coin
onready var imb_06_coin_count = $HBox_Coin/Label_Coin_Count

onready var anim = $AnimationPlayer

var pri = 1
var sec = 0
var state = 0

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
	imb_01_player_num.text = str(_num)

func coin_count_update(_num:int):
	imb_06_coin_count.text = str(_num)
	update_state(6)

func update_state(_state:int):
	print("update state called in hud 01 vbox in menu")
#	anim.stop()
	all_out()
	imb_01_player.visible = true
	if _state == 2:
		imb_02_insert.visible = true
	elif _state == 3:
		imb_03_press.visible = true
	elif _state == 4:
		imb_04_select.visible = true
	elif _state == 5:
		imb_05_ready.visible = true
	elif _state == 6:
		anim.play("CoinUp")
	elif _state == 0:
		pass
	else:
		print("invalid state in hud_01 update state. State = ", _state)
	state = _state

func all_out():
	imb_01_player.visible = false
	imb_02_insert.visible = false
	imb_03_press.visible = false
	imb_04_select.visible = false
	imb_05_ready.visible = false
#	imb_06_coin.visible = false
