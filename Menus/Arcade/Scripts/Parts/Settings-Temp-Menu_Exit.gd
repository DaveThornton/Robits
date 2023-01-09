extends Node2D

onready var row_01 = $VBoxContainer/HBoxContainer
onready var row_02 = $VBoxContainer2/HBoxContainer
onready var row_03 = $VBoxContainer3/HBoxContainer

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
	if menu_pos >= 3:
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
		parent_menu.save_data()
	elif menu_pos == 2:
		parent_menu.load_data()
	elif menu_pos == 3:
		get_tree().get_current_scene().arcade_reset()
		parent_menu.exit()
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
		print_debug("error in settings temp menu camp wrong menu pos menu update")

func white_out():
	row_01.modulate = white
	row_02.modulate = white
	row_03.modulate = white

func set_selection_color(_color):
	selected_color = _color
	menu_update()
