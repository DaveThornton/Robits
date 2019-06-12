extends MarginContainer

export(PackedScene) var map_screen

onready var bottom_hud = $VBoxContainer/Console_Bottom_HUD
onready var p1_menu = $Menu_4x2_01
onready var p2_menu = $Menu_4x2_02
onready var p3_menu = $Menu_4x2_03
onready var p4_menu = $Menu_4x2_04
onready var p5_menu = $Menu_4x2_05

var can_start = false
var started_num = 0
var ready_num = 0

var p1_has_credits = true
var p2_has_credits = true
var p3_has_credits = true
var p4_has_credits = true
var p5_has_credits = true

var p1_started
var p2_started
var p3_started
var p4_started
var p5_started

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false

#var p1_pos = 0
#var p2_pos = 0
#var p3_pos = 0
#var p4_pos = 0
#var p5_pos = 0

#signal load_map(load_to_map)
#signal use_credit(_player)

func _ready():
	check()
	var test1 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	if test1 != 0:
		print("error console player select connect input to screen")

func check():
	_get_started_num()
	var num_with_s = 0
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
	
	if p1_started && !p1_ready:
		bottom_hud.change_label( 1, 2)
		p1_menu.visible = true
		num_with_s += 1
	elif p1_ready:
		p1_menu.visible = true
		bottom_hud.change_label( 1, 1)
	elif p1_has_credits:
		bottom_hud.change_label( 1, 3)
	else:
		print(" error in player select in func check() p1 section")

	if p2_started && !p2_ready:
		bottom_hud.change_label( 2, 2)
		p2_menu.visible = true
		num_with_s += 1
	elif p2_ready:
		p2_menu.visible = true
		bottom_hud.change_label( 2, 1)
	elif p2_has_credits:
		bottom_hud.change_label( 2, 3)
	else:
		print(" error in player select in func check() p2 section")

	if p3_started && !p3_ready:
		bottom_hud.change_label( 3, 2)
		p3_menu.visible = true
		num_with_s += 1
	elif p3_ready:
		p3_menu.visible = true
		bottom_hud.change_label( 3, 1)
	elif p3_has_credits:
		bottom_hud.change_label( 3, 3)
	else:
		print(" error in player select in func check() p3 section")

	if p4_started && !p1_ready:
		bottom_hud.change_label( 4, 2)
		p4_menu.visible = true
		num_with_s += 1
	elif p4_ready:
		p4_menu.visible = true
		bottom_hud.change_label( 4, 1)
	elif p4_has_credits:
		bottom_hud.change_label( 4, 3)
	else:
		print(" error in player select in func check() p4 section")

	if p5_started && !p5_ready:
		bottom_hud.change_label( 5, 2)
		p5_menu.visible = true
		num_with_s += 1
	elif p5_ready:
		p5_menu.visible = true
		bottom_hud.change_label( 5, 1)
	elif p5_has_credits:
		bottom_hud.change_label( 5, 3)
	else:
		print(" error in player select in func check() p5 section")
#
#	if num_with_s > 1:
	if started_num == ready_num:
#			choose_map()
#			emit_signal("load_map",map_to_load)
		print("ready????")
		get_tree().get_current_scene().load_screen(map_screen)
		queue_free()
	if num_with_s == 0:
		print("console player select no starts why call a check?")
	

func movement(_player, _dir):
	print(_player, _dir)
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
#					p1_pos = p1_menu.pos
					ready_num += 1
		elif p1_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p1_started = true
#				emit_signal("use_credit",_player)
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
#					p2_pos = p2_menu.pos
					ready_num += 1
		elif p2_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p2_started = true
#				emit_signal("use_credit",_player)
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
#					p3_pos = p3_menu.pos
					ready_num += 1
		elif p3_has_credits:
			if _dir == 5:
				started_num += 1
				get_tree().get_current_scene().p3_started = true
#				emit_signal("use_credit",_player)
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
#				emit_signal("use_credit",_player)
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
#				emit_signal("use_credit",_player)
		elif p5_ready:
			if _dir == 6:
				p5_ready = false
				ready_num -= 1
	else:
		print("error invald player in console start")
	check()

#func choose_player():
##	randomize()
##	var r = randi()%5+1
#	var r = rand_num(5)
##	print(r)
#	var m = 0
#	if r == 1:
#		if p1_pos == 0:
#			choose_map()
#			return
#		else:
#			m = p1_pos
#	elif r == 2:
#		if p2_pos == 0:
#			choose_map()
#			return
#		else:
#			m = p2_pos
#	elif r == 3:
#		if p3_pos == 0:
#			choose_map()
#			return
#		else:
#			m = p3_pos
#	elif r == 4:
#		if p4_pos == 0:
#			choose_map()
#			return
#		else:
#			m = p4_pos
#	elif r == 5:
#		if p5_pos == 0:
#			choose_map()
#			return
#		else:
#			m = p5_pos
#	choose_map_from_list(m)

#func _pawn_choice(_player, _pawn):
#	if _player == 1:
#		self.get_tree().get_current_scene().p1_controller.pawn_num = _pawn
#		return
#	elif _player == 2:
#		self.get_tree().get_current_scene().p2_controller.pawn_num = _pawn
#		return
#	elif _player == 3:
#		self.get_tree().get_current_scene().p3_controller.pawn_num = _pawn
#		return
#	elif _player == 4:
#		self.get_tree().get_current_scene().p4_controller.pawn_num = _pawn
#		return
#	elif _player == 5:
#		self.get_tree().get_current_scene().p5_controller.pawn_num = _pawn
#		return
#	else:
#		print("error in pawn choice invalad player number( above 5 )")

#func choose_pawn_from_list(_num):
#	if _num == 1:
#		map_to_load = map_01
#	elif _num == 2:
#		map_to_load = map_02
#	elif _num == 3:
#		map_to_load = map_03
#	elif _num == 4:
#		map_to_load = map_04
#	elif _num == 5:
#		map_to_load = map_05
#	elif _num == 6:
#		map_to_load = map_06
#	elif _num == 7:
#		map_to_load = map_07
#	elif _num == 8:
#		map_to_load = map_08
#
#		var r = rand_num(15)
#		choose_map_from_list(r)
#		print(r)
#		return
##		map_to_load = map_16
#	else:
#		print( "error on arcade map select in choose map from list no map # ", _num)

func _get_started_num():
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
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
	started_num = _started

func rand_num( _num):
	randomize()
	var rand = randi()%_num+1
	return rand

func _on_Timer_timeout():
	can_start = true
