extends Area2D
#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move
var speed = 1400
var owned = 1
var my_name = "12 Gauge"
var damage = 16
var damage_type = "Bullet"

func start(_owner , _dmg):
	owned = _owner
	damage = _dmg

func _physics_process(delta):
	move_local_x(speed * delta)

func _on_Projectile_body_entered(body):
	if body.get_groups().has("hittable"):
		_hit_move()
		body.hit(owned, my_name, damage_type, damage)
		call_deferred("free")
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

#func _on_Timer_timeout():
#	call_deferred("free")

#func _on_Area2D_body_entered(body):
##	pass
#	if body.get_groups().has("map"):
#		_hit()
#		queue_free()
#	elif body.get_groups().has("player"):
#		body.hit(owned, my_name, damage_type, damage)
#		queue_free()
