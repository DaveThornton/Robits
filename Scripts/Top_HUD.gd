extends MarginContainer

onready var kills_p1 = $VBoxContainer/HBoxContainer/VBoxContainer1/HBoxContainer/num_of_kills_p1
onready var kills_p2 = $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/num_of_kills_p2
onready var kills_p3 = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxContainer/num_of_kills_p3
onready var kills_p4 = $VBoxContainer/HBoxContainer/VBoxContainer4/HBoxContainer/num_of_kills_p4
onready var kills_p5 = $VBoxContainer/HBoxContainer/VBoxContainer5/HBoxContainer/num_of_kills_p5
onready var kills_p6 = $VBoxContainer/HBoxContainer/VBoxContainer6/HBoxContainer/num_of_kills_p6
onready var kills_p7 = $VBoxContainer/HBoxContainer/VBoxContainer7/HBoxContainer/num_of_kills_p7
onready var kills_p8 = $VBoxContainer/HBoxContainer/VBoxContainer8/HBoxContainer/num_of_kills_p8

onready var ammo_count_p1 = $VBoxContainer/HBoxContainer/VBoxContainer1/HBoxAmmo/Ammo_counter
onready var ammo_count_p2 = $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxAmmo/Ammo_counter
onready var ammo_count_p3 = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxAmmo/Ammo_counter
onready var ammo_count_p4 = $VBoxContainer/HBoxContainer/VBoxContainer4/HBoxAmmo/Ammo_counter
onready var ammo_count_p5 = $VBoxContainer/HBoxContainer/VBoxContainer5/HBoxAmmo/Ammo_counter
onready var ammo_count_p6 = $VBoxContainer/HBoxContainer/VBoxContainer6/HBoxAmmo/Ammo_counter
onready var ammo_count_p7 = $VBoxContainer/HBoxContainer/VBoxContainer7/HBoxAmmo/Ammo_counter
onready var ammo_count_p8 = $VBoxContainer/HBoxContainer/VBoxContainer8/HBoxAmmo/Ammo_counter

#onready var kills_box_1 = $VBoxContainer/HBoxContainer/VBoxContainer1/HBoxContainer
#onready var kills_box_2 = $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer
#onready var kills_box_3 = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxContainer 
#onready var kills_box_4 = $VBoxContainer/HBoxContainer/VBoxContainer4/HBoxContainer 
#onready var kills_box_5 = $VBoxContainer/HBoxContainer/VBoxContainer5/HBoxContainer 
#onready var kills_box_6 = $VBoxContainer/HBoxContainer/VBoxContainer6/HBoxContainer 
#onready var kills_box_7 = $VBoxContainer/HBoxContainer/VBoxContainer7/HBoxContainer 
#onready var kills_box_8 = $VBoxContainer/HBoxContainer/VBoxContainer8/HBoxContainer 

#onready var ammo_box_1 = $VBoxContainer/HBoxContainer/VBoxContainer1/HBoxAmmo
#onready var ammo_box_2 = $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxAmmo
#onready var ammo_box_3 = $VBoxContainer/HBoxContainer/VBoxContainer3/HBoxAmmo
#onready var ammo_box_4 = $VBoxContainer/HBoxContainer/VBoxContainer4/HBoxAmmo
#onready var ammo_box_5 = $VBoxContainer/HBoxContainer/VBoxContainer5/HBoxAmmo
#onready var ammo_box_6 = $VBoxContainer/HBoxContainer/VBoxContainer6/HBoxAmmo
#onready var ammo_box_7 = $VBoxContainer/HBoxContainer/VBoxContainer7/HBoxAmmo
#onready var ammo_box_8 = $VBoxContainer/HBoxContainer/VBoxContainer8/HBoxAmmo

onready var nrg_1 = $VBoxContainer/HBoxContainer/VBoxContainer1/NRG_bar_p1
onready var nrg_2 = $VBoxContainer/HBoxContainer/VBoxContainer2/NRG_bar_p2
onready var nrg_3 = $VBoxContainer/HBoxContainer/VBoxContainer3/NRG_bar_p3 
onready var nrg_4 = $VBoxContainer/HBoxContainer/VBoxContainer4/NRG_bar_p4 
onready var nrg_5 = $VBoxContainer/HBoxContainer/VBoxContainer5/NRG_bar_p5
onready var nrg_6 = $VBoxContainer/HBoxContainer/VBoxContainer6/NRG_bar_p6 
onready var nrg_7 = $VBoxContainer/HBoxContainer/VBoxContainer7/NRG_bar_p7 
onready var nrg_8 = $VBoxContainer/HBoxContainer/VBoxContainer8/NRG_bar_p8

onready var hud_p1 = $VBoxContainer/HBoxContainer/VBoxContainer1 
onready var hud_p2 = $VBoxContainer/HBoxContainer/VBoxContainer2
onready var hud_p3 = $VBoxContainer/HBoxContainer/VBoxContainer3  
onready var hud_p4 = $VBoxContainer/HBoxContainer/VBoxContainer4 
onready var hud_p5 = $VBoxContainer/HBoxContainer/VBoxContainer5 
onready var hud_p6 = $VBoxContainer/HBoxContainer/VBoxContainer6 
onready var hud_p7 = $VBoxContainer/HBoxContainer/VBoxContainer7 
onready var hud_p8 = $VBoxContainer/HBoxContainer/VBoxContainer8 

#onready var start_label_1 = $VBoxContainer/HBoxContainer/VBoxContainer1/Press_Start_label1
#onready var start_label_2 = $VBoxContainer/HBoxContainer/VBoxContainer2/Press_Start_label2
#onready var start_label_3 = $VBoxContainer/HBoxContainer/VBoxContainer3/Press_Start_label3 
#onready var start_label_4 = $VBoxContainer/HBoxContainer/VBoxContainer4/Press_Start_label4 
#onready var start_label_5 = $VBoxContainer/HBoxContainer/VBoxContainer5/Press_Start_label5
#onready var start_label_6 = $VBoxContainer/HBoxContainer/VBoxContainer6/Press_Start_label6 
#onready var start_label_7 = $VBoxContainer/HBoxContainer/VBoxContainer7/Press_Start_label7 
#onready var start_label_8 = $VBoxContainer/HBoxContainer/VBoxContainer8/Press_Start_label8

onready var winners_label = $VBoxContainer/Winners_Label

#var p1_int_kills = 0
#var p2_int_kills = 0
#var p3_int_kills = 0
#var p4_int_kills = 0
#var p5_int_kills = 0
#var p6_int_kills = 0
#var p7_int_kills = 0
#var p8_int_kills = 0

func _ready():
	var h = get_parent()
	h.connect("game_over", self , "game_over")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func init():
	kills_p1.text = "0"
	kills_p2.text = "0"
	kills_p3.text = "0"
	kills_p4.text = "0"
	kills_p5.text = "0"
	kills_p6.text = "0"
	kills_p7.text = "0"
	kills_p8.text = "0"
	get_parent().update_hud()
	
	
func game_over(_winner):
	winners_label.visible = true
	winners_label.text = str("player ",_winner, " has won the game sucka!!")
	print("HUD knows player ",_winner, " has won the game")

func change_player_score(_player, _score):
	if _player == 1:
		kills_p1.text = str(_score)
	elif _player == 2:
		kills_p2.text = str(_score)
	elif _player == 3:
		kills_p3.text = str(_score)
	elif _player == 4:
		kills_p4.text = str(_score)
	elif _player == 5:
		kills_p5.text = str(_score)
	elif _player == 6:
		kills_p6.text = str(_score)
	elif _player == 7:
		kills_p7.text = str(_score)
	elif _player == 8:
		kills_p8.text = str(_score)

func update_player_hud_vis(_p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8):
	hud_p1.visible = _p1
#	kills_box_1.visible = _p1
#	nrg_1.visible = _p1
#	start_label_1.visible = !_p1
#	ammo_box_1.visible  = _p1
	
	hud_p2.visible = _p2
#	kills_box_2.visible = _p2
#	nrg_2.visible = _p2
#	start_label_2.visible = !_p2
#	ammo_box_2.visible = _p2
	
	hud_p3.visible = _p3
#	kills_box_3.visible = _p3
#	nrg_3.visible = _p3
#	start_label_3.visible = !_p3
#	ammo_box_3.visible = _p3
	
	hud_p4.visible = _p4
#	kills_box_4.visible = _p4
#	nrg_4.visible = _p4
#	start_label_4.visible = !_p4
#	ammo_box_4.visible = _p4
	
	hud_p5.visible = _p5
#	kills_box_5.visible = _p5
#	nrg_5.visible = _p5
#	start_label_5.visible = !_p5
#	ammo_box_5.visible = _p5
	
	hud_p6.visible = _p6
#	kills_box_6.visible = _p6
#	nrg_6.visible = _p6
#	start_label_6.visible = !_p6
#	ammo_box_6.visible = _p6
	
	hud_p7.visible = _p7
#	kills_box_7.visible = _p7
#	nrg_7.visible = _p7
#	start_label_7.visible = !_p7
#	ammo_box_7.visible = _p7
	
	hud_p8.visible = _p8
#	kills_box_8.visible = _p8
#	nrg_8.visible = _p8
#	start_label_8.visible = !_p8
#	ammo_box_8.visible = _p8

func update_p1_nrg(_num):
	nrg_1.value = _num
func update_p2_nrg(_num):
	nrg_2.value = _num
func update_p3_nrg(_num):
	nrg_3.value = _num
func update_p4_nrg(_num):
	nrg_4.value = _num
func update_p5_nrg(_num):
	nrg_5.value = _num
func update_p6_nrg(_num):
	nrg_6.value = _num
func update_p7_nrg(_num):
	nrg_7.value = _num
func update_p8_nrg(_num):
	nrg_8.value = _num

func update_p1_ammo(_num):
	ammo_count_p1.text = str(_num)
func update_p2_ammo(_num):
	ammo_count_p2.text = str(_num)
func update_p3_ammo(_num):
	ammo_count_p3.text = str(_num)
func update_p4_ammo(_num):
	ammo_count_p4.text = str(_num)
func update_p5_ammo(_num):
	ammo_count_p5.text = str(_num)
func update_p6_ammo(_num):
	ammo_count_p6.text = str(_num)
func update_p7_ammo(_num):
	ammo_count_p7.text = str(_num)
func update_p8_ammo(_num):
	ammo_count_p8.text = str(_num)