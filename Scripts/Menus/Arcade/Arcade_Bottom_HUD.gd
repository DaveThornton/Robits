extends HBoxContainer

onready var p1_player_label = $VBoxContainer1/Label_player_1
onready var p2_player_label = $VBoxContainer2/Label_player_2
onready var p3_player_label = $VBoxContainer3/Label_player_3
onready var p4_player_label = $VBoxContainer4/Label_player_4
onready var p5_player_label = $VBoxContainer5/Label_player_5
onready var p6_player_label = $VBoxContainer6/Label_player_6
onready var p7_player_label = $VBoxContainer7/Label_player_7
onready var p8_player_label = $VBoxContainer8/Label_player_8

onready var p1_box = $VBoxContainer1
onready var p2_box = $VBoxContainer2
onready var p3_box = $VBoxContainer3
onready var p4_box = $VBoxContainer4
onready var p5_box = $VBoxContainer5
onready var p6_box = $VBoxContainer6
onready var p7_box = $VBoxContainer7
onready var p8_box = $VBoxContainer8

onready var p1_start_label = $VBoxContainer1/Label_press_start
onready var p2_start_label = $VBoxContainer2/Label_press_start
onready var p3_start_label = $VBoxContainer3/Label_press_start
onready var p4_start_label = $VBoxContainer4/Label_press_start
onready var p5_start_label = $VBoxContainer5/Label_press_start
onready var p6_start_label = $VBoxContainer6/Label_press_start
onready var p7_start_label = $VBoxContainer7/Label_press_start
onready var p8_start_label = $VBoxContainer8/Label_press_start

onready var p1_insert_Label = $VBoxContainer1/Label_insert_coin
onready var p2_insert_Label = $VBoxContainer2/Label_insert_coin
onready var p3_insert_Label = $VBoxContainer3/Label_insert_coin
onready var p4_insert_Label = $VBoxContainer4/Label_insert_coin
onready var p5_insert_Label = $VBoxContainer5/Label_insert_coin
onready var p6_insert_Label = $VBoxContainer6/Label_insert_coin
onready var p7_insert_Label = $VBoxContainer7/Label_insert_coin
onready var p8_insert_Label = $VBoxContainer8/Label_insert_coin

var num_of_players = 8

func _ready():
	num_of_players = Settings.max_num_of_player
#	print(Settings.max_num_of_player, " in arcade bottom")
#	print(num_of_players, " in arcade bottom")
	set_players()
#TODO fix label system its all fucked up needs lots of work?
func change_label( _player, state):
	if _player == 1:
		if state == 1:
			p1_insert_Label.visible = true
			p1_start_label.visible = false
			p1_player_label.visible = false
#			p1_ready_label.visible = false
		elif state == 2:
			p1_insert_Label.visible = false
			p1_start_label.visible = true
			p1_player_label.visible = false
#			p1_ready_label.visible = false
		elif state == 3:
			p1_insert_Label.visible = false
			p1_start_label.visible = false
			p1_player_label.visible = true
#			p1_ready_label.visible = false
		elif state == 4:
			p1_insert_Label.visible = false
			p1_start_label.visible = false
			p1_player_label.visible = false
#			p1_ready_label.visible = true
	elif _player == 2:
		if state == 1:
			p2_insert_Label.visible = true
			p2_start_label.visible = false
			p2_player_label.visible = false
		elif state == 2:
			p2_insert_Label.visible = false
			p2_start_label.visible = true
			p2_player_label.visible = false
		elif state == 3:
			p2_insert_Label.visible = false
			p2_start_label.visible = false
			p2_player_label.visible = true
		elif state == 4:
			p2_insert_Label.visible = false
			p2_start_label.visible = false
			p2_player_label.visible = false
	elif _player == 3:
		if state == 1:
			p3_insert_Label.visible = true
			p3_start_label.visible = false
			p3_player_label.visible = false
		elif state == 2:
			p3_insert_Label.visible = false
			p3_start_label.visible = true
			p3_player_label.visible = false
		elif state == 3:
			p3_insert_Label.visible = false
			p3_start_label.visible = false
			p3_player_label.visible = true
		elif state == 4:
			p3_insert_Label.visible = false
			p3_start_label.visible = false
			p3_player_label.visible = false
	elif _player ==4:
		if state == 1:
			p4_insert_Label.visible = true
			p4_start_label.visible = false
			p4_player_label.visible = false
		elif state == 2:
			p4_insert_Label.visible = false
			p4_start_label.visible = true
			p4_player_label.visible = false
		elif state == 3:
			p4_insert_Label.visible = false
			p4_start_label.visible = false
			p4_player_label.visible = true
		elif state == 4:
			p4_insert_Label.visible = false
			p4_start_label.visible = false
			p4_player_label.visible = false
	elif _player == 5:
		if state == 1:
			p5_insert_Label.visible = true
			p5_start_label.visible = false
			p5_player_label.visible = false
		elif state == 2:
			p5_insert_Label.visible = false
			p5_start_label.visible = true
			p5_player_label.visible = false
		elif state == 3:
			p5_insert_Label.visible = false
			p5_start_label.visible = false
			p5_player_label.visible = true
		elif state == 4:
			p5_insert_Label.visible = false
			p5_start_label.visible = false
			p5_player_label.visible = false
	elif _player == 6:
		if state == 1:
			p6_insert_Label.visible = true
			p6_start_label.visible = false
			p6_player_label.visible = false
		elif state == 2:
			p6_insert_Label.visible = false
			p6_start_label.visible = true
			p6_player_label.visible = false
		elif state == 3:
			p6_insert_Label.visible = false
			p6_start_label.visible = false
			p6_player_label.visible = true
		elif state == 4:
			p6_insert_Label.visible = false
			p6_start_label.visible = false
			p6_player_label.visible = false
	elif _player == 7:
		if state == 1:
			p7_insert_Label.visible = true
			p7_start_label.visible = false
			p7_player_label.visible = false
		elif state == 2:
			p7_insert_Label.visible = false
			p7_start_label.visible = true
			p7_player_label.visible = false
		elif state == 3:
			p7_insert_Label.visible = false
			p7_start_label.visible = false
			p7_player_label.visible = true
		elif state == 4:
			p7_insert_Label.visible = false
			p7_start_label.visible = false
			p7_player_label.visible = false
	elif _player == 8:
		if state == 1:
			p8_insert_Label.visible = true
			p8_start_label.visible = false
			p8_player_label.visible = false
		elif state == 2:
			p8_insert_Label.visible = false
			p8_start_label.visible = true
			p8_player_label.visible = false
		elif state == 3:
			p8_insert_Label.visible = false
			p8_start_label.visible = false
			p8_player_label.visible = true
		elif state == 4:
			p8_insert_Label.visible = false
			p8_start_label.visible = false
			p8_player_label.visible = false

func set_players():
	if num_of_players == 2:
		set_boxes(true, true, false, false, false, false, false, false)
	elif num_of_players == 3:
		set_boxes(true, true, true, false, false, false, false, false)
	elif num_of_players == 4:
		set_boxes(true, true, true, true, false, false, false, false)
	elif num_of_players == 5:
		set_boxes(true, true, true, true, true, false, false, false)
	elif num_of_players == 6:
		set_boxes(true, true, true, true, true, true, false, false)
	elif num_of_players == 7:
		set_boxes(true, true, true, true, true, true, true, false)
	elif num_of_players == 8:
		set_boxes(true, true, true, true, true, true, true, true)
	else:
		print("error in bottom hud invald player number in set players")


func set_boxes(_1, _2, _3, _4, _5, _6, _7, _8):
	p1_box.visible = _1
	p2_box.visible = _2
	p3_box.visible = _3
	p4_box.visible = _4
	p5_box.visible = _5
	p6_box.visible = _6
	p7_box.visible = _7
	p8_box.visible = _8