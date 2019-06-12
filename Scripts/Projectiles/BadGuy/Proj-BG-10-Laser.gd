extends Area2D
export(PackedScene) var hit
onready var timer = $Timer
var speed = 1800
var owned = 1
var my_name = "Basic Projectile"
var damage = 29
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
	if body.get_groups().has("hittable") && !body.get_groups().has("badguy"):
		_hit()
		body.hit(owned, my_name, damage_type, damage)
		call_deferred("free")
#		queue_free()
	elif body.get_groups().has("projectile"):
		_hit()
		call_deferred("free")
	elif body.get_groups().has("map"):
		_hit()
		call_deferred("free")

func _hit():
	var x = hit.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position

func _on_Timer_timeout():
	queue_free()

#func _on_Area2D_body_entered(body):
#	if body.get_groups().has("map"):
#		queue_free()
#	elif body.get_groups().has("player"):
#		body.hit(owned, my_name, damage_type, damage)
#		queue_free()
