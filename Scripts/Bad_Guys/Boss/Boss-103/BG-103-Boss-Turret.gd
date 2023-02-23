extends KinematicBody2D

export var points = 23

onready var anim_hit = $AnimationPlayer_Hit
onready var anim_shoot = $AnimationPlayer_Shoot
onready var shape = $CollisionShape2D

var dead = false
var health = 200
var armor = 10
var can_shoot = true
var damage = 20
var ex_dmg = 25
var player = -1
var bodies_in_range = []
var current_look_time = 0
var look_time = .1
var time: = 0.0
var last_rotation: = 0.0

signal hit_turret
signal dead_turret

func _ready():
	last_rotation = rotation_degrees

func _process(_delta):
	if get_tree().get_current_scene().pawns.get_child_count() > 0:
		look_at(get_tree().get_current_scene().pawns.get_child(0).position)
		self.rotation_degrees = clamp(self.rotation_degrees,175.0, 300.0)
		rotation_degrees = ((rotation_degrees - last_rotation) / 40) + last_rotation
		last_rotation = rotation_degrees
	
	
func move(_right):
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		emit_signal("hit_turret")
		health -= (_damage - armor)
		if health <= 0:
			Player_Stats.add_score(_by_who, points)
			dead = true	
			emit_signal("dead_turret")
			FX.explode(103, -1, self.position, 303, 0, 0)
			call_deferred("_explode")

func sort_distance(_a, _b):
	if (abs(_a.global_position.x - self.global_position.x) + abs(_a.global_position.y - self.global_position.y)) < (abs(_b.global_position.x - self.global_position.x) + abs(_b.global_position.y - self.global_position.y)):
		return true
	else:
		return false

func remove_dead():
	var h_size = (bodies_in_range.size() - 1)
	for h in  bodies_in_range.size():
		if !is_instance_valid( bodies_in_range[h_size - h]):
			 bodies_in_range.remove(h_size - h)
