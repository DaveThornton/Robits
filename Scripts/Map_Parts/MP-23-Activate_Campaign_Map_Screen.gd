extends Area2D

export var activation_num = 4
export(PackedScene) var camp_map_screen
export var splash_time = 5
export var top = "top text"
export var bot = "bottom text"
export var complete_what_level = 0

func _ready():
	var map_connected = Map_Hand.map.connect("activate", self, "activate")
	if !map_connected:
		print_debug("error in MP 23 not connecting to map")

func set_complete_what_level(world_num):
	complete_what_level = world_num

func _on_MP23Activate_Campaign_Map_Screen_body_entered(body:Node):
	if body.get_groups().has("player"):
		complete_what_level = Map_Hand.get_map().get_world_map_num().x
		Campaign.complete_level(complete_what_level)
		Campaign.set_player_in_control(body.get_player_num())
		Map_Hand.splash_w_timer(top,bot,splash_time)
		HUD.load_screen(camp_map_screen)
		Game.set_started(false)
		Controllers.clear_pawns()
		Player_Stats.set_all_in_game(false)
		HUD.set_mode(1)
		FX.set_back(0)
		Map_Hand.clear_map()


	pass # Replace with function body.
