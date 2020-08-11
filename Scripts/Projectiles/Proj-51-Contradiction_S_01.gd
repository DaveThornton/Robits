extends Area2D

#export(PackedScene) var hit
export(PackedScene) var hit_anim_map
export(PackedScene) var hit_anim_move

onready var timer = $Timer
var speed = 1800
var owned = 1
var my_name = "Spread Bullet"
var damage = 0
var damage_type = "Bullet"

func start(_rot, _pos, _scale, _owner, dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
#	scale = _scale
	owned = _owner
	damage = dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	self.scale += Vector2(delta * 5, delta * 5)
	move_local_x(speed * delta)

func _on_Proj51Contradiction_S_01_body_entered(body):
	var _hit = true
	if body.get_groups().has("player"):
		if body.player == owned:
			print("hit your self")
			_hit = false
	if _hit:
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
			_hit_move()
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
