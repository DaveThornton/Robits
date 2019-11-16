extends RigidBody2D
export(PackedScene) var boom
export var armor = 0
export var damage = 111
export var color_lquid = Color8(0,255,0,255)
export var color_barrel = Color8(255,255,255,255)

onready var barrel_l = $"MP-14-Barrel-Lquid"
onready var barrel_b = $"MP-14-Barrel-Still"

var health = 50
var is_right = true

signal boom

func _ready():
	barrel_l.self_modulate = color_lquid
	barrel_b.self_modulate = color_barrel

func init(_health,_gpos):
	if _health > 0:
		health = _health
	self.global_transform = _gpos

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	if health <= 0:
		call_deferred("_explode", _by_who)
	else:
		if is_right:
			self.apply_central_impulse(Vector2(10,-200))
			self.apply_torque_impulse(800)
#			self.apply_impulse((self.global_position + Vector2(0, 0)), Vector2(-3, -10))
			is_right = false
		else:
			self.apply_central_impulse(Vector2(-10,-200))
			self.apply_torque_impulse(-800)
#			self.apply_impulse((self.global_position + Vector2(0, 0)), Vector2(3, -10))
			is_right = true

func _explode(_by_who):
	self.emit_signal("boom")
	var x = boom.instance()
	get_tree().get_current_scene().add_child(x)
	x.init(_by_who, self.position, "Barrel", 0, damage)
	queue_free()