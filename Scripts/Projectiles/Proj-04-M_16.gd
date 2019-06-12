extends Area2D
#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
onready var timer = $Timer
onready var sprite = $Sprite
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
#	if body.get_groups().has("map"):
#		queue_free()
#	elif body.get_groups().has("player"):
#		_hit()
#		body.hit(owned, my_name, damage_type, damage)
#		queue_free()
#	elif body.get_groups().has("projectile"):
#		queue_free()
#
#func _hit():
#	var x = hit.instance()
##	if result:
##		var _hit_thing = shoot_cast.get_collider()
##		if _hit_thing.get_groups().has("player"):
##			if _hit_thing.player != player:
##				_hit_thing.hit(player, my_name, dmg_type, damage)
##			else:
##				print("don't Shoot Yourself")
##			self.get_tree().get_current_scene().add_child(x)
##			x.position = shoot_cast.get_collision_point()
##		else:
##			self.get_tree().get_current_scene().add_child(x)
##			x.position = shoot_cast.get_collision_point()
##	else:
#	self.get_tree().get_current_scene().add_child(x)
#	x.global_position = self.global_position
	
func _on_Timer_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("map"):
		queue_free()
#	elif body.get_groups().has("player"):
#		body.hit(owned, my_name, damage_type, damage)
#		queue_free()
func _hit_map():
	var x = hit_anim_map.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position

func _hit_move():
	var x = hit_anim_move.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position