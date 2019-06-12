extends HBoxContainer

#onready var p1_player_label = $VBoxContainer1/Label_player_1
#onready var p2_player_label = $VBoxContainer2/Label_player_2
#onready var p3_player_label = $VBoxContainer3/Label_player_3
#onready var p4_player_label = $VBoxContainer4/Label_player_4
#onready var p5_player_label = $VBoxContainer5/Label_player_5

onready var p1_box = $VBoxContainer1
onready var p2_box = $VBoxContainer2
onready var p3_box = $VBoxContainer3
onready var p4_box = $VBoxContainer4
onready var p5_box = $VBoxContainer5
onready var p6_box = $VBoxContainer6
onready var p7_box = $VBoxContainer7
onready var p8_box = $VBoxContainer8

onready var p1_ready_label = $VBoxContainer1/Label_ready1
onready var p2_ready_label = $VBoxContainer2/Label_ready2
onready var p3_ready_label = $VBoxContainer3/Label_ready3
onready var p4_ready_label = $VBoxContainer4/Label_ready4
onready var p5_ready_label = $VBoxContainer5/Label_ready5
onready var p6_ready_label = $VBoxContainer6/Label_ready6
onready var p7_ready_label = $VBoxContainer7/Label_ready7
onready var p8_ready_label = $VBoxContainer8/Label_ready8

onready var p1_select_label = $VBoxContainer1/Label_Select1
onready var p2_select_label = $VBoxContainer2/Label_Select2
onready var p3_select_label = $VBoxContainer3/Label_Select3
onready var p4_select_label = $VBoxContainer4/Label_Select4
onready var p5_select_label = $VBoxContainer5/Label_Select5
onready var p6_select_label = $VBoxContainer6/Label_Select6
onready var p7_select_label = $VBoxContainer7/Label_Select7
onready var p8_select_label = $VBoxContainer8/Label_Select8

onready var p1_start_label = $VBoxContainer1/Label_press_start1
onready var p2_start_label = $VBoxContainer2/Label_press_start2
onready var p3_start_label = $VBoxContainer3/Label_press_start3
onready var p4_start_label = $VBoxContainer4/Label_press_start4
onready var p5_start_label = $VBoxContainer5/Label_press_start5
onready var p6_start_label = $VBoxContainer6/Label_press_start6
onready var p7_start_label = $VBoxContainer7/Label_press_start7
onready var p8_start_label = $VBoxContainer8/Label_press_start8

var num_of_players = 8

func _ready():
	num_of_players = get_tree().get_current_scene().how_many_players
	print(get_tree().get_current_scene().how_many_players, " in arcade bottom")
	print(num_of_players, " in arcade bottom")
	set_players()
	
func change_label( _player, state):
	if _player == 1:
		if state == 1:
			p1_ready_label.visible = true
			p1_select_label.visible = false
			p1_start_label.visible = false
		elif state == 2:
			p1_ready_label.visible = false
			p1_select_label.visible = true
			p1_start_label.visible = false
		elif state == 3:
			p1_ready_label.visible = false
			p1_select_label.visible = false
			p1_start_label.visible = true
		elif state == 4:
			p1_ready_label.visible = false
			p1_select_label.visible = false
			p1_start_label.visible = false

	elif _player == 2:
		if state == 1:
			p2_ready_label.visible = true
			p2_select_label.visible = false
			p2_start_label.visible = false
		elif state == 2:
			p2_ready_label.visible = false
			p2_select_label.visible = true
			p2_start_label.visible = false
		elif state == 3:
			p2_ready_label.visible = false
			p2_select_label.visible = false
			p2_start_label.visible = true
		elif state == 4:
			p2_ready_label.visible = false
			p2_select_label.visible = false
			p2_start_label.visible = false
	elif _player == 3:
		if state == 1:
			p3_ready_label.visible = true
			p3_select_label.visible = false
			p3_start_label.visible = false
		elif state == 2:
			p3_ready_label.visible = false
			p3_select_label.visible = true
			p3_start_label.visible = false
		elif state == 3:
			p3_ready_label.visible = false
			p3_select_label.visible = false
			p3_start_label.visible = true
		elif state == 4:
			p3_ready_label.visible = false
			p3_select_label.visible = false
			p3_start_label.visible = false
	elif _player ==4:
		if state == 1:
			p4_ready_label.visible = true
			p4_select_label.visible = false
			p4_start_label.visible = false
		elif state == 2:
			p4_ready_label.visible = false
			p4_select_label.visible = true
			p4_start_label.visible = false
		elif state == 3:
			p4_ready_label.visible = false
			p4_select_label.visible = false
			p4_start_label.visible = true
		elif state == 4:
			p4_ready_label.visible = false
			p4_select_label.visible = false
			p4_start_label.visible = false
	elif _player == 5:
		if state == 1:
			p5_ready_label.visible = true
			p5_select_label.visible = false
			p5_start_label.visible = false
		elif state == 2:
			p5_ready_label.visible = false
			p5_select_label.visible = true
			p5_start_label.visible = false
		elif state == 3:
			p5_ready_label.visible = false
			p5_select_label.visible = false
			p5_start_label.visible = true
		elif state == 4:
			p5_ready_label.visible = false
			p5_select_label.visible = false
			p5_start_label.visible = false
	elif _player == 6:
		if state == 1:
			p6_ready_label.visible = true
			p6_select_label.visible = false
			p6_start_label.visible = false
		elif state == 2:
			p6_ready_label.visible = false
			p6_select_label.visible = true
			p6_start_label.visible = false
		elif state == 3:
			p6_ready_label.visible = false
			p6_select_label.visible = false
			p6_start_label.visible = true
		elif state == 4:
			p6_ready_label.visible = false
			p6_select_label.visible = false
			p6_start_label.visible = false
	elif _player == 7:
		if state == 1:
			p7_ready_label.visible = true
			p7_select_label.visible = false
			p7_start_label.visible = false
		elif state == 2:
			p7_ready_label.visible = false
			p7_select_label.visible = true
			p7_start_label.visible = false
		elif state == 3:
			p7_ready_label.visible = false
			p7_select_label.visible = false
			p7_start_label.visible = true
		elif state == 4:
			p7_ready_label.visible = false
			p7_select_label.visible = false
			p7_start_label.visible = false
	elif _player == 8:
		if state == 1:
			p8_ready_label.visible = true
			p8_select_label.visible = false
			p8_start_label.visible = false
		elif state == 2:
			p8_ready_label.visible = false
			p8_select_label.visible = true
			p8_start_label.visible = false
		elif state == 3:
			p8_ready_label.visible = false
			p8_select_label.visible = false
			p8_start_label.visible = true
		elif state == 4:
			p8_ready_label.visible = false
			p8_select_label.visible = false
			p8_start_label.visible = false
	else:
		print("error in bottom hud invald player in change label")

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