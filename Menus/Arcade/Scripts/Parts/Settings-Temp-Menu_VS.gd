extends Node2D

onready var top_stock_label = $VBoxContainer/Label_01
onready var top_score_label = $VBoxContainer/Label_02
onready var top_time_label = $VBoxContainer/Label_03
onready var top_stock_square = $ReferenceRect_Stock
onready var top_score_square = $ReferenceRect_Score
onready var top_time_square = $ReferenceRect_Time

onready var bot_stock_label = $VBoxContainer/HBoxContainer2/Label_Stock2
onready var bot_stock_count = $VBoxContainer/HBoxContainer2/Label_Stock3
onready var stock_slider = $VBoxContainer/HBoxContainer2/HSlider

onready var bot_score_label = $VBoxContainer/HBoxContainer3/Label_Score2
onready var bot_score_count = $VBoxContainer/HBoxContainer3/Label_Score3
onready var score_slider = $VBoxContainer/HBoxContainer3/HSlider

onready var bot_time_label = $VBoxContainer/HBoxContainer4/Label_Time2
onready var bot_time_count = $VBoxContainer/HBoxContainer4/Label_Time3
onready var time_slider = $VBoxContainer/HBoxContainer4/HSlider

onready var dom_label = $VBoxContainer/HBoxContainer5/Label_Death_Minus
onready var dom_yes = $VBoxContainer/HBoxContainer5/Label_Death_Minus_Yes
onready var dom_no = $VBoxContainer/HBoxContainer5/Label_Death_Minus_No

onready var swg_label = $VBoxContainer/HBoxContainer6/Label_Start_Gun
onready var swg_yes = $VBoxContainer/HBoxContainer6/Label_Start_Gun_Yes
onready var swg_no = $VBoxContainer/HBoxContainer6/Label_Start_Gun_No

onready var row_01 = $VBoxContainer/HBoxContainer
onready var row_02 = $VBoxContainer/HBoxContainer2
onready var row_03 = $VBoxContainer/HBoxContainer3
onready var row_04 = $VBoxContainer/HBoxContainer4
onready var row_05 = $VBoxContainer/HBoxContainer5
onready var row_06 = $VBoxContainer/HBoxContainer6

export var selected_color = Color8(255,255,255,255)

var menu_pos = 0
var game_mode = 0 #  2 VS score | 3 VS time |4 VS Stock
var mod = false
var start_with_gun = false
var white = Color8(255,255,255,255)
var parent_menu

func _ready():
	game_mode = Game.get_mode()
	mod = Settings.get_multi_minus_on_death()
	start_with_gun = Settings.get_multi_start_gun()
	display_game_mode()
	stock_slider.value = Settings.get_multi_lives()
	score_slider.value = Settings.get_multi_score_to_win()
	time_slider.value = Settings.get_multi_time()
	display_minus_on_death()
	display_start_gun()

func up():
	if menu_pos <= 1:
		parent_menu.back_to_top()
		menu_pos -= 1
		menu_update()
	else:
		menu_pos -= 1
		menu_update()

func down():
	if menu_pos >= 6:
		SFX.menu(3)
	else:
		menu_pos += 1
		menu_update()

func left():
	if menu_pos == 1:
		if game_mode ==4:
			SFX.menu(3)
		elif game_mode == 2:
			set_game_mode(4)
		elif game_mode == 3:
			set_game_mode(2)
	elif menu_pos == 2:
		if stock_slider.min_value <= stock_slider.value:
			stock_slider.value -= 1
		else:
			SFX.menu(3)
	elif menu_pos == 3:
		if score_slider.min_value <= score_slider.value:
			score_slider.value -= 1
		else:
			SFX.menu(3)
	elif menu_pos == 4:
		if time_slider.min_value <= time_slider.value:
			time_slider.value -= 1
		else:
			SFX.menu(3)
	elif menu_pos == 5:
		if mod == true:
			SFX.menu(3)
		else:
			set_minus_on_death(true)
	elif menu_pos == 6:
		if start_with_gun == true:
			SFX.menu(3)
		else:
			set_start_gun(true)
	else:
		print_debug("error in settings temp menu vs wrong menu pos left")

func right():
	if menu_pos == 1:
		if game_mode ==3:
			SFX.menu(3)
		elif game_mode == 2:
			set_game_mode(3)
		elif game_mode == 4:
			set_game_mode(2)
	elif menu_pos == 2:
		if stock_slider.max_value >= stock_slider.value:
			stock_slider.value += 1
		else:
			SFX.menu(3)
	elif menu_pos == 3:
		if score_slider.max_value >= score_slider.value:
			score_slider.value += 1
		else:
			SFX.menu(3)
	elif menu_pos == 4:
		if time_slider.max_value >= time_slider.value:
			time_slider.value += 1
		else:
			SFX.menu(3)
	elif menu_pos == 5:
		if mod == true:
			set_minus_on_death(false)
		else:
			SFX.menu(3)
	elif menu_pos == 6:
		if start_with_gun == false:
			SFX.menu(3)
		else:
			set_start_gun(false)
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
	elif menu_pos == 3:
		row_03.modulate = selected_color
	elif menu_pos == 4:
		row_04.modulate = selected_color
	elif menu_pos == 5:
		row_05.modulate = selected_color
	elif menu_pos == 6:
		row_06.modulate = selected_color
	else:
		print_debug("error in settings temp menu vs wrong menu pos menu update")

func white_out():
	row_01.modulate = white
	row_02.modulate = white
	row_03.modulate = white
	row_04.modulate = white
	row_05.modulate = white
	row_06.modulate = white


func set_game_mode(_num):
	game_mode = _num
	Game.set_mode(_num)
	display_game_mode()

func display_game_mode():
	if game_mode == 2:
		top_stock_square.visible = false
		top_score_square.visible = true
		top_time_square.visible = false
	elif game_mode == 3:
		top_stock_square.visible = false
		top_score_square.visible = false
		top_time_square.visible = true
	elif game_mode == 4:
		top_stock_square.visible = true
		top_score_square.visible = false
		top_time_square.visible = false
	else:
		print_debug("this is worong game mode error setting to stock")
		set_game_mode(4)


func add_stock_slider(_amount):
	stock_slider.value += _amount

func _on_HSlider_Stock_value_changed(value:float):
	Settings.set_multi_lives(int(value))
	bot_stock_count.text = str(value)


func add_score_slider(_amount):
	score_slider.value += _amount

func _on_HSlider_Score_value_changed(value:float):
	Settings.set_multi_score_to_win(int(value))
	bot_score_count.text = str(value)


func add_time_slider(_amount):
	time_slider.value += _amount

func _on_HSlider_Time_value_changed(value:float):
	Settings.set_multi_time(int(value))
	bot_time_count.text = str(value)


func set_minus_on_death(_mod):
	mod = _mod
	Settings.set_multi_minus_on_death(mod)
	display_minus_on_death()

func display_minus_on_death():
	if mod:
		dom_yes.visible = true
		dom_no.visible = false
	else:
		dom_yes.visible = false
		dom_no.visible = true


func set_start_gun(_start):
	start_with_gun = _start
	Settings.set_multi_start_gun(start_with_gun)
	display_start_gun()

func display_start_gun():
	if start_with_gun:
		swg_yes.visible = true
		swg_no.visible = false
	else:
		swg_yes.visible = false
		swg_no.visible = true

func set_selection_color(_color):
	selected_color = _color
	menu_update()