extends Control

onready var top_label = $VBoxContainer/HBoxContainer/Label
onready var bottom_label = $VBoxContainer/HBoxContainer2/Label2

func change_text(_top_text, _bottom_text):
	top_label.text = _top_text
	bottom_label.text = _bottom_text