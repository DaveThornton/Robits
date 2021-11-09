extends RigidBody2D

onready var timer = $Timer
onready var parts = $CPUParticles2D

var power = 25
var speed = 800
var owned = 0
var my_name = "Grenade Launcher"
var damage = 0

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	self.apply_impulse(self.global_position,(self.global_position - Controllers.get_pawn(owned).arm.global_position) * Vector2(power,power))
	if _scale.y < 0:
		rotation *= -1

func entered():
	call_deferred("_explode",self.global_position)

func _on_Timer_timeout():
	entered()

func _explode(_pos):
	FX.explode(10, owned, _pos, "G_Launcher", 0, damage)
	remove_child(parts)
	Map_Hand.add_kid_to_map(parts)
	parts.time_out()
	call_deferred("free")

func _on_Proj42G_Launcher_body_entered(_body):
	entered()

func _on_Proj42G_Launcher_body_shape_entered(_body_id, _body, _body_shape, _local_shape):
	entered()
