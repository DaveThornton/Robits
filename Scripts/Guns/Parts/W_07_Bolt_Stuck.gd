extends Node2D

onready var anim = $AnimationPlayer
onready var bolt = $Bolt
onready var timer = $Timer

var player = 0
var my_name = "bolt"
var damage = 0
var gun_num = 7

func init(_player, _dmg, _pos, _rot, _scale, _time):
	player = _player
	damage = _dmg
	global_rotation = _rot
	global_position = _pos
	scale = _scale
	timer.start(_time)
	anim.play("Blink")

func _on_Timer_timeout():
	FX.explode(10, player, self.global_position, gun_num, 0, damage)
	call_deferred("free")
