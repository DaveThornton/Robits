extends Node

var max_num_of_player = 8
var lives_per_credit = 3
var campaign_start_gun = false

var multi_start_gun = false
var multi_lives = 5
var multi_score_to_win = 10
var multi_minus_on_death = false
var multi_use_lives = false
var multi_time = 2
var multi_player_indi = false

#=-=-=-=-=-Individual player indicator-=-=-=-=-=-=-=-=
var p1_ind_vis = false
var p2_ind_vis = false
var p3_ind_vis = false
var p4_ind_vis = false
var p5_ind_vis = false
var p6_ind_vis = false
var p7_ind_vis = false
var p8_ind_vis = false
#-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=--=-=-=-

var vol_master = 10
var vol_music = 10
var vol_sfx = 10

func _ready():
	pass # Replace with function body.


func set_lives_per_credit(_num_of_lives):
	lives_per_credit = _num_of_lives
	print_debug("set lives per credit for camp in settings to:", lives_per_credit)

func get_lives_per_credit():
	return lives_per_credit


func set_max_num_players(_num_of_players):
	max_num_of_player = _num_of_players
	print_debug("max number of players changed in the settings to: ", max_num_of_player)

func get_max_num_players():
	return max_num_of_player


func set_multi_lives(_lives):
	multi_lives = _lives
	print_debug("number of lives changed in the settings to: ", multi_lives)

func get_multi_lives():
	return multi_lives


func set_multi_score_to_win(_score):
	multi_score_to_win = _score
	print_debug("number of scores to win changed in the settings to: ", multi_score_to_win)

func get_multi_score_to_win():
	return multi_score_to_win


func set_multi_minus_on_death(_minus):
	multi_minus_on_death = _minus
	print_debug("minus points on death changed in the settings to: ", multi_minus_on_death)

func get_multi_minus_on_death():
	return multi_minus_on_death


func set_multi_use_lives(_use):
	multi_use_lives = _use
	print_debug("use lives set in the settings to: ", multi_use_lives)

func get_multi_use_lives():
	return multi_use_lives


func set_multi_time(_seconds):
	multi_time = _seconds
	print_debug("time for multiplayer set to ", multi_time)

func get_multi_time():
	return multi_time


func set_multi_start_gun(_start):
	multi_start_gun = _start
	print_debug("mutliplayer starting weapon is ",multi_start_gun)

func get_multi_start_gun():
	return multi_start_gun

func set_multi_player_ind(_ind):
	print_debug("mutliplayer show player indicator set in settings", _ind)
	multi_player_indi = _ind

func get_multi_player_ind():
	return multi_player_indi

func set_campaign_start_gun(_start):
	campaign_start_gun = _start
	print_debug("campaign starting weapon is ",campaign_start_gun)

func get_campaign_start_gun():
	return campaign_start_gun

func reset():
	p1_ind_vis = false
	p2_ind_vis = false
	p3_ind_vis = false
	p4_ind_vis = false
	p5_ind_vis = false
	p6_ind_vis = false
	p7_ind_vis = false
	p8_ind_vis = false