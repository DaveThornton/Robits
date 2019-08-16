extends Node

var vol_master = 100
var vol_music = 100
var vol_sfx = 100
var max_num_of_player = 8
var end_game_score = 10
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

func set_master_vol(_vol):
	vol_master = _vol

func set_sfx_vol(_vol):
	vol_sfx = _vol

func set_music_vol(_vol):
	vol_music = _vol

func set_end_game_score(_end_score):
	end_game_score = _end_score

func set_max_players(_num_of_players):
	max_num_of_player = _num_of_players


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
