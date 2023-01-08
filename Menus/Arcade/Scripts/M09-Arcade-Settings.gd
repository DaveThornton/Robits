extends Node2D

const SAVE_FILE = "user://Robit_Settings.save"


export(PackedScene) var next_screen
onready var top_menu = $Top_Menu_Select
onready var vs_menu = $Menu_VS_Settings
onready var camp_menu = $Menu_Campaign_Settings
onready var audio_menu = $Menu_Audio_Settings
onready var video_menu = $Menu_Video_Settings
onready var place_holder = $Menu_Exit_Settings

export var selection_color = Color8(255,255,255,255)

var game_data = {}
var top_menu_on = true

var menu_pos = 0
var current_menu

func _ready():
	var test3 = HUD.connect("input_to_screen", self, "movement")
	if test3 != 0:
		print_debug("error in arcade game select connect input to screen")
	menu_update()
	top_menu.set_selection_color(selection_color)
	vs_menu.set_selection_color(selection_color)
	camp_menu.set_selection_color(selection_color)
	audio_menu.set_selection_color(selection_color)
	video_menu.set_selection_color(selection_color)
	place_holder.set_selection_color(selection_color)

func back_to_top():
	top_menu_on = true

func off_top():
	top_menu_on = false

func movement(_player, _dir):
	if _player == 1:
		if top_menu_on:
			if _dir == 1:#up
				SFX.menu(3)
			
			elif _dir == 2:#left
				if menu_pos <= 0:
					SFX.menu(3)
				else:
					menu_pos -= 1
					menu_update()
			
			elif _dir == 3:#right
				if menu_pos >= 4:
					SFX.menu(3)
				else:
					menu_pos += 1
					menu_update()

			elif _dir == 4:#down
				in_to_menu()
	
		else:
			if _dir == 1:
				current_menu.up()
			elif _dir == 2:
				current_menu.left()
			elif _dir == 3:
				current_menu.right()
			elif _dir == 4:
				current_menu.down()
			elif _dir == 5 || 6 || 7 || 8:
				pass
			# menu_pos = menu.pos
			# _start(_player)

	# 	elif Player_Stats.get_credit(_player) >= 1 && _dir == 0: 
	# 		Player_Stats.use_credit(_player)
	# 		HUD.player_select(_player)
	# 	else:
	# 		HUD.ask_insert_coin(_player)
	# else:
	# 	print_debug("error invald player in arcade player select VS")
	# menu_pos_changed()

func in_to_menu():
	off_top()
	current_menu.in_to_menu(self)

func menu_update():
	all_out()
	top_menu.selection(menu_pos)
	if menu_pos == 0:
		current_menu = vs_menu
	elif menu_pos == 1:
		current_menu = camp_menu
	elif menu_pos == 2:
		current_menu = audio_menu	
	elif menu_pos == 3:
		current_menu = video_menu	
	elif menu_pos == 4:
		current_menu = place_holder	
	current_menu.visible = true

func all_out():
	vs_menu.visible = false
	camp_menu.visible = false
	audio_menu.visible = false
	video_menu.visible = false
	place_holder.visible = false

func get_ready(_player):
	if _player == 1:
		return false

func save_data():
	var file = File.new()
	file.open(SAVE_FILE,File.WRITE)
	get_data()
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	vs_menu.load_data(game_data["vs_menu"])
	camp_menu.load_data(game_data["camp_menu"])
	audio_menu.load_data(game_data["audio_menu"])
	video_menu.load_data(game_data["video_menu"])
	
func get_data():
	game_data = {
		"vs_menu": vs_menu.get_data_vars(),
		"camp_menu": camp_menu.get_data_vars(),
		"audio_menu": audio_menu.get_data_vars(),
		"video_menu": video_menu.get_data_vars()
	}

func exit():
	call_deferred("queue_free")
