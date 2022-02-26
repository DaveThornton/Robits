extends Node2D

export var activation_num = 10
export(PackedScene) var camp_map_screen
export var splash_time = 5
export var top = "top text"
export var bot = "bottom text"

func _ready():
	var map_connected = Map_Hand.map.connect("activate", self, "activate")
	if !map_connected:
		print("error in MP 23 not connecting to map")

func activate(_num,_body):
	if _num == activation_num:
		print(" tring to load map menu from in level MP 23")
		Map_Hand.splash_w_timer(top,bot,splash_time)
		# HUD.splash(top,bot,1,true)
		# HUD.splash("map screen","hope you see this", 1, true) #not working for some reason
		HUD.load_screen(camp_map_screen)
		Game.started = false
		# Player_Stats.set_all_in_play(false)
		Controllers.clear_pawns()
		Player_Stats.set_all_in_game(false)
		HUD.set_mode(1)
		FX.set_back(0)
		Map_Hand.clear_map()
		
