extends Node2D

onready var timer = $Timer

var player = 0
var my_name = "Arrow"
var damage = 0

func init(_player, _dmg, _pos, _rot, _scale, _time):
	player = _player
	global_rotation = _rot
	global_position = _pos
	scale = _scale
	timer.start(_time)

func _on_Timer_timeout():
	call_deferred("free")
