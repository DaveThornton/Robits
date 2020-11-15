extends Node2D
export var stay_straight = true
export var text_color = Color8(255,0,0,255)
onready var label = $Label

func _ready():
	label.modulate = text_color
	
func set_time(_time):
	label.text = String(stepify(_time,0.1))

# warning-ignore:unused_argument
func _process(delta):
	if stay_straight:
		global_rotation_degrees = 0
