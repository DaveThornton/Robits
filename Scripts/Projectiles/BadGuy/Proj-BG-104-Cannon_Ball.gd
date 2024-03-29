extends Area2D
export(PackedScene) var hit
export var speed = 300
export var fall_speed = -50

onready var timer = $Timer

var owned = 1
var my_name = "Basic Projectile"
var damage = 29
var damage_type = "laser"
var started = false
var gun_num = 104

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
#	timer.start()
	rotation = _rot + rand_range(-.02, .02)
	self.global_position = _pos
	scale = _scale
	owned = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if !started:
		timer.start()
		started = true
	fall_speed = fall_speed * 1.1
	move_local_y(fall_speed *delta)
	move_local_x(speed * delta)

func _on_Projectile_body_entered(body):
	entered(body)

func entered(body):
	if body.get_groups().has("hittable") && !body.get_groups().has("badguy"):
		_hit()
		# print("damage to player should be ", damage)
		body.hit(owned, gun_num, damage_type, damage)
		call_deferred("free")
#	elif body.get_groups().has("projectile"):
#		_hit()
#		call_deferred("free")
	elif body.get_groups().has("map"):
		_hit()
		call_deferred("free")

func _hit():
	var x = hit.instance()
	self.get_tree().get_current_scene().add_child(x)
	x.global_position = self.global_position

func _on_Timer_timeout():
	call_deferred("free")


func _on_Projectile_area_entered(area):
	entered(area)
