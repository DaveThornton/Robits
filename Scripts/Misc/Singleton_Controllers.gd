extends Node2D

export(PackedScene) var player_controller
#export(PackedScene) var net_controller

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
		print("error Singleton Controller connecting Player Controller to reset from world gd")
	
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
	z.init(player_num)#, _auto_respawn, Game.mode, play_type)

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
		print("error in controllers singleton get controller invalid number")
