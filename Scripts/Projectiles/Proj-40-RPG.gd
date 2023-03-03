extends Area2D

onready var timer = $Timer
onready var cast_forward = $RayCast2D
var speed = 800
var owned = 0
onready var anim = $AnimationPlayer
var damage
var gun_num = 0

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	cast_forward.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	anim.play("fire")
	SFX.play("RPG_Shoot")
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	move_local_x(speed * delta)
	speed = speed * 1.01
	if cast_forward.is_colliding():
		FX.explode(2, owned, self.global_position, gun_num, 0, damage)
		call_deferred("_explode", position)


func _on_Timer_timeout():
	_explode(self.global_position)

func _on_Timer2_timeout():
	_explode(self.global_position)

func set_layer(_bit):#camp 2048
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast_forward.set_collision_mask(_bit)

func _explode(_pos):
	FX.explode(10, owned, _pos, "RPG", 0, damage)
	call_deferred("free")