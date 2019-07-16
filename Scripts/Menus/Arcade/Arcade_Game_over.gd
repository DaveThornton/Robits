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
#var started_num = 0
var in_play_num = 0


func _ready():
	var test = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	if test != 0:
		print("error in arcade game over ready connect input to screen")
	get_tree().get_current_scene().in_to_menu()
	if get_tree().get_current_scene().p1_started:
		p1_results.visible = true
		p1_dash.visible = true
		bottom_hud.change_label( 1, 2)
		in_play_num += 1
	else:
		p1_results.visible = false
		p1_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 1, 4)
	if get_tree().get_current_scene().p2_started:
		p2_results.visible = true
		p2_dash.visible = true
		bottom_hud.change_label( 2, 2)
		in_play_num += 1
	else:
		p2_results.visible = false
		p2_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 2, 4)
	if get_tree().get_current_scene().p3_started:
		p3_results.visible = true
		p3_dash.visible = true
		bottom_hud.change_label( 3, 2)
		in_play_num += 1
	else:
		p3_results.visible = false
		p3_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 3, 4)
	if get_tree().get_current_scene().p4_started:
		p4_results.visible = true
		p4_dash.visible = true
		bottom_hud.change_label( 4, 2)
		in_play_num += 1
	else:
		p4_results.visible = false
		p4_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 4, 4)
	if get_tree().get_current_scene().p5_started:
		p5_results.visible = true
		p5_dash.visible = true
		bottom_hud.change_label( 5, 2)
		in_play_num += 1
	else:
		p5_results.visible = false
		p5_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 5, 4)
	if get_tree().get_current_scene().p6_started:
		p6_results.visible = true
		p6_dash.visible = true
		bottom_hud.change_label( 6, 2)
		in_play_num += 1
	else:
		p6_results.visible = false
		p6_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 6, 4)
	if get_tree().get_current_scene().p7_started:
		p7_results.visible = true
		p7_dash.visible = true
		bottom_hud.change_label( 7, 2)
		in_play_num += 1
	else:
		p7_results.visible = false
		p7_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 7, 4)
	if get_tree().get_current_scene().p8_started:
		p8_results.visible = true
		p8_dash.visible = true
		bottom_hud.change_label( 8, 2)
		in_play_num += 1
	else:
		p8_results.visible = false
		p8_dash.size_flags_stretch_ratio = 1
		bottom_hud.change_label( 8, 4)

func movement(_player, _dir):
	if _player == 1:
		if get_tree().get_current_scene().p1_started:
			if _dir ==5:
				p1_done = true
				bottom_hud.change_label( 1, 4)
	elif _player == 2:
		if get_tree().get_current_scene().p2_started:
			if _dir ==5:
				p2_done = true
				bottom_hud.change_label( 2, 4)
	elif _player == 3:
		if get_tree().get_current_scene().p3_started:
			if _dir ==5:
				p3_done = true
				bottom_hud.change_label( 3, 4)
	elif _player == 4:
		if get_tree().get_current_scene().p4_started:
			if _dir ==5:
				p4_done = true
				bottom_hud.change_label( 4, 4)
	elif _player == 5:
		if get_tree().get_current_scene().p5_started:
			if _dir ==5:
				p5_done = true
				bottom_hud.change_label( 5, 4)
	elif _player == 6:
		if get_tree().get_current_scene().p6_started:
			if _dir ==5:
				p6_done = true
				bottom_hud.change_label( 6, 4)
	elif _player == 7:
		if get_tree().get_current_scene().p7_started:
			if _dir ==5:
				p7_done = true
				bottom_hud.change_label( 7, 4)
	elif _player == 8:
		if get_tree().get_current_scene().p8_started:
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
