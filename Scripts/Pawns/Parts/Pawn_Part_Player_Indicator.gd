extends Node2D

onready var player_number_label = $HBoxContainer/Label2
onready var back_drop = $WhitePixel

var player = 0

func _ready():
	pass # Replace with function body.

func start(_player):
	player = _player
	player_number_label.text = str(player)
	self.modulate = Player_Stats.get_body_color(player)
	back_drop.modulate = Player_Stats.get_sec_color(player)
	if Settings.get_multi_player_ind() || Player_Stats.get_player_indi_vis(_player):
		self.visible = true
	else:
		self.visible = false