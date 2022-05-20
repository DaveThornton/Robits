extends Area2D

onready var timer = $Timer
onready var cast_forward = $RayCast2D
onready var anim = $AnimationPlayer
var speed = 300
var owned = 0
var my_name = "BFG 9000"
var damage

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	cast_forward.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	anim.play("Move")
	SFX.play("W_56_Projectile")
	print("make sfx for BFG 9000 projectile")
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	move_local_x(speed * delta)
	speed = speed * 1.01
	if cast_forward.is_colliding():
		call_deferred("_explode", position)

func _on_Timer_timeout():
	_explode(self.global_position)

func _on_Timer2_timeout():
	_explode(self.global_position)

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast_forward.set_collision_mask(_bit)

func _explode(_pos):
	FX.explode(56.1, owned, _pos, my_name, 0, damage)
	SFX.stop("W_56_Projectile")
	call_deferred("free")
