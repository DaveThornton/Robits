extends Node2D

var last_place = 20

func _ready():
	pass # Replace with function body.

func add_score(_player, _score:int):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func player_input(_player:int, _dir:int):
	pass
	
func is_score_high(_score:int):
	if _score > last_place:
		return true
	else: return false

func sort_scores(a, b):
	if a.y < b.y:
		return false
	return true
