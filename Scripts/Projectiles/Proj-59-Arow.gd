extends Area2D

export(PackedScene) var stuck_arrow
#export(PackedScene) var hit_anim_map
#export(PackedScene) var hit_anim_move

onready var ray = $RayCast2D
onready var timer = $Timer
var speed = 800
var player = 1
var my_name = "Arrow"
var damage = 50
var damage_type = "Arrow"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	player = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if ray.is_colliding():
		if ray.get_collider().get_groups().has("map"):
			var spot = ray.get_collision_point()
			var x = stuck_arrow.instance()
			Map_Hand.add_kid_to_map(x)
			x.init(player, damage, spot, rotation, scale, 2)
			print("map")
		else:
			if ray.get_collider().get_groups().has("player"):
				Player_Stats.add_hit(player,1)
				ray.get_collider().hit(player, my_name, damage_type, damage)
			var spot = ray.get_collision_point()
			print(spot)
			var x = stuck_arrow.instance()
			ray.get_collider().add_child(x)
			x.init(player, damage, spot, rotation, scale, 2)
#			ray.get_collider().hit(player, my_name, damage_type, damage)
			print("not map")
		call_deferred("free")
	move_local_x(speed * delta)

func _on_Projectile_body_entered(_body):
	print("body hit something proj-59-arrow")

#func _hit_map():
#	var x = hit_anim_map.instance()
#	self.get_tree().get_current_scene().add_child(x)
#	x.global_position = self.global_position
#
#func _hit_move():
#	var x = hit_anim_move.instance()
#	self.get_tree().get_current_scene().add_child(x)
#	x.global_position = self.global_position

func _on_Timer_timeout():
	call_deferred("free")
