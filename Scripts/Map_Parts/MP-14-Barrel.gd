extends RigidBody2D

export var armor = 0
export var damage = 140

onready var barrel_l = $"MP-14-Barrel-Lquid"
onready var barrel_b = $"MP-14-Barrel-Still"

var player = 0
var my_name = "Barrel"
var health = 50
var is_dead = false
var is_right = true

signal boom

func init(_health,_gpos):
	if _health > 0:
		health = _health
	self.global_transform = _gpos

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	if health <= 0 && !is_dead:
		is_dead = true
		FX.explode(10, _by_who, self.global_position + Vector2(0,-32), -1, Player_Stats.get_pawn_num(_by_who), damage)
		print_debug("TO DO: make barrel its own explosion")
		self.emit_signal("boom")
		queue_free()
	else:
		if is_right:
			self.apply_central_impulse(Vector2(10,-200))
			self.apply_torque_impulse(800)
			is_right = false
		else:
			self.apply_central_impulse(Vector2(-10,-200))
			self.apply_torque_impulse(-800)
			is_right = true
