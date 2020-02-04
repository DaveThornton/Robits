extends RigidBody2D

onready var timer = $Timer

var min_time = 3
var max_time = 5.5

func _ready():
	var my_time = rand_range(min_time, max_time)
	timer.wait_time = my_time
	timer.start()

func _on_Timer_timeout():
	queue_free()
