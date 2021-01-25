extends Node2D

export(PackedScene) var start_screen

onready var timer = $Timer

var started = false
var start_eq = false
#var mode_vs = true
var mode = 0 # 0 campaign | 1 lives | 2 score | 3 time
var over = false
var end_game_score = 10

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error Singleton Game connecting to reset from world gd")

func start(_players):
	for j in range(_players):
		Controllers.spawn_player_contoller(j+1)#, true)

func spawn_started():
	started = true
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

func set_game_over(_over):
	over = _over
	FX.add_trauma(500)
	if over && mode > 0:
		Map_Hand.clear_map()
		HUD.state_machine()
		timer.start()
	elif over && mode == 0:
		HUD.state_machine()
#		High_Score.set_visible(true)
		print("game over in game for campaign and nothing?")
		timer.start()

func check_over():
	if mode == 2 :
		print("check over mode 2 in game singleton")
		if Player_Stats.p1["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p2["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p3["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p4["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p5["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p6["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p7["score"] >= end_game_score:
			set_game_over(true)
		elif Player_Stats.p8["score"] >= end_game_score:
			set_game_over(true)
	elif mode == 0:
		print("check over mode 0 in game singleton")
#		var num_in_play = Player_Stats.get_num_in_play()
		if Player_Stats.get_num_in_game() == 0:
#			High_Score.set_visible(true)
			set_game_over(true)
	else:
		print("check over mode wrong in game singleton havent made game type ", mode)

func use_lives():
	if mode < 1:
		HUD.show_lives(true)
		return true
	else:
		HUD.show_lives(false)
		return false

func get_start_screen():
	return start_screen

func reset():
	FX.CAMERA.reset()
	started = false
	set_game_over(false)

func _on_Timer_timeout():
	if mode == 0 && over:
		print("timer out in game for mode 0 and over")
		
	elif mode > 0 && over:
		get_tree().get_current_scene().arcade_reset()
