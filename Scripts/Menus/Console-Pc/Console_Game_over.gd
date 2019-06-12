extends MarginContainer

onready var p1_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End1
onready var p2_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End2
onready var p3_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End3
onready var p4_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End4
onready var p5_results = $VBoxContainer/HBoxContainer/VBox_Arcade_Player_End5

onready var p1_dash = $VBoxContainer/HBoxContainer/_1
onready var p2_dash = $VBoxContainer/HBoxContainer/_2
onready var p3_dash = $VBoxContainer/HBoxContainer/_3
onready var p4_dash = $VBoxContainer/HBoxContainer/_4
onready var p5_dash = $VBoxContainer/HBoxContainer/_5

onready var bottom_hud = $VBoxContainer/Console_Bottom_HUD

var p1_done = false
var p2_done = false
var p3_done = false
var p4_done = false
var p5_done = false

#var started_num = 0
var in_play_num = 0


func _ready():
	var test1 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	if test1 != 0:
		print("error in console game over connectiug input to screen")
	get_tree().get_current_scene().in_to_menu()
	if get_tree().get_current_scene().p1_started:
		p1_results.visible = true
		p1_dash.visible = true
		bottom_hud.change_label( 1, 3)
		in_play_num += 1
	else:
		p1_results.visible = false
		p1_dash.size_flags_stretch_ratio = 1.5
		
		bottom_hud.change_label( 1, 4)
	if get_tree().get_current_scene().p2_started:
		p2_results.visible = true
		p2_dash.visible = true
		bottom_hud.change_label( 2, 3)
		in_play_num += 1
	else:
		p2_results.visible = false
		p2_dash.size_flags_stretch_ratio = 1.5
		bottom_hud.change_label( 2, 4)
	if get_tree().get_current_scene().p3_started:
		p3_results.visible = true
		p3_dash.visible = true
		bottom_hud.change_label( 3, 3)
		in_play_num += 1
	else:
		p3_results.visible = false
		p3_dash.size_flags_stretch_ratio = 1.5
		bottom_hud.change_label( 3, 4)
	if get_tree().get_current_scene().p4_started:
		p4_results.visible = true
		p4_dash.visible = true
		bottom_hud.change_label( 4, 3)
		in_play_num += 1
	else:
		p4_results.visible = false
		p4_dash.size_flags_stretch_ratio = 1.5
		bottom_hud.change_label( 4, 4)
	if get_tree().get_current_scene().p5_started:
		p5_results.visible = true
		p5_dash.visible = true
		bottom_hud.change_label( 5, 3)
		in_play_num += 1
	else:
		p5_results.visible = false
		p5_dash.size_flags_stretch_ratio = 1.5
		bottom_hud.change_label( 5, 4)

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
	
	if started_num == in_play_num:
		get_tree().get_current_scene().arcade_reset()
		queue_free()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
