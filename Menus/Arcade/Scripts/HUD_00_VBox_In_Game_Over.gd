extends VBoxContainer

onready var game_over_stats = $ScrollContainer/VBoxContainer/Player_End_VS_Stats
onready var kill_w_stats = $ScrollContainer/VBoxContainer/Kill_W_Weap_End_Stats
onready var kill_by_stats = $ScrollContainer/VBoxContainer/Kill_By_Weap_End_Stats
onready var kill_who_stats = $ScrollContainer/VBoxContainer/Killed_Who_End_Stats
onready var kill_by_who_stats = $ScrollContainer/VBoxContainer/Killed_By_Who_End_Stats
onready var distance_traveled_stats = $ScrollContainer/VBoxContainer/Distance_Traveled_Stats
onready var other_input_stats = $ScrollContainer/VBoxContainer/Other_Input_Stats
onready var damage_stats = $ScrollContainer/VBoxContainer/Damage_Stats
onready var power_up_stats = $ScrollContainer/VBoxContainer/Power_Up_Stats

onready var player_num_count = $HBox_Player/Label_Player_Count
onready var player_num_go = $HBox_Player
onready var player_done_go = $Label_Done
onready var scroll_box = $ScrollContainer

var game_done = false
var player = 0

func start():
	scroll_box.get_v_scrollbar().modulate = Color(0, 0, 0, 0)
	if Player_Stats.get_in_game(player):
		game_over_not_done()
		game_over_stats.update()
		kill_w_stats.update_stats(player)
		kill_by_stats.update_stats(player)
		kill_who_stats.update_stats(player)
		kill_by_who_stats.update_stats(player)
		distance_traveled_stats.update_stats(player)
		other_input_stats.update_stats(player)
		damage_stats.update_stats(player)
		power_up_stats.update_stats(player)
	else:
		not_in_game()

func up(): scroll_box.scroll_vertical -= 10
func down(): scroll_box.scroll_vertical += 10

func player_num_update(_num):
	player = _num
	player_num_count.text = str(_num)
	game_over_stats.set_player_num(_num)

func set_place(_place):
	var _place_name = Player_Stats.get_place_name(_place)
	game_over_stats.set_place_text(_place_name)

func not_in_game():
	player_done_go.visible = false
	player_num_go.visible = false
	game_over_stats.visible = false
	kill_w_stats.visible = false
	kill_by_stats.visible = false
	kill_who_stats.visible = false
	kill_by_who_stats.visible = false
	distance_traveled_stats.visible = false
	other_input_stats.visible = false
	damage_stats.visible = false
	power_up_stats.visible = false

func game_over_done():
	player_done_go.visible = true
	player_num_go.visible = true
	game_over_stats.visible = false
	kill_w_stats.visible = false
	kill_by_stats.visible = false
	kill_who_stats.visible = false
	kill_by_who_stats.visible = false
	distance_traveled_stats.visible = false
	other_input_stats.visible = false
	damage_stats.visible = false
	power_up_stats.visible = false
	Player_Stats.set_done(player,true)
	game_done = true

func game_over_not_done():
	player_done_go.visible = false
	player_num_go.visible = false
	game_over_stats.visible = true
	kill_w_stats.visible = true
	kill_by_stats.visible = true
	kill_who_stats.visible = true
	kill_by_who_stats.visible = true
	distance_traveled_stats.visible = true
	other_input_stats.visible = true
	damage_stats.visible = true
	power_up_stats.visible = true
	Player_Stats.set_done(player,false)
	game_done = false


func is_game_done():
	return game_done