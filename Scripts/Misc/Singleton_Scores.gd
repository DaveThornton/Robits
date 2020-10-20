extends Node2D

onready var timer = $Timer
onready var list = $Scores
var score_file = "user://score.save"
var top10 = []
var place = ["DAVE", 10]
var last_place = 20

signal up
signal down
signal select
signal back


func _ready():
	for i in 10:
		top10.append(place)
#	print(top10)
	save_to_file()
#	load_from_file()
#	print(top10)
	list.update_scores(top10)

func add_score(_player:int, _name:String):
#	print("adding score in high scores")
	var _new_score = [_name, Player_Stats.get_score(_player),Player_Stats.get_pawn_num(_player),_player]
	top10.append(_new_score)
	top10.sort_custom(self, "sort_scores")
	top10.resize(10)
	save_to_file()
	list.update_scores(top10)
	if Player_Stats.get_all_done():
		timer.start()
#		get_tree().get_current_scene().arcade_reset()
#	print(top10)

func all_done(): 
	if top10.size() > 0: 
		if timer.is_stopped(): 
			print("all done triggered in high scores 10 sec to reset")
			timer.start()
		else: print("timer already triggered in high scores not calling for reset")

#func player_input(_player:int, _dir:int):
#	set_visible(true)
#	print(_player, " <-------- player         ( input on high score screen)        dir------>   ", _dir)
#	timer.start()
#	get_tree().get_current_scene().arcade_reset()

func save_to_file():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(top10, true)
	file.close()

func load_from_file():
	print("Load File")
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		top10 = file.get_var(true)
		file.close()
	else:
		save_to_file()

func is_score_high(_score:int):
	if top10.size() > 0:
		if _score == top10[-1][1] || _score < top10[-1][1]:
			return false
		else:
			var new_top10 = top10.duplicate(true)
			for p in Settings.max_num_of_player:
				var temp = ["temp", Player_Stats.get_score(p + 1)]
				new_top10.append(temp)
			new_top10.sort_custom(self, "sort_scores")
			new_top10.resize(10)
	#		new_top10.append(Player_Stats.get_score())
			if _score > new_top10[-1][1]:
				return true
			else: return false

func set_visible(_vis):
	position = FX.CAMERA.position
	self.visible = _vis

func get_visible():
	return self.visible

func sort_scores(a, b):
	if a[1] < b[1]:
		return false
	return true

func _on_Timer_timeout():
	if self.visible == true:
		print("reset in high scores singletion")
		set_visible(false)
		get_tree().get_current_scene().arcade_reset()
