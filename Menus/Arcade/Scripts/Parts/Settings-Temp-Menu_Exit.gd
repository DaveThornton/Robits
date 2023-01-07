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
	pass

func up():
	if menu_pos <= 1:
		parent_menu.back_to_top()
		menu_pos -= 1
		menu_update()
	else:
		menu_pos -= 1
		menu_update()

func down():
	if menu_pos >= 1:
		SFX.menu(3)
	else:
		menu_pos += 1
		menu_update()

func left():
	if menu_pos == 1:
		pass
	else:
		print_debug("error in settings temp menu vs wrong menu pos left")

func right():
	if menu_pos == 1:
		get_tree().get_current_scene().arcade_reset()
		parent_menu.exit()
		pass
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
	else:
		print_debug("error in settings temp menu camp wrong menu pos menu update")

func white_out():
	row_01.modulate = white

func set_selection_color(_color):
	selected_color = _color
	menu_update()
