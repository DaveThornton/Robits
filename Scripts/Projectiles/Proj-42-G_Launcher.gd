extends RigidBody2D

export(PackedScene) var boom
onready var timer = $Timer
onready var parts = $CPUParticles2D
var speed = 800
var owned = 0
# warning-ignore:unused_class_variable
var my_name = "Grenade Launcher"
var damage = 0

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	print("make SFX for launcher")
	SFX.play("RPG_Shoot")
	if _scale.y < 0:
		rotation *= -1

func entered():
	call_deferred("_explode",self.global_position)

func _on_Timer_timeout():
	entered()

func _explode(_pos):
	var x = boom.instance()
	get_tree().get_current_scene().add_child(x)
	x.init(owned, _pos, my_name , 0, damage)
	remove_child(parts)
	Map_Hand.add_kid_to_map(parts)
	parts.time_out()
	call_deferred("free")


func _on_Proj42G_Launcher_body_entered(body):
	entered()

func _on_Proj42G_Launcher_body_shape_entered(body_id, body, body_shape, local_shape):
	entered()
