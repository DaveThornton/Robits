extends KinematicBody2D

onready var pos_shoot = $Position2D
onready var anim = $AnimationPlayer

export var health = 50
export var armor = 1
export var damage = 35
export var gun_num = 104
export var points = 25

var dead = false
var can_shoot = true

signal cannon_death


func shoot():
# 	pass

# func fire():
	if can_shoot && !dead:
		anim.play("Shoot")
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		var _sss = pos_shoot.scale
		FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
		# SFX.play("Laser_Shoot")

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		# anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			FX.explode(104, -1, self.global_position,304, 0, 0)
			dead = true
			Player_Stats.add_score(_by_who, points)
			emit_signal("dead_hit_spot")
			dead = true
			self.visible = false
			# anim_hit.play("Dead")
			emit_signal("cannon_death")
