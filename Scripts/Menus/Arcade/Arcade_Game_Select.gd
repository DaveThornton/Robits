extends MarginContainer
export(PackedScene) var campaign
export(PackedScene) var vs_mode                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

onready var menu = $menu_1X3_01
onready var bottom_hud = $VBoxContainer/Arcade_Bottom_HUD
#onready var sfx = $SFX_Lib

#var can_start = false
var started_num = 0

var p1_has_credits = false
var p2_has_credits = false
var p3_has_credits = false
var p4_has_credits = false
var p5_has_credits = false
var p6_has_credits = false
var p7_has_credits = false
var p8_has_credits = false

var p1_started
var p2_started
var p3_started
var p4_started
var p5_started
var p6_started
var p7_started
var p8_started

var menu_pos

signal use_credit(_player)
signal load_screen(_screen_to_load)

func _ready():
	var test1 = connect("load_screen", get_tree().get_current_scene(), "load_screen")
	var test2 = get_tree().get_current_scene().connect("coin_up", self, "check")
	var test3 = Menu_Hand.connect("input_to_screen", self, "movement")
	var test4 = connect("use_credit",get_tree().get_current_scene(),"use_credit")
	if test1 != 0:
		print("error in arcade game select connect load_screen")
	if test2 != 0:
		print("error in arcade game select connect coin up")
	if test3 != 0:
		print("error in arcade game select connect input to screen")
	if test4 != 0:
		print("error in arcade game select connect use credit")
	check()

func _start():
	if menu_pos == 1:
		emit_signal("load_screen", campaign)
#		get_tree().get_current_scene().load_screen(campaign)
		call_deferred("free")
	if menu_pos == 2:
#		sfx play some shit
		pass
	if menu_pos == 3:
		emit_signal("load_screen", vs_mode)
#		get_tree().get_current_scene().load_screen(vs_mode)
		call_deferred("free")

func movement(_player, _dir):
	if _player == 1:
		if p1_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p1_has_credits:
			if _dir == 5:
				Player_Stats.p1["in_play"] = true
				emit_signal("use_credit",_player)
		else:
			print("player got nothin")
	elif _player == 2:
		if p2_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p2_has_credits:
			if _dir == 5:
				Player_Stats.p2["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 3:
		if p3_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p3_has_credits:
			if _dir == 5:
				Player_Stats.p3["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 4:
		if p4_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p4_has_credits:
			if _dir == 5:
				Player_Stats.p4["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 5:
		if p5_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p5_has_credits:
			if _dir == 5:
				Player_Stats.p5["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 6:
		if p6_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p6_has_credits:
			if _dir == 5:
				Player_Stats.p6["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 7:
		if p7_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p7_has_credits:
			if _dir == 5:
				Player_Stats.p7["in_play"] = true
				emit_signal("use_credit",_player)
	elif _player == 8:
		if p8_started:
			if _dir ==1:
				menu.move_up()
			elif _dir ==2:
				menu.move_left()
			elif _dir ==3:
				menu.move_right()
			elif _dir ==4:
				menu.move_down()
			elif _dir ==5:
#				if can_start:
				menu_pos = menu.pos
				started_num += 1
				_start()
		elif p8_has_credits:
			if _dir == 5:
				Player_Stats.p8["in_play"] = true
				emit_signal("use_credit",_player)
	else:
		print("error invald player in arcade start")
	check()

func check():
	if Player_Stats.p1["credit"] >= 1:
		 p1_has_credits = true
	if Player_Stats.p2["credit"] >= 1:
		 p2_has_credits = true
	if Player_Stats.p3["credit"] >= 1:
		 p3_has_credits = true
	if Player_Stats.p4["credit"] >= 1:
		 p4_has_credits = true
	if Player_Stats.p5["credit"] >= 1:
		 p5_has_credits = true
	if Player_Stats.p6["credit"] >= 1:
		 p6_has_credits = true
	if Player_Stats.p7["credit"] >= 1:
		 p7_has_credits = true
	if Player_Stats.p8["credit"] >= 1:
		 p8_has_credits = true
	p1_started = Player_Stats.p1["in_play"]
	p2_started = Player_Stats.p2["in_play"]
	p3_started = Player_Stats.p3["in_play"]
	p4_started = Player_Stats.p4["in_play"]
	p5_started = Player_Stats.p5["in_play"]
	p6_started = Player_Stats.p6["in_play"]
	p7_started = Player_Stats.p7["in_play"]
	p8_started = Player_Stats.p8["in_play"]
	if p1_started:
		bottom_hud.change_label( 1, 3)
	elif p1_has_credits:
		bottom_hud.change_label( 1, 2)
	else:
		bottom_hud.change_label( 1, 1)
	if p2_started:
		bottom_hud.change_label( 2, 3)
	elif p2_has_credits:
		bottom_hud.change_label( 2, 2)
	else:
		bottom_hud.change_label( 2, 1)
	if p3_started:
		bottom_hud.change_label( 3, 3)
	elif p3_has_credits:
		bottom_hud.change_label( 3, 2)
	else:
		bottom_hud.change_label( 3, 1)
	if p4_started:
		bottom_hud.change_label( 4, 3)
	elif p4_has_credits:
		bottom_hud.change_label( 4, 2)
	else:
		bottom_hud.change_label( 4, 1)
	if p5_started:
		bottom_hud.change_label( 5, 3)
	elif p5_has_credits:
		bottom_hud.change_label( 5, 2)
	else:
		bottom_hud.change_label( 5, 1)
	if p6_started:
		bottom_hud.change_label( 6, 3)
	elif p6_has_credits:
		bottom_hud.change_label( 6, 2)
	else:
		bottom_hud.change_label( 6, 1)
	if p7_started:
		bottom_hud.change_label( 7, 3)
	elif p7_has_credits:
		bottom_hud.change_label( 7, 2)
	else:
		bottom_hud.change_label( 7, 1)
	if p8_started:
		bottom_hud.change_label( 8, 3)
	elif p8_has_credits:
		bottom_hud.change_label( 8, 2)
	else:
		bottom_hud.change_label( 8, 1)
##	var num_with_c = 0
##	var num_with_s = 0
#	if get_tree().get_current_scene().p1_credits >= 1:
#		p1_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p2_credits >= 1:
#		p2_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p3_credits >= 1:
#		p3_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p4_credits >= 1:
#		p4_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p5_credits >= 1:
#		p5_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p6_credits >= 1:
#		p6_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p7_credits >= 1:
#		p7_has_credits = true
##		num_with_c += 1
#	if get_tree().get_current_scene().p8_credits >= 1:
#		p8_has_credits = true
##		num_with_c += 1
#
##	if num_with_c == 0:
##		print("arcade map select no one has credits?")
#	p1_started = get_tree().get_current_scene().p1_started
#	p2_started = get_tree().get_current_scene().p2_started
#	p3_started = get_tree().get_current_scene().p3_started
#	p4_started = get_tree().get_current_scene().p4_started
#	p5_started = get_tree().get_current_scene().p5_started
#	p6_started = get_tree().get_current_scene().p6_started
#	p7_started = get_tree().get_current_scene().p7_started
#	p8_started = get_tree().get_current_scene().p8_started
#
#	if p1_started:
#		bottom_hud.change_label( 1, 3)
##		num_with_s += 1
#	elif p1_has_credits:
#		bottom_hud.change_label( 1, 2)
#	else:
#		bottom_hud.change_label( 1, 1)
#	if p2_started:
#		bottom_hud.change_label( 2, 3)
##		num_with_s += 1
#	elif p2_has_credits:
#		bottom_hud.change_label( 2, 2)
#	else:
#		bottom_hud.change_label( 2, 1)
#	if p3_started:
#		bottom_hud.change_label( 3, 3)
##		num_with_s += 1
#	elif p3_has_credits:
#		bottom_hud.change_label( 3, 2)
#	else:
#		bottom_hud.change_label( 3, 1)
#	if p4_started:
#		bottom_hud.change_label( 4, 3)
##		num_with_s += 1
#	elif p4_has_credits:
#		bottom_hud.change_label( 4, 2)
#	else:
#		bottom_hud.change_label( 4, 1)
#	if p5_started:
#		bottom_hud.change_label( 5, 3)
##		num_with_s += 1
#	elif p5_has_credits:
#		bottom_hud.change_label( 5, 2)
#	else:
#		bottom_hud.change_label( 5, 1)
#	if p6_started:
#		bottom_hud.change_label( 6, 3)
##		num_with_s += 1
#	elif p6_has_credits:
#		bottom_hud.change_label( 6, 2)
#	else:
#		bottom_hud.change_label( 6, 1)
#	if p7_started:
#		bottom_hud.change_label( 7, 3)
##		num_with_s += 1
#	elif p7_has_credits:
#		bottom_hud.change_label( 7, 2)
#	else:
#		bottom_hud.change_label( 7, 1)
#	if p8_started:
#		bottom_hud.change_label( 8, 3)
##		num_with_s += 1
#	elif p8_has_credits:
#		bottom_hud.change_label( 8, 2)
#	else:
#		bottom_hud.change_label( 8, 1)