extends Node2D

onready var place_01 = $"Selection/Menu-box-370X96_01"
onready var place_02 = $"Selection/Menu-box-370X96_02"
onready var place_03 = $"Selection/Menu-box-370X96_03"
onready var place_04 = $"Selection/Menu-box-370X96_04"
onready var place_05 = $"Selection/Menu-box-370X96_05"
onready var selected_menu = $Selection

export var selected_color = Color8(255,255,255,255)

var places = []

func _ready():
	selected_menu.modulate = selected_color
	places.append(place_01)
	places.append(place_02)
	places.append(place_03)
	places.append(place_04)
	places.append(place_05)

func selection(_place):
	all_out()
	if _place < 5:
		places[_place].visible = true

func all_out():
	place_01.visible = false
	place_02.visible = false
	place_03.visible = false
	place_04.visible = false
	place_05.visible = false

func set_selection_color(_color):
	selected_color = _color
	selected_menu.modulate = selected_color