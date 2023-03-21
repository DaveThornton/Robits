extends Node2D

onready var part = $CPUParticles2D

var player = 0
var my_name = "Plasma Grenade"
var damage = 200
var gun_num = 22
var time
var armed = false

signal blowed_up

func init(_player, _time, _armed, _dmg, _gun_num):
	self.visible = true
	part.visible = true
	player = _player
	time = _time
	armed = _armed
	damage = _dmg
	gun_num = _gun_num

func _process(delta):
	if armed:
		time -= delta
		if time <= 0:
			go_boom()

func go_boom():
	FX.explode(40, player, self.global_position, gun_num, 0, damage)
	emit_signal("blowed_up")
	call_deferred("free")