extends Node2D

onready var length_part = $Ex23Length128
onready var end_part = $Ex23End8
onready var anim = $AnimationPlayer

func play():
	anim.play("Fire")

func set_length(_length):
	length_part.region_rect = Rect2(0,0,_length,64)
	end_part.position.x = _length