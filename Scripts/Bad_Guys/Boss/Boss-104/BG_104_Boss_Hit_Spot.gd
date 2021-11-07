extends KinematicBody2D

export var health = 100
export var points = 20

onready var anim_hit = $AnimationPlayer

var armor = 3
var dead = false

signal dead_hit_spot

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			Player_Stats.add_score(_by_who, points)
			emit_signal("dead_hit_spot")
			FX.explode(103, -1, self.position, str(self, "'s self destruction system BG_104 but calling 103?"), 0, 0)