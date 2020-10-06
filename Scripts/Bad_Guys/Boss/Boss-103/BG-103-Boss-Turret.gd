#extends KinematicBody2D
extends StaticBody2D

export(PackedScene) var projectile
export(PackedScene) var explode

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
var look_time = .25
var time = 0.0
signal hit_turret
signal dead_turret

func _ready():
#	connect("hit_turret", get_parent(), "hit_turret")
	pass # Replace with function body.

func _process(delta):
	if get_tree().get_current_scene().pawns.get_child_count() > 0:
		look_at(get_tree().get_current_scene().pawns.get_child(0).position)
		rotation_degrees += 180
#	else:
#		print("no pawns?")
	
	
func move(_right):
	pass

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		emit_signal("hit_turret")
#		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			print("BG-103-Dead")
			call_deferred("_explode")

func _explode():
	dead = true
	emit_signal("dead_turret")
	var e = explode.instance()
	shape.disabled = false
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)
	anim_hit.play("Dead")

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
