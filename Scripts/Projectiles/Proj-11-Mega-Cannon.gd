extends Area2D
#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move

#onready var hit_pos = $"Pos-Hit"
onready var timer = $Timer

var speed = 700
var owned = 1
var my_name = "Mega-Laser"
var damage = 0
var damage_type = "laser"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot
	position = _pos
	scale = _scale
	owned = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	move_local_x(speed * delta)

func _on_Projectile_area_entered(area):
	entered(area)

func _on_Projectile_body_entered(body):
	entered(body)

func entered(body):
	if body.get_groups().has("hittable"):
		Player_Stats.add_hit(owned, 1)
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
