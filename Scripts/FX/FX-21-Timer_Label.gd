extends Node2D

onready var label = $Label

func set_time(_time):
	label.text = String(stepify(_time,0.1))

# warning-ignore:unused_argument
func _process(delta):
	global_rotation_degrees = 0
