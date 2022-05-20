extends Area2D

export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move

onready var cast = $RayCast2D
onready var timer = $Timer
var can_damage = false
var speed = 1800
var owned = 1
var my_name = "TOS Laser"
var damage = 0
var damage_type = "laser"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot #+ rand_range(-.02, .02)
	position = _pos
	scale = _scale
	owned = _owner
	cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func set_can_damage(_can):
	can_damage = _can

func _physics_process(delta):
	if cast.is_colliding():
		if cast.get_collider().get_groups().has("player"):
			Player_Stats.add_hit(owned, 1)
			_hit_move(cast.get_collision_point())
			cast.get_collider().hit(owned, my_name, damage_type, damage)
			call_deferred("free")
		elif cast.get_collider().get_groups().has("hittable"):
			Player_Stats.add_hit(owned, .1)
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

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast.set_collision_mask(_bit)
	
func _on_Timer_timeout():
	call_deferred("free")

	# if ray.is_colliding():
	# 	var _col = ray.get_collider()
	# 	if _col:
	# 		if ray.get_collider().get_groups().has("map"):
	# 			var x = hit_anim_map.instance()
	# 			self.get_tree().get_current_scene().add_child(x)
	# 			x.global_position = ray.get_collision_point()
	# 		else:
	# 			if ray.get_collider().get_groups().has("player"):
	# 				Player_Stats.add_hit(owned,.1)
	# 				print("adding to many hits in proj 13 make less")
	# 			var x = hit_anim_move.instance()
	# 			self.get_tree().get_current_scene().add_child(x)
	# 			x.global_position = ray.get_collision_point()
	# 		call_deferred("free")
	# move_local_x(speed * delta)
	
# func _on_Projectile_area_entered(area):
# 	entered(area)
# func _on_Projectile_body_entered(body):
# 	entered(body)

# func entered(body):
# 	if body.get_groups().has("hittable"):
# 		# if can_damage:
# 		Player_Stats.add_hit(owned, 1)
# 		print("adding to many hits in proj 13 make less")
# 		body.hit(owned, my_name, damage_type, damage)
# 		_hit_move()
# 		call_deferred("free")
# 	elif body.get_groups().has("projectile"):
# 		_hit_move()
# 		call_deferred("free")
# 	elif body.get_groups().has("map"):
# 		_hit_map()
# 		call_deferred("free")

# func _hit_map():
# 	var x = hit_anim_map.instance()
# 	self.get_tree().get_current_scene().add_child(x)
# 	x.global_position = self.global_position

# func _hit_move():
# 	var x = hit_anim_move.instance()
# 	self.get_tree().get_current_scene().add_child(x)
# 	x.global_position = self.global_position

# func set_layer(_bit):
# 	self.set_collision_layer(_bit)
# 	self.set_collision_mask(_bit)
# 	ray.set_collision_mask(_bit)

# func _on_Timer_timeout():
# 	call_deferred("free")
