extends Area2D

#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move

onready var timer = $Timer
var speed = 1800
var owned = 1
var my_name = "Basic Projectile"
var damage = 0
var damage_type = "laser"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.02, .02)
	position = _pos
	scale = _scale
	owned = _owner
	damage = _dmg
#	print(_pos)
#	print(rotation) res://Scripts/Proj-10-Laser.gd

func _physics_process(delta):
	move_local_x(speed * delta)

func _on_Projectile_body_entered(body):
	if body.get_groups().has("hittable"):
		_hit_move()
		body.hit(owned, my_name, damage_type, damage)
		call_deferred("free")
#		queue_free()
	elif body.get_groups().has("projectile"):
		_hit_move()
		call_deferred("free")
	elif body.get_groups().has("map"):
		_hit_map()
		call_deferred("free")

#func _hit():
#	var x = hit.instance()
#	self.get_tree().get_current_scene().add_child(x)
#	x.global_position = self.global_position

func _hit_map():
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position

func _hit_move():
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position

func _on_Timer_timeout():
	call_deferred("free")

#func _on_Area2D_body_entered(body):
#	if body.get_groups().has("map"):
#		queue_free()
#	elif body.get_groups().has("player"):
#		body.hit(owned, my_name, damage_type, damage)
#		queue_free()