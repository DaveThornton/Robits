extends MarginContainer

export(PackedScene) var map_screen

onready var bottom_hud = $HBoxContainer/VBoxContainer/Arcade_Bottom_HUD

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

signal use_credit(_player)

func _ready():
	var test1 = get_tree().get_current_scene().connect("coin_up", self, "init")
#	var test2 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
	var test2 = Menu_Hand.connect("input_to_screen", self, "movement")
	var test3 = self.connect("use_credit",get_tree().get_current_scene(),"use_credit")
	if test1 != 0:
		print("error in arcade start connect coin up")
	if test2 != 0:
		print("error in arcade start connect screen input")
	if test3 != 0:
		print("error in arcade start connect use credit")
	init()

func movement(_player, _dir):
#	print(_player,"    ", _dir)
	if _player == 1:
		if p1_has_credits:
			if _dir == 5:
				Player_Stats.p1["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 2:
		if p2_has_credits:
			if _dir == 5:
				Player_Stats.p2["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 3:
		if p3_has_credits:
			if _dir == 5:
				Player_Stats.p3["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 4:
		if p4_has_credits:
			if _dir == 5:
				Player_Stats.p4["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 5:
		if p5_has_credits:
			if _dir == 5:
				Player_Stats.p5["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 6:
		if p3_has_credits:
			if _dir == 5:
				Player_Stats.p6["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 7:
		if p4_has_credits:
			if _dir == 5:
				Player_Stats.p7["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 8:
		if p5_has_credits:
			if _dir == 5:
				Player_Stats.p8["in_play"] = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	else:
		print("error invald player in arcade start")
	init()


func init(): # _player1, _player2, _player3, _player4, _player5):
	if Player_Stats.p1["credit"] >= 1: #get_tree().get_current_scene().p1_credits >= 1:
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