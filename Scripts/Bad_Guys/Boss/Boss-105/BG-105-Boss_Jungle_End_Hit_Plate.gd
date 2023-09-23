extends StaticBody2D

onready var anim = $AnimationPlayer
onready var shape = $CollisionShape2D

export var health = 100
export var armor = 1
export var points_per_hit = 1
export var points_when_killed = 25

signal dead

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	Player_Stats.add_score(_by_who, points_per_hit)
	if health <= 0:
		Player_Stats.add_score(_by_who, points_when_killed)
		print_debug("Jungle_End_Boss dead BG-105")
		# FX.explode(7, -1, (self.position + Vector2(0, -23)), 203, 0, 0)
		emit_signal("dead")
		self.visible = false
		shape.disabled = true
		# (_num, _owner, _pos, _weap_num: int, _pawn_num, _dmg)
		FX.explode(105, -1, self.global_position, 105, 0, 0)
		# call_deferred("free")
	else:
		anim.play("Hit")