extends Node2D

export(PackedScene) var player_controller
export(PackedScene) var net_controller

onready var players = $Players

var p1
var p2
var p3
var p4
var p5
var p6
var p7
var p8

var game_mode
var play_type

#signal input_to_screen 

func spawn_player_contoller(player_num, _auto_respawn):
	var z = player_controller.instance()
	players.add_child(z)
#	z.connect("change_spawn_pos",self,"get_spawn_spot")
	z.connect("in_play",self,"set_in_play")
#	z.connect("player_score", self, "player_scores") 
	z.connect("coin_insert", self, "coin_insert")
	z.connect("use_credit", self, "use_credit")
#	z.pawn_num = Player_Stats     #<-------------this changes the pawns in demo mode
	self.connect("game_over", z, "game_over")
	self.connect("reset",z,"reset")
	
	if player_num == 1:
		p1 = z
	elif player_num == 2:
		p2 = z
	elif player_num == 3:
		p3 = z
	elif player_num == 4:
		p4 = z
	elif player_num == 5:
		p5 = z
	elif player_num == 6:
		p6 = z
	elif player_num == 7:
		p7 = z
	elif player_num == 8:
		p8 = z
	z.init(player_num, _auto_respawn, game_mode, play_type)

#func screen_input( _player, _dir):
#	emit_signal("input_to_screen",_player, _dir)

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
