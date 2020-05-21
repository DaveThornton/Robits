extends Node2D

export(PackedScene) var boom

onready var anim = $AnimationPlayer
onready var bolt = $Bolt
onready var timer = $Timer

var player = 0
var my_name = "bolt"
var damage = 0

func init(_player, _dmg, _pos, _rot, _scale, _time):
	player = _player
	damage = _dmg
	global_rotation = _rot
	global_position = _pos
	scale = _scale
	timer.start(_time)
	anim.play("Blink")

func _on_Timer_timeout():
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
	b.init(player, self.global_position, my_name, 0, damage)
	queue_free()
