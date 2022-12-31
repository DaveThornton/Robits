extends Node

var max_num_of_player = 8
var lives_per_credit = 3
var multi_lives = 5
var multi_score_to_win = 10
var multi_minus_on_death = false
var multi_use_lives = false

func _ready():
	pass # Replace with function body.


func set_lives_per_credit(_num_of_lives):
	lives_per_credit = _num_of_lives

func get_lives_per_credit():
	return lives_per_credit


func set_max_num_players(_num_of_players):
	max_num_of_player = _num_of_players

func get_max_num_players():
	return max_num_of_player


func set_multi_lives(_lives):
	multi_lives = _lives

func get_multi_lives():
	return multi_lives


func set_multi_score_to_win(_score):
	multi_score_to_win = _score

func get_multi_score_to_win():
	return multi_score_to_win


func set_multi_minus_on_death(_minus):
	multi_minus_on_death = _minus

func get_multi_minus_on_death():
	return multi_minus_on_death


func set_multi_use_lives(_use):
	multi_use_lives = _use

func get_multi_use_lives():
	return multi_use_lives