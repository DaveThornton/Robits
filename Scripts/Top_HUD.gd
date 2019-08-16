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

onready var winners_label = $VBoxContainer/Winners_Label

func _ready():
#	var h = get_parent()
	var test1 = get_tree().get_current_scene().connect("game_over", self , "game_over")
	var test2 = Player_Stats.connect("hud_update", self, "update_hud")
	if test1 != 0:
		print("ERROR: top hud connecting game over")
	if test2 != 0:
		print("ERROR: top hud connecting hud update")
	Player_Stats.set_hud(self)

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
	

func update_hud(_p1,_p2,_p3,_p4,_p5,_p6,_p7,_p8):
	hud_p1.visible = _p1["exist"]
	if _p1["in_play"]:
		kills_p1.text = str(_p1["score"])
	hud_p2.visible = _p2["exist"]
	if _p2["in_play"]:
		kills_p2.text = str(_p2["score"])
	hud_p3.visible = _p3["exist"]
	if _p3["in_play"]:
		kills_p3.text = str(_p3["score"])
	hud_p4.visible = _p4["exist"]
	if _p4["in_play"]:
		kills_p4.text = str(_p4["score"])
	hud_p5.visible = _p5["exist"]
	if _p5["in_play"]:
		kills_p5.text = str(_p5["score"])
	hud_p6.visible = _p6["exist"]
	if _p6["in_play"]:
		kills_p6.text = str(_p6["score"])
	hud_p7.visible = _p7["exist"]
	if _p7["in_play"]:
		kills_p7.text = str(_p7["score"])
	hud_p8.visible = _p8["exist"]
	if _p8["in_play"]:
		kills_p8.text = str(_p8["score"])

func game_over(_winner):
	winners_label.visible = true
	winners_label.text = str("player ",_winner, " has won the game sucka!!")
	print("HUD knows player ",_winner, " has won the game")

func update_player_hud_vis(_p1, _p2, _p3, _p4, _p5, _p6, _p7, _p8):
	hud_p1.visible = _p1
	hud_p2.visible = _p2
	hud_p3.visible = _p3
	hud_p4.visible = _p4
	hud_p5.visible = _p5
	hud_p6.visible = _p6
	hud_p7.visible = _p7
	hud_p8.visible = _p8

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