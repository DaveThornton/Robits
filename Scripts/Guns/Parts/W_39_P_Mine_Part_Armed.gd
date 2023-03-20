extends Node2D

export var time_out = 30.0
onready var ex_spot = $Position2D
onready var timer_out = $Timer_Out
onready var anim = $AnimationPlayer

var player = 0
var my_name = "Prox Mine"
var armed = false
var damage = 0
var gun_num = 39

func _ready():
	anim.play("Flash")

func init(_player, _dmg, _pos, _rot):
	player = _player 
	damage = _dmg
	self.position = _pos
	self.global_rotation_degrees = _rot

func destruct():
	FX.explode(10, player, ex_spot.global_position, gun_num, 0, damage)
	call_deferred("free")

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if armed:
			destruct()

func _on_Timer_In_timeout():
	armed = true
	timer_out.start(time_out)

func _on_Timer_Out_timeout():
	destruct()
