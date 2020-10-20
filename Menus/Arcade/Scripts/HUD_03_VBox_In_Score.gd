extends VBoxContainer

onready var player_num = $HBox_Player/Label_Player_Count
onready var name_box = $HUD_19_Name_Select
onready var score_label = $Label

var player = 0
var my_name = ""
var pri = 1
var sec = 0
var state = 0

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print("error name select in sore hud connecting to reset from world gd")

func set_state(_pri:int, _sec:int):
	pri = _pri
	sec = _sec
	update_state(_pri)

func set_state_pri(_pri:int):
	pri = _pri
	update_state(_pri)

func set_state_sec(_sec:int):
	sec = _sec

func player_num_update(_num:int):
	player_num.text = str(_num)
	player = _num

func update_state(_state:int):
	score_label.text = str(Player_Stats.get_score(player))

func up(): if name_box.visible: name_box.up()
func down(): if name_box.visible: name_box.down()
func select():
	print("select")
	if name_box.visible:
		print("name box visable = ", name_box.visible)
		if name_box.letter_count < 5:
			my_name = name_box.select()
			if name_box.letter_count == 5:
				submit_score()
func back(): if name_box.visible: name_box.back()

func submit_score():
	name_box.reset()
	print("submiting score in hud")
	name_box.letter_count += 1
	Player_Stats.set_done(player,true)
	High_Score.add_score(player, my_name)
	Player_Stats.reset_player(player)
	name_box.reset()
	is_vis(false)
	
func is_vis(_vis):
	name_box.visible = _vis
	score_label.visible = _vis

func _on_VBox_In_Score_visibility_changed():

	if High_Score.is_score_high(Player_Stats.get_score(player)):
		is_vis(true)
	else:
		Player_Stats.set_done(player,true)
		is_vis(false)
		if Player_Stats.get_all_done():
			High_Score.all_done()

func reset():
	pass
