extends Node2D

onready var crt_label = $VBoxContainer/HBoxContainer/Label_CRT
onready var crt_on = $VBoxContainer/HBoxContainer/Label_CRT_On
onready var crt_off = $VBoxContainer/HBoxContainer/Label_CRT_Off

onready var static_label = $VBoxContainer/HBoxContainer2/Label_Static
onready var static_on = $VBoxContainer/HBoxContainer2/Label_Static_On
onready var static_off = $VBoxContainer/HBoxContainer2/Label_Static_Off

onready var juice_label = $VBoxContainer/HBoxContainer3/Label_Juice
onready var juice_on = $VBoxContainer/HBoxContainer3/Label_Juice_On
onready var juice_off = $VBoxContainer/HBoxContainer3/Label_Juice_Off

onready var static_min_count = $VBoxContainer/HBoxContainer4/Label_Static_Count
onready var static_min_slider = $VBoxContainer/HBoxContainer4/HSlider

onready var static_max_count = $VBoxContainer/HBoxContainer5/Label_Static_Count
onready var static_max_slider = $VBoxContainer/HBoxContainer5/HSlider

onready var juice_count = $VBoxContainer/HBoxContainer6/Label_juice_Count
onready var juice_slider = $VBoxContainer/HBoxContainer6/HSlider

onready var row_01 = $VBoxContainer/HBoxContainer
onready var row_02 = $VBoxContainer/HBoxContainer2
onready var row_03 = $VBoxContainer/HBoxContainer3
onready var row_04 = $VBoxContainer/HBoxContainer4
onready var row_05 = $VBoxContainer/HBoxContainer5
onready var row_06 = $VBoxContainer/HBoxContainer6

export var selected_color = Color8(255,255,255,255)

var menu_pos = 0
var crt_effect = false
var static_effect = false
var juice_effect = false
var white = Color8(255,255,255,255)
var parent_menu
var started = false

func _ready():
	crt_effect = FX.get_crt_status()
	show_crt(crt_effect)
	static_effect = FX.get_static_status()
	show_static(static_effect)
	juice_effect = false#-------------------fix this some day------------------
	show_juice(juice_effect)
	static_min_slider.value = FX.get_static_min()
	static_max_slider.value = FX.get_static_max()
	juice_slider.value = FX.CAMERA.get_juice_amount()
	static_min_count.text = str(static_min_slider.value)
	static_max_count.text = str(static_max_slider.value)
	juice_count.text = str(juice_slider.value)
	print_debug(static_min_slider.value,"   ", static_max_slider.value)
	started = true
	# game_mode = Game.get_mode()
	# mod = Settings.get_multi_minus_on_death()
	# start_with_gun = Settings.get_multi_start_gun()
	# display_game_mode()
	# stock_slider.value = Settings.get_multi_lives()
	# score_slider.value = Settings.get_multi_score_to_win()
	# time_slider.value = Settings.get_multi_time()
	# display_minus_on_death()
	# display_start_gun()

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
		if !crt_effect:
			crt_effect = true
			set_crt(crt_effect)
	elif menu_pos == 2:
		if !static_effect:
			static_effect = true
			set_static(static_effect)
	elif menu_pos == 3:
		if !juice_effect:
			juice_effect = true
			set_juice(juice_effect)
	elif menu_pos == 4:
		add_static_min_Slider(-1)
	elif menu_pos == 5:
		add_static_max_Slider(-1)
	elif menu_pos == 6:
		add_juice_Slider(-.05)
	else:
		print_debug("error in settings temp menu vs wrong menu pos left")

func right():
	if menu_pos == 1:
		if crt_effect:
			crt_effect = false
			set_crt(crt_effect)
	elif menu_pos == 2:
		if static_effect:
			static_effect = false
			set_static(static_effect)
	elif menu_pos == 3:
		if juice_effect:
			juice_effect = false
			set_juice(juice_effect)
	elif menu_pos == 4:
		add_static_min_Slider(+1)
	elif menu_pos == 5:
		add_static_max_Slider(+1)
	elif menu_pos == 6:
		add_juice_Slider(+.05)
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


func set_crt(_on):
	FX.crt(_on)
	show_crt(_on)

func show_crt(_on):
	if _on:
		crt_on.visible = true
		crt_off.visible = false
	else:
		crt_on.visible = false
		crt_off.visible = true

func set_static(_on):
	FX.screen_static(_on)
	show_static(_on)

func show_static(_on):
	if _on:
		static_on.visible = true
		static_off.visible = false
	else:
		static_on.visible = false
		static_off.visible = true

func set_juice(_on):
	FX.CAMERA.set_juice_on(_on)
	show_juice(_on)

func show_juice(_on):
	if _on:
		juice_on.visible = true
		juice_off.visible = false
	else:
		juice_on.visible = false
		juice_off.visible = true

func add_static_min_Slider(_amount):
	if static_min_slider.min_value <= static_min_slider.value:
		static_min_slider.value += _amount
	else:
		SFX.menu(3)

func _on_HSlider_Static_min_value_changed(value:float):
	if started:
		FX.CAMERA.set_min_static(value)
		static_min_count.text = str(value)
		if value > static_max_slider.value:
			static_max_slider.value = static_min_slider.value

func add_static_max_Slider(_amount):
	if static_max_slider.min_value <= static_max_slider.value:
		static_max_slider.value += _amount
	else:
		SFX.menu(3)

func _on_HSlider_Static_max_value_changed(value:float):
	if started:
		FX.CAMERA.set_max_static(value)
		static_max_count.text = str(value)

func add_juice_Slider(_amount):
	if juice_slider.min_value <= juice_slider.value:
		print_debug("trying to add to juice slider ", _amount)
		juice_slider.value += _amount
	else:
		SFX.menu(3)

func _on_HSlider_Juice_value_changed(value:float):
	if started:
		FX.CAMERA.set_juice_amount(value)
		juice_count.text = str(value)


func set_selection_color(_color):
	selected_color = _color
	menu_update()
