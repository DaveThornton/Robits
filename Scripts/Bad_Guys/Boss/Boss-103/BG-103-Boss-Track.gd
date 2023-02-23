#extends KinematicBody2D
extends StaticBody2D

export(PackedScene) var debris_scene

export var front = true
export var points = 17

onready var anim = $AnimationPlayer
onready var anim_hit = $AnimationPlayer_Hit
onready var shape = $CollisionShape2D
onready var track_back = $"BG-103-Track-Back"
onready var blackened = $"BG-103-Track-Black"
onready var debris = $Debris

var dead = false
var health = 160
var armor = 10

signal dead_track

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			shape.disabled = true
			dead = true
			for d in debris.get_child_count():
				var deb = debris_scene.instance()
				FX.add_kid(deb)
				deb.init(Color8(255,255,255,255), 5, true, debris.get_child(d).global_position, Vector2(0,0))
			FX.explode(2, -1, self.position, 303, 0, 0)
			self.visible = false
			anim_hit.play("Dead")
			Player_Stats.add_score(_by_who, points)
			if front:
				print_debug("BG-103-Front-Track-Dead")
			else:
				print_debug("BG-103-Back-Track-Dead")
			# call_deferred("_explode")
			emit_signal("dead_track")

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
	anim.stop(false)
