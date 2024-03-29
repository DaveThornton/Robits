extends Node2D

onready var anim = $AnimationPlayer
onready var label = $Label

export var stay_straight = true
export var text_color = Color8(255,0,0,255)
export var start_show_time = 6.0

func _ready():
	label.modulate = text_color
	label.text = String(stepify(start_show_time,0.1))

func set_time(_time):
	label.text = String(stepify(_time,0.1))

func _process(_delta):
	if stay_straight:
		global_rotation_degrees = 0

func right(is_right):
	if is_right:
		label.rect_scale.y = 1
		# anim.play("Right")
	else:
		label.rect_scale.y = -1
		# anim.play("Left")

func up(is_up):
	if is_up:
		label.rect_scale.x = 1
	else:
		label.rect_scale.x = -1
