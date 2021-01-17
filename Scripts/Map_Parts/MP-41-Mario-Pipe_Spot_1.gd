extends Node2D

export var my_pipe_number = 0

onready var pos_bottom = $Position2D

#func _ready():
#	pass # Replace with function body.
func transport_here(_body):
	_body.can_move = true
	_body.global_position = pos_bottom.global_position

#func _process(delta):
#	pass
