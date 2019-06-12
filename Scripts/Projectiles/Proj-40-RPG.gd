extends Area2D

export(PackedScene) var boom
onready var timer = $Timer
onready var cast_forward = $RayCast2D
onready var sfx = $SFX_Lib
#onready var timer2 = $Timer2
var speed = 800
var owned = 1
onready var anim = $AnimationPlayer
var my_name = "RPG"

#var damage = 85
#var damage_type = "RPG"

#signal kill_square

func start(_rot, _pos, _scale, _owner):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	anim.play("fire")
	sfx.play("RPG_Shoot")

func _physics_process(delta):
	move_local_x(speed * delta)
	speed = speed * 1.01
	if cast_forward.is_colliding():
#		cast_forward.get_collision_point()
#		print("rpg hit with casting")
		call_deferred("_explode",cast_forward.get_collision_point())
#warning-ignore:unused_argument
func _on_Projectile_04_body_entered(body):
#	if cast_forward.is_colliding():
#		cast_forward.get_collision_point()
#	if body.get_groups().has("player") || body.get_groups().has("map") || body.get_groups().has("projectile"):
#		call_deferred("_explode")
#	elif body.get_groups().has("map"):
#		call_deferred("_explode")
#	elif body.get_groups().has("projectile"):
#		call_deferred("_explode")
	call_deferred("_explode",self.global_position)

func _on_Timer_timeout():
	_explode(self.global_position)

func _on_Timer2_timeout():
	_explode(self.global_position)

#func kill_square():
#	emit_signal("kill_square",self.position)
#	var x = boom.instance()
#	get_parent().add_child(x)
#	x.position = self.position
#	x.play()
#	queue_free()
	
func _explode(_pos):
	var x = boom.instance()
	get_tree().get_current_scene().add_child(x)
	x.init(owned, _pos, my_name)
	queue_free()