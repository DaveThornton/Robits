extends Area2D

export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
onready var cast = $RayCast2D

var speed = 1400
var owned = -1
var my_name = "12 Gauge"
var damage = 16
var damage_type = "Bullet"
var life_time = .1

func start( _rot , _pos, _scale, _owner, _dmg):
	self.global_rotation = _rot# + rand_range(-.01, .01)
	self.global_position = _pos
	# self.global_scale = _scale
	print_debug( _rot , _pos, _scale, _owner, _dmg)
	owned = _owner
	cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
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
	life_time -= delta
	if life_time <= 0.0:
		call_deferred("free")

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast.set_collision_mask(_bit)

func _hit_map(_pos):
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos

func _hit_move(_pos):
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = _pos
