extends Area2D
onready var timer = $Timer
var speed = 30
var owned = 1
var my_name = "Basic Projectile"
var damage = 51
var damage_type = "laser"

func start(_rot, _pos, _scale, _owner):
	timer.start()
	rotation = _rot + rand_range(-.02, .02)
	position = Vector2(_pos)
	scale = _scale
	owned = _owner
#	print(_pos)
#	print(rotation)

func _physics_process(delta):
	move_local_x(speed)

func _on_Projectile_body_entered(body):
	if body.get_groups().has("map"):
		queue_free()
	elif body.get_groups().has("player"):
		body.hit(owned, my_name, damage_type, damage)
		queue_free()
	elif body.get_groups().has("projectile"):
		queue_free()

func _on_Timer_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("map"):
		queue_free()
	elif body.get_groups().has("player"):
		body.hit(owned, my_name, damage_type, damage)
		queue_free()
