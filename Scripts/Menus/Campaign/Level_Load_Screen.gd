extends Control

onready var top_label = $VBoxContainer/HBoxContainer/Label
onready var bottom_label = $VBoxContainer/HBoxContainer2/Label2
onready var timer = $Timer

func change_text(_top_text, _bottom_text):
	top_label.text = _top_text
	bottom_label.text = _bottom_text

func start_timer(_time):
	timer.start(_time)

func _on_Timer_timeout():
	visible = false
