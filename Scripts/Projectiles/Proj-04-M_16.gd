extends Area2D

export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
onready var timer = $Timer
onready var sprite = $Sprite
onready var cast = $RayCast2D

var speed = 1800
var owned = 1
var my_name = "5.56 mm"
var damage = 0
var damage_type = "Bullet"

func _ready():
	sprite = sprite

func start(_rot, _pos, _scale, _owner, dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	damage = dmg
	if _scale.y < 0:
		rotation *= -1

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

func set_frame(_num):
	sprite.frame = _num

func _on_Timer_timeout():
	call_deferred("free")

func _hit_map(_pos):
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _hit_move(_pos):
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos
