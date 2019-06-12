extends MarginContainer

export(PackedScene) var map_01
export(PackedScene) var map_02
export(PackedScene) var map_03
export(PackedScene) var map_04
export(PackedScene) var map_05
export(PackedScene) var map_06
export(PackedScene) var map_07
export(PackedScene) var map_08
export(PackedScene) var map_09
export(PackedScene) var map_10
export(PackedScene) var map_11
export(PackedScene) var map_12
export(PackedScene) var map_13
export(PackedScene) var map_14
export(PackedScene) var map_15
export(PackedScene) var map_16

onready var bottom_hud = $VBoxContainer/Console_Bottom_HUD
onready var p1_menu = $Menu_4x4_01
onready var p2_menu = $Menu_4x4_02
onready var p3_menu = $Menu_4x4_03
onready var p4_menu = $Menu_4x4_04
onready var p5_menu = $Menu_4x4_05

var map_to_load
#var map_load_01
#var map_load_02
#var map_load_03
#var map_load_04
#var map_load_05
var num_of_players

var all_ready = false
var can_start = false
var started_num = 0
var ready_num = 0

var slot_1
var slot_2
var slot_3
var slot_4
var slot_5

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

var p1_pos = 1
var p2_pos = 1
var p3_pos = 1
var p4_pos = 1
var p5_pos = 1

signal load_map(load_to_map)
#signal use_credit(_player)

func _ready():
	var test1 = connect("load_map", get_tree().get_current_scene(), "load_map")
	var test2 = get_tree().get_current_scene().connect("coin_up", self, "check")
	var test3 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	var test4 = self.connect("use_credit",get_tree().get_current_scene(),"use_credit")
	if test1 !=0:
		print("error console map select connecting load map")
	if test2 !=0:
		print("error console map select connecting coin up")
	if test3 !=0:
		print("error console map select connecting input to screen")
	if test4 !=0:
		print("error console map select connecting use credit")
	check()

func check():
#	var num_with_c = 0
	var num_with_s = 0
#	if get_tree().get_current_scene().p1_credits >= 1:
#		p1_has_credits = true
#		num_with_c += 1
#	if get_tree().get_current_scene().p2_credits >= 1:
#		p2_has_credits = true
#		num_with_c += 1
#	if get_tree().get_current_scene().p3_credits >= 1:
#		p3_has_credits = true
#		num_with_c += 1
#	if get_tree().get_current_scene().p4_credits >= 1:
#		p4_has_credits = true
#		num_with_c += 1
#	if get_tree().get_current_scene().p5_credits >= 1:
#		p5_has_credits = true
#		num_with_c += 1
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
	if p1_started:
		num_with_s += 1
	if p2_started:
		num_with_s += 1
	if p3_started:
		num_with_s += 1
	if p4_started:
		num_with_s += 1
	if p5_started:
		num_with_s += 1
	started_num = num_with_s
#	if p1_started:
#		bottom_hud.change_label( 1, 3)
#		p1_menu.visible = true
#		num_with_s += 1
#	elif p1_has_credits:
#		bottom_hud.change_label( 1, 2)
#	else:
#		bottom_hud.change_label( 1, 1)
#	if p2_started:
#		bottom_hud.change_label( 2, 3)
#		p2_menu.visible = true
#		num_with_s += 1
#	elif p2_has_credits:
#		bottom_hud.change_label( 2, 2)
#	else:
#		bottom_hud.change_label( 2, 1)
#	if p3_started:
#		bottom_hud.change_label( 3, 3)
#		p3_menu.visible = true
#		num_with_s += 1
#	elif p3_has_credits:
#		bottom_hud.change_label( 3, 2)
#	else:
#		bottom_hud.change_label( 3, 1)
#	if p4_started:
#		bottom_hud.change_label( 4, 3)
#		p4_menu.visible = true
#		num_with_s += 1
#	elif p4_has_credits:
#		bottom_hud.change_label( 4, 2)
#	else:
#		bottom_hud.change_label( 4, 1)
#	if p5_started:
#		bottom_hud.change_label( 5, 3)
#		p5_menu.visible = true
#		num_with_s += 1
#	elif p5_has_credits:
#		bottom_hud.change_label( 5, 2)
#	else:
#		bottom_hud.change_label( 5, 1)
#	if num_with_s > 1:

	if p1_started && !p1_ready:
		bottom_hud.change_label( 1, 2)
		p1_menu.visible = true
#		num_with_s += 1
	elif p1_ready:
		p1_menu.visible = true
		bottom_hud.change_label( 1, 1)
	elif p1_has_credits:
		bottom_hud.change_label( 1, 3)
	else:
		print(" error in map select in func check() p1 section")

	if p2_started && !p2_ready:
		bottom_hud.change_label( 2, 2)
		p2_menu.visible = true
#		num_with_s += 1
	elif p2_ready:
		p2_menu.visible = true
		bottom_hud.change_label( 2, 1)
	elif p2_has_credits:
		bottom_hud.change_label( 2, 3)
	else:
		print(" error in map select in func check() p2 section")

	if p3_started && !p3_ready:
		bottom_hud.change_label( 3, 2)
		p3_menu.visible = true
#		num_with_s += 1
	elif p3_ready:
		p3_menu.visible = true
		bottom_hud.change_label( 3, 1)
	elif p3_has_credits:
		bottom_hud.change_label( 3, 3)
	else:
		print(" error in map select in func check() p3 section")

	if p4_started && !p1_ready:
		bottom_hud.change_label( 4, 2)
		p4_menu.visible = true
#		num_with_s += 1
	elif p4_ready:
		p4_menu.visible = true
		bottom_hud.change_label( 4, 1)
	elif p4_has_credits:
		bottom_hud.change_label( 4, 3)
	else:
		print(" error in map select in func check() p4 section")

	if p5_started && !p5_ready:
		bottom_hud.change_label( 5, 2)
		p5_menu.visible = true
#		num_with_s += 1
	elif p5_ready:
		p5_menu.visible = true
		bottom_hud.change_label( 5, 1)
	elif p5_has_credits:
		bottom_hud.change_label( 5, 3)
	else:
		print(" error in map select in func check() p5 section")
#
#	if num_with_s > 1:
	if ready_num > 1:
		if started_num == ready_num:
			if !all_ready:
				all_ready = true
	#		if num_with_s == started_num:
				choose_map()
				emit_signal("load_map",map_to_load)
				queue_free()

func movement(_player, _dir):
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
#					self.get_tree().get_current_scene().p1_controller.pawn_num = p1_menu.pos
					p1_ready = true
					p1_pos = p1_menu.pos
					ready_num += 1
					check()
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
#					self.get_tree().get_current_scene().p2_controller.pawn_num = p2_menu.pos
					p2_ready = true
					p2_pos = p2_menu.pos
					ready_num += 1
					check()
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
#					self.get_tree().get_current_scene().p3_controller.pawn_num = p3_menu.pos
					p3_ready = true
					p3_pos = p3_menu.pos
					ready_num += 1
					check()
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
#					self.get_tree().get_current_scene().p4_controller.pawn_num = p4_menu.pos
					p4_ready = true
					p4_pos = p4_menu.pos
					ready_num += 1
					check()
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
#					self.get_tree().get_current_scene().p5_controller.pawn_num = p5_menu.pos
					p5_ready = true
					p5_pos = p5_menu.pos
					ready_num += 1
					check()
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


func choose_map():
#	randomize()
#	var r = randi()%5+1
	check_slots()
	var p = how_many_players()
	var r = rand_num(p)
	if r == 1:
		choose_map_from_list(slot_1)
	if r == 2:
		choose_map_from_list(slot_2)
	if r == 3:
		choose_map_from_list(slot_3)
	if r == 4:
		choose_map_from_list(slot_4)
	if r == 5:
		choose_map_from_list(slot_5)
	
#
#	if p == 2:
#		pass
#	elif p == 3:
#		pass
#	elif p == 4:
#		pass
#	elif p == 5:
#		pass
#	
#	print(r)
#	var m = p1_pos
#	if p1_started && r == 1:
##		m = p1_pos
#		choose_map_from_list(p1_pos)
#	elif p2_started && r == 2:
##		m = p2_pos
#		choose_map_from_list(p2_pos)
#	elif p3_started && r == 3:
##		m = p3_pos
#		choose_map_from_list(p3_pos)
#	elif p4_started && r == 4:
##		m = p4_pos
#		choose_map_from_list(p4_pos)
#	elif p5_started && r == 5:
##		m = p5_pos
#		choose_map_from_list(p5_pos)
#	else:
#		print("map choice rand num and player didnt match")
#		choose_map()
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

func choose_map_from_list(_num):
	print("choose map from list  ", _num)
	if _num == 1:
		map_to_load = map_01
	elif _num == 2:
		map_to_load = map_02
	elif _num == 3:
		map_to_load = map_03
	elif _num == 4:
		map_to_load = map_04
	elif _num == 5:
		map_to_load = map_05
	elif _num == 6:
		map_to_load = map_06
	elif _num == 7:
		map_to_load = map_07
	elif _num == 8:
		map_to_load = map_08
	elif _num == 9:
		map_to_load = map_09
	elif _num == 10:
		map_to_load = map_10
	elif _num == 11:
		map_to_load = map_11
	elif _num == 12:
		map_to_load = map_12
	elif _num == 13:
		map_to_load = map_13
	elif _num == 14:
		map_to_load = map_14
	elif _num == 15:
		map_to_load = map_15
	elif _num == 16:
#		var r = rand_num(15)
#		choose_map_from_list(r)
#		print(r)
#		return
		map_to_load = map_16
	else:
		print( "error on arcade map select in choose map from list no map # ", _num)

func how_many_players():
	var _p = 0
	if p1_started:
		_p += 1
	if p2_started:
		_p += 1
	if p3_started:
		_p += 1
	if p4_started:
		_p += 1
	if p5_started:
		_p += 1
	num_of_players = _p
	return _p

func check_slots():
	slot_1 = null
	slot_2 = null
	slot_3 = null
	slot_4 = null
	slot_5 = null
	var _p = how_many_players()
	
	if p1_started:
		slot_1 = p1_pos
	elif !p1_started && p2_started:
		slot_1 = p2_pos
	elif !p1_started && !p2_started && p3_started:
		slot_1 = p3_pos
	elif !p1_started && !p2_started && !p3_started && p4_started:
		slot_1 = p4_pos
	else:
		print("error wrong amount of players in map_select func check slots()")
	
	if slot_1 && p2_started:
		slot_2 = p2_pos
	elif slot_1 && p3_started:
		slot_2 = p3_pos
	elif slot_1 && p4_started:
		slot_2 = p4_pos
	elif slot_1 && p5_started:
		slot_2 = p5_pos
	else:
		print("error in map_select func check slots() slot_2")
	
	if _p > 2:
		if slot_2 && p3_started:
			slot_3 = p3_pos
		elif slot_2 && p4_started:
			slot_3 = p4_pos
		elif slot_2 && p5_started:
			slot_3 = p5_pos
		else:
			print("error in map_select func check slots() slot_3")
	
	if _p > 3:
		if slot_3 && p4_started:
			slot_4 = p4_pos
		elif slot_3 && p5_started:
			slot_4 = p5_pos
		else:
			print("error in map_select func check slots() slot_4")
	
	if _p > 4:
		slot_5 = p5_pos

func rand_num( _num):
	randomize()
	var rand = randi()%_num+1
	return rand

func _on_Timer_timeout():
	can_start = true
