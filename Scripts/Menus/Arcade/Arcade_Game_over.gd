extends MarginContainer

onready var p1_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End1
onready var p2_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End2
onready var p3_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End3
onready var p4_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End4
onready var p5_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End5
onready var p6_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End6
onready var p7_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End7
onready var p8_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End8

onready var p1_dash = $VBoxContainer/HBoxContainer/_1
onready var p2_dash = $VBoxContainer/HBoxContainer/_2
onready var p3_dash = $VBoxContainer/HBoxContainer/_3
onready var p4_dash = $VBoxContainer/HBoxContainer/_4
onready var p5_dash = $VBoxContainer/HBoxContainer/_5
onready var p6_dash = $VBoxContainer/HBoxContainer/_6
onready var p7_dash = $VBoxContainer/HBoxContainer/_7
onready var p8_dash = $VBoxContainer/HBoxContainer/_8

onready var bottom_hud = $VBoxContainer/Arcade_Bottom_HUD

var p1_done = false
var p2_done = false
var p3_done = false
var p4_done = false
var p5_done = false
var p6_done = false
var p7_done = false
var p8_done = false
var in_play_num = 0


func _ready():
	set_places()
	var test = Menu_Hand.connect("input_to_screen", self, "movement")
	if test != 0:
		print("error in arcade game over ready connect input to screen")
	get_tree().get_current_scene().in_to_menu()
	if Player_Stats.p1["in_play"]:
		p1_results.visible = true
		p1_dash.visible = true
		bottom_hud.change_label( 1, 2)
		in_play_num += 1
	else:
		p1_results.visible = false
		p1_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 1, 4)
		
		
	if Player_Stats.p2["in_play"]:
		p2_results.visible = true
		p2_dash.visible = true
		bottom_hud.change_label( 2, 2)
		in_play_num += 1
	else:
		p2_results.visible = false
		p2_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 2, 4)
		
		
	if Player_Stats.p3["in_play"]:
		p3_results.visible = true
		p3_dash.visible = true
		bottom_hud.change_label( 3, 2)
		in_play_num += 1
	else:
		p3_results.visible = false
		p3_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 3, 4)
		
		
	if Player_Stats.p4["in_play"]:
		p4_results.visible = true
		p4_dash.visible = true
		bottom_hud.change_label( 4, 2)
		in_play_num += 1
	else:
		p4_results.visible = false
		p4_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 4, 4)
		
		
	if Player_Stats.p5["in_play"]:
		p5_results.visible = true
		p5_dash.visible = true
		bottom_hud.change_label( 5, 2)
		in_play_num += 1
	else:
		p5_results.visible = false
		p5_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 5, 4)
		
		
	if Player_Stats.p6["in_play"]:
		p6_results.visible = true
		p6_dash.visible = true
		bottom_hud.change_label( 6, 2)
		in_play_num += 1
	else:
		p6_results.visible = false
		p6_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 6, 4)
		
		
	if Player_Stats.p7["in_play"]:
		p7_results.visible = true
		p7_dash.visible = true
		bottom_hud.change_label( 7, 2)
		in_play_num += 1
	else:
		p7_results.visible = false
		p7_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 7, 4)
		
		
	if Player_Stats.p8["in_play"]:
		p8_results.visible = true
		p8_dash.visible = true
		bottom_hud.change_label( 8, 2)
		in_play_num += 1
	else:
		p8_results.visible = false
		p8_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 8, 4)

func set_places():
	var _places = Player_Stats.get_places()
	print(_places)
	for _p in _places.size():
		if _places[_p].x == 1:
			p1_results.set_place(_p + 1)
		elif _places[_p].x == 2:
			p2_results.set_place(_p + 1)
		elif _places[_p].x == 3:
			p3_results.set_place(_p + 1)
		elif _places[_p].x == 4:
			p4_results.set_place(_p + 1)
		elif _places[_p].x == 5:
			p5_results.set_place(_p + 1)
		elif _places[_p].x == 6:
			p6_results.set_place(_p + 1)
		elif _places[_p].x == 7:
			p7_results.set_place(_p + 1)
		elif _places[_p].x == 8:
			p8_results.set_place(_p + 1)
#	for j in range(_players):
#		spawn_player_contoller(j+1, auto_respawn)

func place_results():
	pass
func movement(_player, _dir):
	if _player == 1:
		if Player_Stats.p1["in_play"]:
#		if get_tree().get_current_scene().p1_started:
			if _dir ==5:
				p1_done = true
				bottom_hud.change_label( 1, 4)
	elif _player == 2:
		if Player_Stats.p2["in_play"]:
			if _dir ==5:
				p2_done = true
				bottom_hud.change_label( 2, 4)
	elif _player == 3:
		if Player_Stats.p3["in_play"]:
			if _dir ==5:
				p3_done = true
				bottom_hud.change_label( 3, 4)
	elif _player == 4:
		if Player_Stats.p4["in_play"]:
			if _dir ==5:
				p4_done = true
				bottom_hud.change_label( 4, 4)
	elif _player == 5:
		if Player_Stats.p5["in_play"]:
			if _dir ==5:
				p5_done = true
				bottom_hud.change_label( 5, 4)
	elif _player == 6:
		if Player_Stats.p6["in_play"]:
			if _dir ==5:
				p6_done = true
				bottom_hud.change_label( 6, 4)
	elif _player == 7:
		if Player_Stats.p7["in_play"]:
			if _dir ==5:
				p7_done = true
				bottom_hud.change_label( 7, 4)
	elif _player == 8:
		if Player_Stats.p8["in_play"]:
			if _dir ==5:
				p8_done = true
				bottom_hud.change_label( 8, 4)
	else:
		print("error invald player in arcade game over menu")
		
	var started_num = 0
	
	if p1_done:
		started_num += 1
	if p2_done:
		started_num += 1
	if p3_done:
		started_num += 1
	if p4_done:
		started_num += 1
	if p5_done:
		started_num += 1
	if p6_done:
		started_num += 1
	if p7_done:
		started_num += 1
	if p8_done:
		started_num += 1
	
	if started_num == in_play_num:
		get_tree().get_current_scene().arcade_reset()
		queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
