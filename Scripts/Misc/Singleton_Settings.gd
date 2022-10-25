extends Node

var max_num_of_player = 8
var lives_per_credit = 3

func _ready():
	pass # Replace with function body.

func set_lives_per_credit(_num_of_lives):
	lives_per_credit = _num_of_lives

func set_max_players(_num_of_players):
	max_num_of_player = _num_of_players

func get_max_num_players():
	return max_num_of_player