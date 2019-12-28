extends Node2D

var end_score = 1

func _ready():
	pass # Replace with function body.

func set_end_score(_score):
	end_score = _score
func get_end_score():
	return end_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
