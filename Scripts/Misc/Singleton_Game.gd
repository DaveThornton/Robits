extends Node2D

export(PackedScene) var start_screen

onready var timer = $Timer

var game_started = false
var start_equipped = false
var game_mode = 2 # 0 Campaign safety on | 1 Campaign safety off | 2 VS score | 3 VS time |4 VS Stock
var game_over = false
# var end_game_score = 10

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error Singleton Game connecting to reset from world gd")

func start(_players):
	for j in range(_players):
		Controllers.spawn_player_contoller(j+1)#, true)

func spawn_started():
	game_started = true
	if Player_Stats.p1["in_play"]:
		Controllers.p1.spawn_pawn()
	if Player_Stats.p2["in_play"]:
		Controllers.p2.spawn_pawn()
	if Player_Stats.p3["in_play"]:
		Controllers.p3.spawn_pawn()
	if Player_Stats.p4["in_play"]:
		Controllers.p4.spawn_pawn()
	if Player_Stats.p5["in_play"]:
		Controllers.p5.spawn_pawn()
	if Player_Stats.p6["in_play"]:
		Controllers.p6.spawn_pawn()
	if Player_Stats.p7["in_play"]:
		Controllers.p7.spawn_pawn()
	if Player_Stats.p8["in_play"]:
		Controllers.p8.spawn_pawn()

func set_started(_started):
	game_started = _started

func get_started():
	return game_started


func set_game_over(_over):
	game_over = _over
	FX.add_trauma(100)
	if game_over && game_mode > 0:
		Map_Hand.clear_map()
		HUD.state_machine()
		HUD.start_count()
		# timer.start()
	elif game_over && game_mode == 0:
		HUD.state_machine()
		print_debug("game over in game for campaign and nothing?")
		timer.start()

func get_game_over():
	return game_over


func set_mode(_mode):
	game_mode = _mode

func get_mode():
	return game_mode


func set_start_equiped(_eq):
	start_equipped = _eq

func get_start_equipped():
	return start_equipped


func check_over():
	if game_mode == 2 :
		print_debug("check over mode 2 in game singleton")
		var _end_game_score = Settings.get_multi_score_to_win()
		if Player_Stats.p1["score"] >= _end_game_score || Player_Stats.p2["score"] >= _end_game_score || Player_Stats.p3["score"] >= _end_game_score || Player_Stats.p4["score"] >= _end_game_score || Player_Stats.p5["score"] >= _end_game_score || Player_Stats.p6["score"] >= _end_game_score || Player_Stats.p7["score"] >= _end_game_score || Player_Stats.p8["score"] >= _end_game_score:
			set_game_over(true)
	elif game_mode <= 1 :
		print_debug("check over mode 0 in game singleton")
		if Player_Stats.get_num_in_game() == 0:
			set_game_over(true)
	elif game_mode == 3:
		print_debug("this mode is not ready for a game over please fix in Singleton Game Mode is ", game_mode)
	elif game_mode == 4:
		print_debug("this mode is not ready for a game over please fix in Singleton Game Mode is ", game_mode)
	else:
		print_debug("check over mode wrong in game singleton havent made game type ", game_mode)

# TODO: fix this
func use_lives():
	print_debug("use lives called in singleton game but dont think it is being used corrent take a look at it")
	if game_mode < 1:
		HUD.show_lives(true)
		return true
	else:
		HUD.show_lives(false)
		return false

func get_start_screen():
	return start_screen

func reset():
	FX.CAMERA.reset()
	game_started = false
	set_game_over(false)

func _on_Timer_timeout():
	if game_mode == 0 && game_over:
		print_debug("timer out in game for mode 0 and over")
		
	elif game_mode > 0 && game_over:
		get_tree().get_current_scene().arcade_reset()
