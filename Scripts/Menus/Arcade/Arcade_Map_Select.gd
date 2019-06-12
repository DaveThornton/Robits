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
#export(PackedScene) var map_16

onready var bottom_hud = $VBoxContainer/Arcade_Bottom_HUD
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

var can_start = false
var started_num = 0

var p1_has_credits
var p2_has_credits
var p3_has_credits
var p4_has_credits
var p5_has_credits

var p1_started
var p2_started
var p3_started
var p4_started
var p5_started

#var p1_ready
#var p2_ready
#var p3_ready
#var p4_ready
#var p5_ready

var p1_pos = 0
var p2_pos = 0
var p3_pos = 0
var p4_pos = 0
var p5_pos = 0

signal load_map(load_to_map)
signal use_credit(_player)

func _ready():
	var test1 = connect("load_map", get_tree().get_current_scene(), "load_map")
	var test2 = get_tree().get_current_scene().connect("coin_up", self, "check")
	var test3 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	var test4 = self.connect("use_credit",get_tree().get_current_scene(),"use_credit")
	if test1 != 0:
		print("error in arcade map select connect load map")
	if test2 != 0:
		print("error in arcade map select connect coin up")
	if test3 != 0:
		print("error in arcade map select connect input to screen")
	if test4 != 0:
		print("error in arcade map select connect use credit")
	
	check()

func check():
	var num_with_c = 0
	var num_with_s = 0
	if get_tree().get_current_scene().p1_credits >= 1:
		p1_has_credits = true
		num_with_c += 1
	if get_tree().get_current_scene().p2_credits >= 1:
		p2_has_credits = true
		num_with_c += 1
	if get_tree().get_current_scene().p3_credits >= 1:
		p3_has_credits = true
		num_with_c += 1
	if get_tree().get_current_scene().p4_credits >= 1:
		p4_has_credits = true
		num_with_c += 1
	if get_tree().get_current_scene().p5_credits >= 1:
		p5_has_credits = true
		num_with_c += 1
	if num_with_c == 0:
		print("arcade map select no one has credits?")
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
	if p1_started:
		bottom_hud.change_label( 1, 3)
		p1_menu.visible = true
		num_with_s += 1
	elif p1_has_credits:
		bottom_hud.change_label( 1, 2)
	else:
		bottom_hud.change_label( 1, 1)
	if p2_started:
		bottom_hud.change_label( 2, 3)
		p2_menu.visible = true
		num_with_s += 1
	elif p2_has_credits:
		bottom_hud.change_label( 2, 2)
	else:
		bottom_hud.change_label( 2, 1)
	if p3_started:
		bottom_hud.change_label( 3, 3)
		p3_menu.visible = true
		num_with_s += 1
	elif p3_has_credits:
		bottom_hud.change_label( 3, 2)
	else:
		bottom_hud.change_label( 3, 1)
	if p4_started:
		bottom_hud.change_label( 4, 3)
		p4_menu.visible = true
		num_with_s += 1
	elif p4_has_credits:
		bottom_hud.change_label( 4, 2)
	else:
		bottom_hud.change_label( 4, 1)
	if p5_started:
		bottom_hud.change_label( 5, 3)
		p5_menu.visible = true
		num_with_s += 1
	elif p5_has_credits:
		bottom_hud.change_label( 5, 2)
	else:
		bottom_hud.change_label( 5, 1)
	if num_with_s > 1:
		if num_with_s == started_num:
			choose_map()
			emit_signal("load_map",map_to_load)
			queue_free()
	

func movement(_player, _dir):
	if _player == 1:
		if p1_started:
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
					p1_pos = p1_menu.pos
					started_num += 1
		elif p1_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p1_started = true
				emit_signal("use_credit",_player)
	elif _player == 2:
		if p2_started:
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
					p2_pos = p2_menu.pos
					started_num += 1
		elif p2_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p2_started = true
				emit_signal("use_credit",_player)
	elif _player == 3:
		if p3_started:
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
					p3_pos = p3_menu.pos
					started_num += 1
		elif p3_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p3_started = true
				emit_signal("use_credit",_player)
	elif _player == 4:
		if p4_started:
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
					p4_pos = p4_menu.pos
					started_num += 1
		elif p4_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p4_started = true
				emit_signal("use_credit",_player)
	elif _player == 5:
		if p5_started:
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
					p5_pos = p5_menu.pos
					started_num += 1
		elif p5_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p5_started = true
				emit_signal("use_credit",_player)
	else:
		print("error invald player in arcade start")
	check()

func choose_map():
#	randomize()
#	var r = randi()%5+1
	var r = rand_num(5)
#	print(r)
	var m = 0
	if r == 1:
		if p1_pos == 0:
			choose_map()
			return
		else:
			m = p1_pos
	elif r == 2:
		if p2_pos == 0:
			choose_map()
			return
		else:
			m = p2_pos
	elif r == 3:
		if p3_pos == 0:
			choose_map()
			return
		else:
			m = p3_pos
	elif r == 4:
		if p4_pos == 0:
			choose_map()
			return
		else:
			m = p4_pos
	elif r == 5:
		if p5_pos == 0:
			choose_map()
			return
		else:
			m = p5_pos
	choose_map_from_list(m)

func choose_map_from_list(_num):
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
		var r = rand_num(15)
		choose_map_from_list(r)
		print(r)
		return
#		map_to_load = map_16
	else:
		print( "error on arcade map select in choose map from list no map # ", _num)

func rand_num( _num):
	randomize()
	var rand = randi()%_num+1
	return rand

func _on_Timer_timeout():
	can_start = true
