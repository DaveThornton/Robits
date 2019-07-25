extends MarginContainer

export(PackedScene) var map_to_load

onready var bottom_hud = $VBoxContainer/Arcade_Bottom_HUD
onready var p1_menu = $Menu_4x4_01
onready var p2_menu = $Menu_4x4_02
onready var p3_menu = $Menu_4x4_03
onready var p4_menu = $Menu_4x4_04
onready var p5_menu = $Menu_4x4_05
onready var p6_menu = $Menu_4x4_06
onready var p7_menu = $Menu_4x4_07
onready var p8_menu = $Menu_4x4_08

var can_start = false
var started_num = 0
var ready_num = 0

var p1_has_credits = false
var p2_has_credits = false
var p3_has_credits = false
var p4_has_credits = false
var p5_has_credits = false
var p6_has_credits = false
var p7_has_credits = false
var p8_has_credits = false

var p1_started = false
var p2_started = false
var p3_started = false
var p4_started = false
var p5_started = false
var p6_started = false
var p7_started = false
var p8_started = false

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false

signal load_map(load_to_map)
signal use_credit(_player)

func _ready():
	var test1 = connect("load_map", get_tree().get_current_scene(), "load_map")
	var test2 = get_tree().get_current_scene().connect("coin_up", self, "check")
	var test3 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
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

func check():
	_credit_check()
	_get_started_num()
	
	if p1_started:
		bottom_hud.change_label( 1, 3)
		p1_menu.visible = true
	elif p1_has_credits:
		bottom_hud.change_label( 1, 2)
	else:
		bottom_hud.change_label( 1, 1)
	if p2_started:
		bottom_hud.change_label( 2, 3)
		p2_menu.visible = true
	elif p2_has_credits:
		bottom_hud.change_label( 2, 2)
	else:
		bottom_hud.change_label( 2, 1)
	if p3_started:
		bottom_hud.change_label( 3, 3)
		p3_menu.visible = true
	elif p3_has_credits:
		bottom_hud.change_label( 3, 2)
	else:
		bottom_hud.change_label( 3, 1)
	if p4_started:
		bottom_hud.change_label( 4, 3)
		p4_menu.visible = true
	elif p4_has_credits:
		bottom_hud.change_label( 4, 2)
	else:
		bottom_hud.change_label( 4, 1)
	if p5_started:
		bottom_hud.change_label( 5, 3)
		p5_menu.visible = true
	elif p5_has_credits:
		bottom_hud.change_label( 5, 2)
	else:
		bottom_hud.change_label( 5, 1)
	if p6_started:
		bottom_hud.change_label( 6, 3)
		p6_menu.visible = true
	elif p6_has_credits:
		bottom_hud.change_label( 6, 2)
	else:
		bottom_hud.change_label( 6, 1)
	if p7_started:
		bottom_hud.change_label( 7, 3)
		p7_menu.visible = true
	elif p7_has_credits:
		bottom_hud.change_label( 7, 2)
	else:
		bottom_hud.change_label( 7, 1)
	if p8_started:
		bottom_hud.change_label( 8, 3)
		p8_menu.visible = true
	elif p8_has_credits:
		bottom_hud.change_label( 8, 2)
	else:
		bottom_hud.change_label( 8, 1)
#	if p1_started && !p1_ready:
#		bottom_hud.change_label( 1, 2)
#		p1_menu.visible = true
#	elif p1_ready:
#		p1_menu.visible = true
#		bottom_hud.change_label( 1, 1)
#	elif p1_has_credits:
#		bottom_hud.change_label( 1, 3)
#	else:
#		print(" error in player select in func check() p1 section")
#
#	if p2_started && !p2_ready:
#		bottom_hud.change_label( 2, 2)
#		p2_menu.visible = true
#	elif p2_ready:
#		p2_menu.visible = true
#		bottom_hud.change_label( 2, 1)
#	elif p2_has_credits:
#		bottom_hud.change_label( 2, 3)
#	else:
#		print(" error in player select in func check() p2 section")
#
#	if p3_started && !p3_ready:
#		bottom_hud.change_label( 3, 2)
#		p3_menu.visible = true
#	elif p3_ready:
#		p3_menu.visible = true
#		bottom_hud.change_label( 3, 1)
#	elif p3_has_credits:
#		bottom_hud.change_label( 3, 3)
#	else:
#		print(" error in player select in func check() p3 section")
#
#	if p4_started && !p4_ready:
#		bottom_hud.change_label( 4, 2)
#		p4_menu.visible = true
#	elif p4_ready:
#		p4_menu.visible = true
#		bottom_hud.change_label( 4, 1)
#	elif p4_has_credits:
#		bottom_hud.change_label( 4, 3)
#	else:
#		print(" error in player select in func check() p4 section")
#
#	if p5_started && !p5_ready:
#		bottom_hud.change_label( 5, 2)
#		p5_menu.visible = true
#	elif p5_ready:
#		p5_menu.visible = true
#		bottom_hud.change_label( 5, 1)
#	elif p5_has_credits:
#		bottom_hud.change_label( 5, 3)
#	else:
#		print(" error in player select in func check() p5 section")
#	if p6_started && !p6_ready:
#		bottom_hud.change_label( 6, 2)
#		p6_menu.visible = true
#	elif p6_ready:
#		p3_menu.visible = true
#		bottom_hud.change_label( 6, 1)
#	elif p6_has_credits:
#		bottom_hud.change_label( 6, 3)
#	else:
#		print(" error in player select in func check() p3 section")
#
#	if p7_started && !p7_ready:
#		bottom_hud.change_label( 7, 2)
#		p7_menu.visible = true
#	elif p7_ready:
#		p7_menu.visible = true
#		bottom_hud.change_label( 7, 1)
#	elif p7_has_credits:
#		bottom_hud.change_label( 7, 3)
#	else:
#		print(" error in player select in func check() p4 section")
#
#	if p8_started && !p8_ready:
#		bottom_hud.change_label( 8, 2)
#		p8_menu.visible = true
#	elif p8_ready:
#		p8_menu.visible = true
#		bottom_hud.change_label( 8, 1)
#	elif p8_has_credits:
#		bottom_hud.change_label( 8, 3)
#	else:
#		print(" error in player select in func check() p5 section")
	if started_num == ready_num:
		print("ready????")
		emit_signal("load_map", map_to_load)
		queue_free()
	

func movement(_player, _dir):
#	print(_player, _dir)
	if _player == 1:
		if p1_started && !p1_ready:
			if _dir ==1:
				p1_menu.move_up()
			elif _dir ==2:
				p1_menu.move_left()
			elif _dir ==3:
				p1_menu.move_right()
			elif _dir ==4:
				p1_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p1_controller.pawn_num = p1_menu.pos
					p1_ready = true
					ready_num += 1
		elif p1_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p1_started = true
				emit_signal("use_credit",_player)
		elif p1_ready:
			if _dir == 6:
				p1_ready = false
				ready_num -= 1
	elif _player == 2:
		if p2_started && !p2_ready:
			if _dir ==1:
				p2_menu.move_up()
			elif _dir ==2:
				p2_menu.move_left()
			elif _dir ==3:
				p2_menu.move_right()
			elif _dir ==4:
				p2_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p2_controller.pawn_num = p2_menu.pos
					p2_ready = true
					ready_num += 1
		elif p2_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p2_started = true
				emit_signal("use_credit",_player)
		elif p2_ready:
			if _dir == 6:
				p2_ready = false
				ready_num -= 1
	elif _player == 3:
		if p3_started && !p3_ready:
			if _dir ==1:
				p3_menu.move_up()
			elif _dir ==2:
				p3_menu.move_left()
			elif _dir ==3:
				p3_menu.move_right()
			elif _dir ==4:
				p3_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p3_controller.pawn_num = p3_menu.pos
					p3_ready = true
					ready_num += 1
		elif p3_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p3_started = true
				emit_signal("use_credit",_player)
		elif p3_ready:
			if _dir == 6:
				p3_ready = false
				ready_num -= 1
	elif _player == 4:
		if p4_started && !p4_ready:
			if _dir ==1:
				p4_menu.move_up()
			elif _dir ==2:
				p4_menu.move_left()
			elif _dir ==3:
				p4_menu.move_right()
			elif _dir ==4:
				p4_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p4_controller.pawn_num = p4_menu.pos
					p4_ready = true
					ready_num += 1
		elif p4_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p4_started = true
				emit_signal("use_credit",_player)
		elif p4_ready:
			if _dir == 6:
				p4_ready = false
				ready_num -= 1
	elif _player == 5:
		if p5_started && !p5_ready:
			if _dir ==1:
				p5_menu.move_up()
			elif _dir ==2:
				p5_menu.move_left()
			elif _dir ==3:
				p5_menu.move_right()
			elif _dir ==4:
				p5_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p5_controller.pawn_num = p5_menu.pos
					p5_ready = true
					ready_num += 1
		elif p5_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p5_started = true
				emit_signal("use_credit",_player)
		elif p5_ready:
			if _dir == 6:
				p5_ready = false
				ready_num -= 1
	elif _player == 6:
		if p6_started && !p6_ready:
			if _dir ==1:
				p6_menu.move_up()
			elif _dir ==2:
				p6_menu.move_left()
			elif _dir ==3:
				p6_menu.move_right()
			elif _dir ==4:
				p6_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p6_controller.pawn_num = p6_menu.pos
					started_num += 1
		elif p6_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p6_started = true
				emit_signal("use_credit",_player)
		elif p6_ready:
			if _dir == 6:
				p6_ready = false
				ready_num -= 1
	elif _player == 7:
		if p7_started && !p7_ready:
			if _dir ==1:
				p7_menu.move_up()
			elif _dir ==2:
				p7_menu.move_left()
			elif _dir ==3:
				p7_menu.move_right()
			elif _dir ==4:
				p7_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p7_controller.pawn_num = p7_menu.pos
					started_num += 1
		elif p7_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p7_started = true
				emit_signal("use_credit",_player)
		elif p7_ready:
			if _dir == 6:
				p7_ready = false
				ready_num -= 1
	elif _player == 8:
		if p8_started && !p8_ready:
			if _dir ==1:
				p8_menu.move_up()
			elif _dir ==2:
				p8_menu.move_left()
			elif _dir ==3:
				p8_menu.move_right()
			elif _dir ==4:
				p8_menu.move_down()
			elif _dir ==5:
				if can_start:
					self.get_tree().get_current_scene().p8_controller.pawn_num = p8_menu.pos
					started_num += 1
		elif p8_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p8_started = true
				emit_signal("use_credit",_player)
		elif p8_ready:
			if _dir == 6:
				p8_ready = false
				ready_num -= 1
	else:
		print("error invald player in console start")
	check()

func _get_started_num():
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
	p6_started = get_tree().get_current_scene().p6_started
	p7_started = get_tree().get_current_scene().p7_started
	p8_started = get_tree().get_current_scene().p8_started
	var _started = 0
	if p1_started:
		_started += 1
	if p2_started:
		_started += 1
	if p3_started:
		_started += 1
	if p4_started:
		_started += 1
	if p5_started:
		_started += 1
	if p6_started:
		_started += 1
	if p7_started:
		_started += 1
	if p8_started:
		_started += 1
	started_num = _started

func _credit_check():
	if get_tree().get_current_scene().p1_credits >= 1:
		 p1_has_credits = true
	if get_tree().get_current_scene().p2_credits >= 1:
		 p2_has_credits = true
	if get_tree().get_current_scene().p3_credits >= 1:
		 p3_has_credits = true
	if get_tree().get_current_scene().p4_credits >= 1:
		 p4_has_credits = true
	if get_tree().get_current_scene().p5_credits >= 1:
		 p5_has_credits = true
	if get_tree().get_current_scene().p6_credits >= 1:
		 p6_has_credits = true
	if get_tree().get_current_scene().p7_credits >= 1:
		 p7_has_credits = true
	if get_tree().get_current_scene().p8_credits >= 1:
		 p8_has_credits = true

func rand_num( _num):
	randomize()
	var rand = randi()%_num+1
	return rand

func _on_Timer_timeout():
	can_start = true
