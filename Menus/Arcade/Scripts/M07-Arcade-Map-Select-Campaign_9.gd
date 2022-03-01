extends Node2D

onready var maps_menu = $Menu_3x3_Maps
onready var p1_menu = $Menu_3x3_01
onready var p2_menu = $Menu_3x3_02
onready var p3_menu = $Menu_3x3_03
onready var p4_menu = $Menu_3x3_04
onready var p5_menu = $Menu_3x3_05
onready var p6_menu = $Menu_3x3_06
onready var p7_menu = $Menu_3x3_07
onready var p8_menu = $Menu_3x3_08

onready var upper_text = $Label_Top
onready var lower_text = $Label_Bot

var started = false
var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false
var player = 0
var pos = 5

func _ready():
	player = Campaign.get_player_in_control()
	var test1 = Map_Hand.connect("splash_done",self,"set_started")
	if test1 != 0:
		print("error in arcade map select campaign connect to maphand splash done")
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print("error M07 Arcade map select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print("error in arcade map select campaign connect input to screen")
	show_player(player)

func _start(_player):
	_set_ready(_player)
	HUD.set_pri(_player, 5)
	SFX.menu(3)
	_next_screen()

func _next_screen():
	var map_to_load = Campaign.get_map(pos)
	var t1 = Campaign.get_map_title(pos)
	var t2 = Campaign.get_map_discription(pos)
	Map_Hand.load_map_cam_first(map_to_load,t1,t2,1,true)
	Game.started = true
	call_deferred("free")

func update_pos(_pos):
	upper_text.text = Campaign.get_map_title(_pos)
	lower_text.text = Campaign.get_map_discription(_pos)
	maps_menu.update_pos(_pos)
	pos = _pos

func movement(_player, _dir):
	if started:
		if player == _player:
			if Player_Stats.get_in_play(_player):
				if !get_ready(_player):
					if _dir == 1:
						get_menu(_player).move_up()
					elif _dir == 2:
						get_menu(_player).move_left()
					elif _dir == 3:
						get_menu(_player).move_right()
					elif _dir == 4:
						get_menu(_player).move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6: #|| 7 || 8:
						_start(_player)
				else:
					print("player is already ready in M07 movement")
			else:
				print("control player isnt in play M07 movement")
				if Player_Stats.get_credit(_player) >= 1 && _dir == 0:
					Player_Stats.use_credit(_player)
					HUD.player_select(_player)
				elif _dir == 0:
					HUD.ask_insert_coin(_player)
		else:
			if !Player_Stats.get_in_play(_player):
				if Player_Stats.get_credit(_player) >= 1 && _dir == 0:
					Player_Stats.use_credit(_player)
					HUD.player_select(_player)
				elif _dir == 0:
					HUD.ask_insert_coin(_player)

func set_started():
	started = true

func show_player(_player):
	p1_menu.visible = false
	p2_menu.visible = false
	p3_menu.visible = false
	p4_menu.visible = false
	p5_menu.visible = false
	p6_menu.visible = false
	p7_menu.visible = false
	p8_menu.visible = false
	if _player == 1:
		p1_menu.visible = true
	elif _player == 2:
		p2_menu.visible = true
	elif _player == 3:
		p3_menu.visible = true
	elif _player == 4:
		p4_menu.visible = true
	elif _player == 5:
		p5_menu.visible = true
	elif _player == 6:
		p6_menu.visible = true
	elif _player == 7:
		p7_menu.visible = true
	elif _player == 8:
		p8_menu.visible = true

func _set_ready(_player):
	if _player == 1:
		p1_ready = true
	elif _player == 2:
		p2_ready = true
	elif _player == 3:
		p3_ready = true
	elif _player == 4:
		p4_ready = true
	elif _player == 5:
		p5_ready = true
	elif _player == 6:
		p6_ready = true
	elif _player == 7:
		p7_ready = true
	elif _player == 8:
		p8_ready = true
	# _vote(_player)
	
func get_menu(_num):
	if _num == 1:
		return p1_menu
	elif _num == 2:
		return p2_menu
	elif _num == 3:
		return p3_menu
	elif _num == 4:
		return p4_menu
	elif _num == 5:
		return p5_menu
	elif _num == 6:
		return p6_menu
	elif _num == 7:
		return p7_menu
	elif _num == 8:
		return p8_menu

func get_ready(_num):
	if _num == 1:
		return p1_ready
	elif _num == 2:
		return p2_ready
	elif _num == 3:
		return p3_ready
	elif _num == 4:
		return p4_ready
	elif _num == 5:
		return p5_ready
	elif _num == 6:
		return p6_ready
	elif _num == 7:
		return p7_ready
	elif _num == 8:
		return p8_ready
