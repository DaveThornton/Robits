extends Area2D
#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
onready var cast = $RayCast2D

var speed = 1400
var owned = 1
var my_name = "12 Gauge"
var damage = 16
var damage_type = "Bullet"

func start(_owner , _dmg):
	owned = _owner
	damage = _dmg

func _physics_process(delta):
	if cast.is_colliding():
		if cast.get_collider().get_groups().has("player"):
			Player_Stats.add_hit(owned, 1)
			_hit_move(cast.get_collision_point())
			cast.get_collider().hit(owned, my_name, damage_type, damage)
			call_deferred("free")
		elif cast.get_collider().get_groups().has("hittable"):
			Player_Stats.add_hit(owned, 1)
			_hit_move(cast.get_collision_point())
			cast.get_collider().hit(owned, my_name, damage_type, damage)
			call_deferred("free")
		else:
			_hit_map(cast.get_collision_point())
			call_deferred("free")
	move_local_x(speed * delta)


func _hit_map(_pos):
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _hit_move(_pos):
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos
