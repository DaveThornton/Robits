#extends KinematicBody2D
extends StaticBody2D

export(PackedScene) var explode
export var front = true

onready var anim = $AnimationPlayer
onready var anim_hit = $AnimationPlayer_Hit
onready var shape = $CollisionShape2D
onready var blackened = $"BG-103-Track-Black"

var dead = false
var health = 200
var armor = 10

signal dead_track

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			if front:
				print("BG-103-Front-Track-Dead")
			else:
				print("BG-103-Back-Track-Dead")
			call_deferred("_explode")
			emit_signal("dead_track")

func _explode():
	shape.disabled = true
	dead = true
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)
	anim_hit.play("Dead")

func move(_right):
	if !dead:
		if front:
			if !_right:
				anim.play("Left")
			else:
				anim.play_backwards("Left")
		else:
			if _right:
				anim.play("Left")
			else:
				anim.play_backwards("Left")
func stop():
	anim.stop()
