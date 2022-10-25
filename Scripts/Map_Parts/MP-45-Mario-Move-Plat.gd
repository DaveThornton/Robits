extends Node2D

export var speed = 75

onready var timer = $Timer

var robits_going_up = []

func _ready():
	pass # Replace with function body.

func start(_time, _speed):
	timer.wait_time = _time
	speed = _speed
	timer.start()

func _process(delta):
#	if robits_going_up.size() > 0:
#		for r in robits_going_up.size():
#			var n = (robits_going_up.size() - r - 1)
#			var s = robits_going_up[n]
#			if s != null:
#				s.global_position.y -= delta * speed
	self.global_position.y -= delta * speed


func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		call_deferred("add_to_up",body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		call_deferred("remove_up",body)

func _on_Timer_timeout():
	# print_debug("move plat mario freed")
	call_deferred("queue_free")

#--------------------------------------------------------------------add/remove

func add_to_up(_body):
	if robits_going_up.find(_body) == -1:
		robits_going_up.append(_body)
	if!_body.is_connected("explode_p", self, "remove_up"):
		_body.connect("explode_p", self, "remove_up")

func remove_up(_body):
	if robits_going_up.find(_body) != -1:
		robits_going_up.erase(_body)
		_body.disconnect("explode_p", self, "remove_up")
