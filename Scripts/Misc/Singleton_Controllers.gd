extends Node2D

export(PackedScene) var player_controller

onready var players = $Players

var p1
var p2
var p3
var p4
var p5
var p6
var p7
var p8

func spawn_player_contoller(player_num: int):#, _auto_respawn):
	var z = player_controller.instance()
	players.add_child(z)
	var test = get_tree().get_current_scene().connect("reset", z, "reset")
	if test != 0:
		print_debug("error Singleton Controller connecting Player Controller to reset from world gd")
	
	if player_num == 1:
		p1 = z
	elif player_num == 2:
		p2 = z
	elif player_num == 3:
		p3 = z
	elif player_num == 4:
		p4 = z
	elif player_num == 5:
		p5 = z
	elif player_num == 6:
		p6 = z
	elif player_num == 7:
		p7 = z
	elif player_num == 8:
		p8 = z
	z.init(player_num)

func get_pawn(_player: int):
	if _player == 1:
		return p1.get_pawn()
	elif _player == 2:
		return p2.get_pawn()
	elif _player == 3:
		return p3.get_pawn()
	elif _player == 4:
		return p4.get_pawn()
	elif _player == 5:
		return p5.get_pawn()
	elif _player == 6:
		return p6.get_pawn()
	elif _player == 7:
		return p7.get_pawn()
	elif _player == 8:
		return p8.get_pawn()

func get_controller(_num: int):
	if _num == 1:
		return p1
	elif _num == 2:
		return p2
	elif _num == 3:
		return p3
	elif _num == 4:
		return p4
	elif _num == 5:
		return p5
	elif _num == 6:
		return p6
	elif _num == 7:
		return p7
	elif _num == 8:
		return p8
	else:
		print_debug("error in controllers singleton get controller invalid number")

func player_equip_start_weap(_player):
	if _player == 1:
		p1.player_equip_start_weap()
	elif _player == 2:
		p2.player_equip_start_weap()
	elif _player == 3:
		p3.player_equip_start_weap()
	elif _player == 4:
		p4.player_equip_start_weap()
	elif _player == 5:
		p5.player_equip_start_weap()
	elif _player == 6:
		p6.player_equip_start_weap()
	elif _player == 7:
		p7.player_equip_start_weap()
	elif _player == 8:
		p8.player_equip_start_weap()
	else:
		print_debug("invalid player number in singlton controllers player_equip_start_weap player #: " ,_player)

func player_remove_start_weap(_player):
	if _player == 1:
		p1.player_remove_start_weap()
	elif _player == 2:
		p2.player_remove_start_weap()
	elif _player == 3:
		p3.player_remove_start_weap()
	elif _player == 4:
		p4.player_remove_start_weap()
	elif _player == 5:
		p5.player_remove_start_weap()
	elif _player == 6:
		p6.player_remove_start_weap()
	elif _player == 7:
		p7.player_remove_start_weap()
	elif _player == 8:
		p8.player_remove_start_weap()
	else:
		print_debug("invalid player number in singlton controllers player_remove_start_weap player #: " ,_player)

func clear_pawns():
	if p1:
		p1.clear_pawn()
	if p2:
		p2.clear_pawn()
	if p3:
		p3.clear_pawn()
	if p4:
		p4.clear_pawn()
	if p5:
		p5.clear_pawn()
	if p6:
		p6.clear_pawn()
	if p7:
		p7.clear_pawn()
	if p8:
		p8.clear_pawn()
