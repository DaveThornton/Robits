extends Node2D

onready var maps_menu = $Menu_3x3_Maps
onready var menu = $Menu_3x3_01

onready var upper_text = $Label_Top
onready var lower_text = $Label_Bot

var spot_5_locked = true

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
var spots

func _ready():
	player = Campaign.get_player_in_control()
	set_spots(Campaign.get_level_comp_array())
	var test1 = Map_Hand.connect("splash_done",self,"set_started")
	if test1 != 0:
		print_debug("error in arcade map select campaign connect to maphand splash done")
	var test2 = HUD.connect("screen_update", self, "menu_check")
	if test2 != 0:
		print_debug("error M07 Arcade map select connecting next_screen")
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print_debug("error in arcade map select campaign connect input to screen")
	show_player(player)
	print_debug("completion count in campaign is ", Campaign.get_level_comp_count())
	if Campaign.get_level_comp_count() >= 9:
		spot_5_locked = false
		maps_menu.set_spot05_locked(false)
	else:
		spot_5_locked = true
		maps_menu.set_spot05_locked(true)

func _start(_player):
	if pos == 5 && spot_5_locked:
		SFX.menu(3)
	elif !spots[pos]:
		_set_ready(_player)
		HUD.set_pri(_player, 5)
		SFX.menu(1)
		_next_screen()
	else:
		SFX.menu(3)

func _next_screen():
	var map_to_load = Campaign.get_map(pos, 0)
	var t1 = Campaign.get_map_title(pos)
	var t2 = Campaign.get_map_discription(pos)
	Map_Hand.load_map_cam_first(map_to_load,t1,t2,1,true)
	Game.set_started(true)
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
						menu.move_up()
					elif _dir == 2:
						menu.move_left()
					elif _dir == 3:
						menu.move_right()
					elif _dir == 4:
						menu.move_down()
					elif _dir == 0 || _dir == 5 || _dir == 6:
						_start(_player)
				else:
					print_debug("player is already ready in M07 movement")
			else:
				print_debug("control player isnt in play M07 movement")
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
	menu.modulate = Player_Stats.get_body_color(_player)

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

func set_spots(_spots):
	spots = _spots
	maps_menu.update_spots(spots)

func get_level_comp(_num):
	return !spots[_num]
