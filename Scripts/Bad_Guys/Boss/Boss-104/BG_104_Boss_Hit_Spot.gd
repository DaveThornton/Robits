extends KinematicBody2D

export(PackedScene) var boom

export var health = 100
export var points = 20

onready var anim_hit = $AnimationPlayer

var armor = 3
var dead = false

signal dead_hit_spot

func _ready():
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		# emit_signal("hit_turret")
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			Player_Stats.add_score(_by_who, points)
			# anim_hit.play("Dead")
			emit_signal("dead_hit_spot")
			call_deferred("explode")

func explode():
	dead = true
	var e = boom.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)
	self.visible = false
	anim_hit.play("Dead")