extends Node2D

#export var head_color = Color8(255, 255, 255, 255)
#export var face_color = Color8(255, 255, 255, 255)

onready var head = $Head
onready var face = $Face

var is_right: = false

#func _ready():
#	head.modulate = head_color
#	face.modulate = face_color

func play():
	pass

func right():
	is_right = true

func left():
	is_right = false

func set_color(_face_color, _head_color):
	head.modulate = _head_color
	face.modulate = _face_color

#func _process(delta):
#	pass
