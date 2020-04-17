extends Node2D

onready var anim = $AnimationPlayer
onready var light = $Sprite
var blinked_num = 0
var blinked_max = 3

func _ready():
	pass # Replace with function body.

func on():
	blinked_num = 0
	anim.play("On")
	
func off():
	blinked_num = 0
	anim.play("Off")

func blink(_blink_max):
	blinked_num = 0
	blinked_max = _blink_max
	anim.play("Blink")

func _blinked():
#	print("i blinked pawn 05 light")
	blinked_num += 1
	if blinked_num == blinked_max:
		anim.stop()

func color(_pri: Color, _sec: Color):
	light.self_modulate = _sec
