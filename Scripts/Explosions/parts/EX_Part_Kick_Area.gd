extends Area2D

onready var shape = $CollisionShape2D

export var size = 100.0

func set_size(_size:float):
	size = _size
	shape.shape.radius = size