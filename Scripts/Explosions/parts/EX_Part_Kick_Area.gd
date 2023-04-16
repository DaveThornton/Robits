extends Area2D

onready var shape = $CollisionShape2D
# export var expire_time = .3

# func _process(delta):
# 	expire_time -= delta
# 	if expire_time > 0:
# 		call_deferred("queue_free")

func set_size(_size:float):
	shape.shape.radius = _size