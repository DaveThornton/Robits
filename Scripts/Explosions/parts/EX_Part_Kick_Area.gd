extends Area2D

onready var shape = $CollisionShape2D

func set_size(_size:float):
	shape.shape.radius = _size

func disable_shape(dis):
	shape.disabled = dis