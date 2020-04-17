extends Node2D
export var moving = true
export var going_right = true

onready var sp1 = $Sprite_01
onready var sp2 = $Sprite_02
onready var sp3 = $Sprite_03

func _ready():
	pass # Replace with function body.

func _process(delta):
	if moving:
		if going_right:
			sp1.position.x += delta * 30
			sp2.position.x += delta * 30
			sp3.position.x += delta * 30
			if sp3.position.x >= 2560:
				sp3.position.x = sp1.position.x - 1280
			elif sp2.position.x >= 2560:
				sp2.position.x = sp3.position.x - 1280
			elif sp1.position.x >= 2560:
				sp1.position.x = sp2.position.x - 1280
		else:
			sp1.position.x -= delta * 30
			sp2.position.x -= delta * 30
			sp3.position.x -= delta * 30
			if sp3.position.x <= -640:
				sp3.position.x = sp2.position.x + 1280
			elif sp2.position.x <= -640:
				sp2.position.x = sp1.position.x + 1280
			elif sp1.position.x <= -640:
				sp1.position.x = sp3.position.x + 1280
