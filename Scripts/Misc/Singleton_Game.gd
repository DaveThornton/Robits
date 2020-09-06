extends Node2D
export(PackedScene) var start_screen
onready var timer = $Timer
var started = false
var mode_vs = true
var over = false
var end_game_score = 3

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
	if over:
		Map_Hand.clear_map()
		HUD.state_machine()
		timer.start()

func check_over():
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

func get_start_screen():
	return start_screen

func reset():
	started = false
	set_game_over(false)

func _on_Timer_timeout():
	if over:
		get_tree().get_current_scene().arcade_reset()
