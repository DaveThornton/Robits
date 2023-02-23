extends Area2D

export var speed = 1800
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move

onready var cast = $RayCast2D
onready var timer = $Timer
onready var anim = $AnimationPlayer

var owned = 1
var my_name = "Atom"
var damage = 0
var damage_type = "laser"
var gun_num = 0

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
	anim.play("Idle")
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if cast.is_colliding():
		if cast.get_collider().get_groups().has("player"):
			Player_Stats.add_hit(owned, 1)
			_hit_move(cast.get_collision_point())
			cast.get_collider().stun(6)
			cast.get_collider().hit(owned, gun_num, damage_type, damage)
			call_deferred("free")
		elif cast.get_collider().get_groups().has("hittable"):
			Player_Stats.add_hit(owned, 1)
			_hit_move(cast.get_collision_point())
			cast.get_collider().hit(owned, gun_num, damage_type, damage)
			call_deferred("free")
		else:
			_hit_map(cast.get_collision_point())
			call_deferred("free")
	move_local_x(speed * delta)

func _hit_map(_pos):
	var x = hit_anim_map.instance()
	Map_Hand.add_kid_to_map(x)
	x.global_position = _pos

func _hit_move(_pos):
	var x = hit_anim_move.instance()
	Map_Hand.add_kid_to_map(x)
	x.global_position = _pos

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast.set_collision_mask(_bit)

func _on_Timer_timeout():
	call_deferred("free")
