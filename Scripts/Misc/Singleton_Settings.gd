extends Node

var max_num_of_player = 8
var lives_per_credit = 3
#var end_game_score = 10
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

#func set_game_over(_game_over):
#	is_game_over = _game_over
#func get_game_over():
#	return is_game_over

#func set_end_game_score(_end_score):
#	end_game_score = _end_score
func set_lives_per_credit(_num_of_lives):
	lives_per_credit = _num_of_lives

func set_max_players(_num_of_players):
	max_num_of_player = _num_of_players
