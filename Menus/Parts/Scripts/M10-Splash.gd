extends Control

onready var top_label = $Sprite/VBoxContainer/HBoxContainer/Label
onready var bottom_label = $Sprite/VBoxContainer/HBoxContainer2/Label2
onready var timer = $Timer

var pausing = false

func init(_top, _body, _time, _pause):
	top_label.text = _top
	bottom_label.text = _body
	timer.wait_time = _time
	if _pause:
		pausing = true
#		print_debug("about to pause")
		get_tree().paused = true
#		print_debug("paused")
	timer.start()

func _on_Timer_timeout():
#	print_debug("time_out")
	self.visible = false
	if pausing:
		get_tree().paused = false
	call_deferred("free")

func change_text(_top, _body):
	top_label.text = _top
	bottom_label.text = _body
