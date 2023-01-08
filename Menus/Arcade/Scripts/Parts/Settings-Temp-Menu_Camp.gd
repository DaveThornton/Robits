extends Node2D

onready var top_easy_label = $VBoxContainer/Label_01
onready var top_med_label = $VBoxContainer/Label_02
onready var top_hard_label = $VBoxContainer/Label_03
onready var top_easy_square = $ReferenceRect_Stock
onready var top_med_square = $ReferenceRect_Score
onready var top_hard_square = $ReferenceRect_Time

onready var bot_stock_label = $VBoxContainer/HBoxContainer2/Label_Stock2
onready var bot_stock_count = $VBoxContainer/HBoxContainer2/Label_Stock3
onready var stock_slider = $VBoxContainer/HBoxContainer2/HSlider

onready var row_01 = $VBoxContainer/HBoxContainer
onready var row_02 = $VBoxContainer/HBoxContainer2

export var selected_color = Color8(255,255,255,255)

var difficulty = 2 #1 Easy ||2 Med || 3 Hard
var menu_pos = 0
var white = Color8(255,255,255,255)
var parent_menu

func _ready():
	stock_slider.value = Settings.get_multi_lives()
	display_difficulty()

func up():
	if menu_pos <= 1:
		parent_menu.back_to_top()
		menu_pos -= 1
		menu_update()
	else:
		menu_pos -= 1
		menu_update()

func down():
	if menu_pos >= 2:
		SFX.menu(3)
	else:
		menu_pos += 1
		menu_update()

func left():
	if menu_pos == 1:
		if difficulty ==1:
			SFX.menu(3)
		elif difficulty == 2:
			set_difficulty(1)
		elif difficulty == 3:
			set_difficulty(2)
	elif menu_pos == 2:
		if stock_slider.min_value <= stock_slider.value:
			stock_slider.value -= 1
		else:
			SFX.menu(3)
	else:
		print_debug("error in settings temp menu vs wrong menu pos left")

func right():
	if menu_pos == 1:
		if difficulty ==3:
			SFX.menu(3)
		elif difficulty == 2:
			set_difficulty(3)
		elif difficulty == 1:
			set_difficulty(2)
	elif menu_pos == 2:
		if stock_slider.max_value >= stock_slider.value:
			stock_slider.value += 1
		else:
			SFX.menu(3)
	else:
		print_debug("error in settings temp menu vs wrong menu pos right")


func in_to_menu(_parent_menu):
	parent_menu = _parent_menu
	menu_pos = 1
	menu_update()

func menu_update():
	white_out()
	if menu_pos == 0:
		pass
	elif menu_pos == 1:
		row_01.modulate = selected_color
	elif menu_pos == 2:
		row_02.modulate = selected_color
	else:
		print_debug("error in settings temp menu camp wrong menu pos menu update")

func white_out():
	row_01.modulate = white
	row_02.modulate = white
	
func set_difficulty(_num):
	difficulty = _num
	print_debug("this does nothing you havent made one difficulty let alone 3")
	display_difficulty()

func display_difficulty():
	if difficulty == 1:
		top_easy_square.visible = true
		top_med_square.visible = false
		top_hard_square.visible = false
	elif difficulty == 2:
		top_easy_square.visible = false
		top_med_square.visible = true
		top_hard_square.visible = false
	elif difficulty == 3:
		top_easy_square.visible = false
		top_med_square.visible = false
		top_hard_square.visible = true
	else:
		print_debug("this is worong difficulty error setting")


func add_stock_slider(_amount):
	stock_slider.value += _amount

func _on_HSlider_Stock_value_changed(value:float):
	Settings.set_lives_per_credit(int(value))
	bot_stock_count.text = str(value)

func get_data_vars():
	var camp_data = [
		stock_slider.value
	]
	return camp_data

func load_data(_camp_data):
	if _camp_data.size() < 2:
		stock_slider.value = _camp_data.pop_back()
	else:
		print_debug("error loading camp saves to few vars in the array")

func set_selection_color(_color):
	selected_color = _color
	menu_update()