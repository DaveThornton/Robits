extends Area2D

#export(PackedScene) var hit
export var speed = 1800
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
export(PackedScene) var boom

onready var cast = $RayCast2D
onready var timer = $Timer
#var speed = 1800
var owned = 1
var my_name = "Basic Projectile"
var damage = 50
var damage_type = "laser"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.02, .02)
	position = _pos
	scale = _scale
	owned = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if cast.is_colliding():
		call_deferred("_explode", cast.get_collision_point())
#		if cast.get_collider().get_groups().has("hittable"):
#			Player_Stats.add_hit(owned, 1)
#			_hit_move(cast.get_collision_point())
#			cast.get_collider().hit(owned, my_name, damage_type, damage)
#			call_deferred("free")
#		else:
#			_hit_map(cast.get_collision_point())
#			call_deferred("free")
	move_local_x(speed * delta)

func _hit_map(_pos):
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _hit_move(_pos):
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _on_Timer_timeout():
	call_deferred("free")

func _explode(_pos):
	var x = boom.instance()
	get_tree().get_current_scene().add_child(x)
	x.init(owned, _pos, "RPG", 0, damage)
	queue_free()
