extends Node2D
export var moving = true
export var going_right = true
export var square_size = 1280

onready var sp1 = $Sprite_01
onready var sp2 = $Sprite_02
onready var sp3 = $Sprite_03

func _ready():
	pass # Replace with function body.

func _process(delta):
	if moving:
		if going_right:
			sp1.position.x += delta * 304
			sp2.position.x += delta * 30
			sp3.position.x += delta * 30
			if sp3.position.x >= (square_size * 2):
				sp3.position.x = sp1.position.x - square_size
			elif sp2.position.x >= (square_size * 2):
				sp2.position.x = sp3.position.x - square_size
			elif sp1.position.x >= (square_size * 2):
				sp1.position.x = sp2.position.x - square_size
		else:
			sp1.position.x -= delta * 30
			sp2.position.x -= delta * 30
			sp3.position.x -= delta * 30
			if sp3.position.x <= -(square_size / 2):
				sp3.position.x = sp2.position.x + square_size
			elif sp2.position.x <= -(square_size / 2):
				sp2.position.x = sp1.position.x + square_size
			elif sp1.position.x <= -(square_size / 2):
				sp1.position.x = sp3.position.x + square_size
