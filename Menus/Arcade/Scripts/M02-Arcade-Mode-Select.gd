extends Node2D

export(PackedScene) var campaign
export(PackedScene) var settings_menu
export(PackedScene) var vs_mode
export var vs_song = 0
export var camp_song = 0
onready var menu = $menu_1X3_01
onready var label_camp = $Labels/Label1
onready var label_choose = $Labels/Label2
onready var label_vs = $Labels/Label3
onready var label_text = $Labels/Label4

var p1_ready = false
var p2_ready = false
var p3_ready = false
var p4_ready = false
var p5_ready = false
var p6_ready = false
var p7_ready = false
var p8_ready = false
var des_camp = "play the campaign to free the robits from their current oppression and fight to see who can get the high score"
var des_choose = "make a selection"
var des_vs_yes = "fight head to head in an up to a 8 player melee"
var des_vs_no = "this selection requires addtional players"

var menu_pos = 2

func _ready():
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print_debug("error in arcade game select connect input to screen")
	var test2 = Player_Stats.connect("player_count_change",self,"menu_pos_changed")
	if test2 != 0:
		print_debug("error in arcade game select connect player_count_change")
	HUD.menu_state()

func _start(_player):
	if menu_pos == 1:
		SFX.music(true, camp_song)
		SFX.menu(2)
		Game.set_mode(0)
		Settings.set_campaign_start_gun(false)
		HUD.load_screen(campaign)
		Campaign.add_player(_player)
		call_deferred("free")
	elif menu_pos == 2:
		if _player == 1:
			HUD.load_screen(settings_menu)
			call_deferred("free")
		else:
			SFX.menu(3)
	elif menu_pos == 3:
		if Player_Stats.get_num_in_play() > 1:
			SFX.music(true, vs_song)
			SFX.menu(2)
			Game.set_mode(2)
			HUD.load_screen(vs_mode)
			call_deferred("free")
		else:
			SFX.menu(3)

func menu_pos_changed():
	menu_pos = menu.pos
	if menu_pos == 2:
		label_text.text = des_choose
	elif menu_pos == 1:
		label_text.text = des_camp
	elif menu_pos == 3 && Player_Stats.get_num_in_play() > 1:
		label_text.text = des_vs_yes
	elif menu_pos == 3 && Player_Stats.get_num_in_play() <= 1:
		label_text.text = des_vs_no
	print_debug(Player_Stats.get_num_in_play())

func movement(_player, _dir):
	if _player > 0 && _player < (Settings.get_max_num_players() + 1):
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
				elif _dir == 5 || 6 || 7 || 8:
					menu_pos = menu.pos
					_start(_player)

		elif Player_Stats.get_credit(_player) >= 1 && _dir == 0: 
			Player_Stats.use_credit(_player)
			HUD.player_select(_player)
		else:
			HUD.ask_insert_coin(_player)
	else:
		print_debug("error invald player in arcade player select VS")
	menu_pos_changed()

func get_ready(_player):
	if _player == 1:
		return p1_ready
	elif _player == 2:
		return p2_ready
	elif _player == 3:
		return p3_ready
	elif _player == 4:
		return p4_ready
	elif _player == 5:
		return p5_ready
	elif _player == 6:
		return p6_ready
	elif _player == 7:
		return p7_ready
	elif _player == 8:
		return p8_ready
