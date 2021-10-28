extends RigidBody2D

onready var timer = $Timer
onready var sprite = $Sprite

var min_time = 3
var max_time = 5.5

func _ready():
	var my_time = rand_range(min_time, max_time)
	timer.wait_time = my_time
	timer.start()

func color(_my_color):
	call_deferred("_color", _my_color)

func _color(_my_color):
	sprite.self_modulate = _my_color
	# self.self_modulate = _my_color

func _on_Timer_timeout():
	queue_free()
