extends Node2D

onready var master_label = $VBoxContainer/HBoxContainer/Label_Master
onready var master_count = $VBoxContainer/HBoxContainer/Label_Master_Count
onready var master_slider = $VBoxContainer/HBoxContainer/HSlider_Master

onready var music_label = $VBoxContainer/HBoxContainer2/Label_Music
onready var music_count = $VBoxContainer/HBoxContainer2/Label_Music_Count
onready var music_slider = $VBoxContainer/HBoxContainer2/HSlider_Music

onready var sfx_label = $VBoxContainer/HBoxContainer3/Label_Sfx
onready var sfx_count = $VBoxContainer/HBoxContainer3/Label_Sfx_count
onready var sfx_slider = $VBoxContainer/HBoxContainer3/HSlider_Sfx 

onready var row_01 = $VBoxContainer/HBoxContainer
onready var row_02 = $VBoxContainer/HBoxContainer2
onready var row_03 = $VBoxContainer/HBoxContainer3

export var selected_color = Color8(255,255,255,255)

var menu_pos = 0
var white = Color8(255,255,255,255)
var parent_menu

func _ready():
	master_slider.value = SFX.get_master_vol()
	music_slider.value = SFX.get_music_vol()
	sfx_slider.value = SFX.get_sfx_vol()

func up():
	if menu_pos <= 1:
		parent_menu.back_to_top()
		menu_pos -= 1
		menu_update()
	else:
		menu_pos -= 1
		menu_update()

func down():
	if menu_pos >= 3:
		SFX.menu(3)
	else:
		menu_pos += 1
		menu_update()

func left():
	if menu_pos == 1:
		if master_slider.min_value <= master_slider.value:
			master_slider.value -= .5
		else:
			SFX.menu(3)
	elif menu_pos == 2:
		if music_slider.min_value <= music_slider.value:
			music_slider.value -= .5
		else:
			SFX.menu(3)
	elif menu_pos == 3:
		if sfx_slider.min_value <= sfx_slider.value:
			sfx_slider.value -= .5
		else:
			SFX.menu(3)
	else:
		print_debug("error in settings temp menu vs wrong menu pos left")

func right():
	if menu_pos == 1:
		if master_slider.max_value >= master_slider.value:
			master_slider.value += 1
		else:
			SFX.menu(3)
	elif menu_pos == 2:
		if music_slider.max_value >= music_slider.value:
			music_slider.value += 1
		else:
			SFX.menu(3)
	elif menu_pos == 3:
		if sfx_slider.max_value >= sfx_slider.value:
			sfx_slider.value += 1
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
	elif menu_pos == 3:
		row_03.modulate = selected_color
	else:
		print_debug("error in settings temp menu vs wrong menu pos menu update")

func white_out():
	row_01.modulate = white
	row_02.modulate = white
	row_03.modulate = white


func add_master_slider(_amount):
	master_slider.value += _amount

func _on_HSlider_Stock_value_changed(value:float):
	SFX.set_master_vol(value)
	master_count.text = str(value)


func add_music_slider(_amount):
	music_slider.value += _amount

func _on_HSlider_Score_value_changed(value:float):
	SFX.set_music_vol(value)
	music_count.text = str(value)


func add_sfx_slider(_amount):
	sfx_slider.value += _amount

func _on_HSlider_Time_value_changed(value:float):
	SFX.set_sfx_vol(value)
	sfx_count.text = str(value)


func set_selection_color(_color):
	selected_color = _color
	menu_update()