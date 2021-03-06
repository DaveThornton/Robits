extends Area2D

export(PackedScene) var boom
onready var timer = $Timer
onready var cast_forward = $RayCast2D
onready var anim = $AnimationPlayer
var speed = 300
var owned = 0
# warning-ignore:unused_class_variable
var my_name = "BFG 9000"
var damage

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	anim.play("Move")
#	SFX.play("RPG_Shoot")
	print("make sfx for BFG 9000 projectile")
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	move_local_x(speed * delta)
	speed = speed * 1.01
	if cast_forward.is_colliding():
		call_deferred("_explode", position)

func _on_Projectile_04_area_entered(area):
	entered(area)

func _on_Projectile_04_body_entered(body):
	entered(body)

func entered(_body):
	call_deferred("_explode",self.global_position)

func _on_Timer_timeout():
	_explode(self.global_position)

func _on_Timer2_timeout():
	_explode(self.global_position)

func _explode(_pos):
	var x = boom.instance()
	get_tree().get_current_scene().add_child(x)
	x.init(owned, _pos, my_name, 0, damage)
	call_deferred("free")
