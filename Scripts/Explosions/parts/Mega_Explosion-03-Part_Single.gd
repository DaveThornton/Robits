extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func play():
	sprite.playing = true

func move(how_much:Vector2):
	self.position += how_much