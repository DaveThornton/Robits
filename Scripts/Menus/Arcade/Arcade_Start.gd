extends MarginContainer

export(PackedScene) var map_screen

onready var bottom_hud = $HBoxContainer/VBoxContainer/Arcade_Bottom_HUD

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

signal use_credit(_player)

func _ready():
	var test1 = get_tree().get_current_scene().connect("coin_up", self, "init")
	var test2 = get_tree().get_current_scene().connect("input_to_screen", self, "movement")
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
				get_tree().get_current_scene().p1_started = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 2:
		if p2_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p2_started = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 3:
		if p3_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p3_started = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 4:
		if p4_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p4_started = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	elif _player == 5:
		if p5_has_credits:
			if _dir == 5:
				get_tree().get_current_scene().p5_started = true
				emit_signal("use_credit",_player)
				get_tree().get_current_scene().load_screen(map_screen)
				queue_free()
	else:
		print("error invald player in arcade start")


func init(): # _player1, _player2, _player3, _player4, _player5):
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
	p1_started = get_tree().get_current_scene().p1_started
	p2_started = get_tree().get_current_scene().p2_started
	p3_started = get_tree().get_current_scene().p3_started
	p4_started = get_tree().get_current_scene().p4_started
	p5_started = get_tree().get_current_scene().p5_started
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