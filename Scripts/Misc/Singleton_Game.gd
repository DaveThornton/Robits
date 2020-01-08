extends Node2D
export(PackedScene) var start_screen
#export(PackedScene) var m01_VS
onready var timer = $Timer
var mode
var over = false
var end_game_score = 1

func _ready():
	get_tree().get_current_scene().connect("reset", self, "reset")

func set_game_over(_over):
	over = _over
	if _over:
		Map_Hand.clear_map()
		HUD.game_over()
		timer.start()

func set_mode(_mode):
	mode.call_deferred("free")
	#make a instance and all that shit then set it bu ttill then here you go the func is here
	mode = _mode

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset():
	set_game_over(false)

func _on_Timer_timeout():
	get_tree().get_current_scene().arcade_reset()
#	pass # Replace with function body.