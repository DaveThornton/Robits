extends Area2D

export var time_out = 1.0

onready var cast_forward = $RayCast2D
onready var anim = $AnimationPlayer

var speed = 800
var owned = 0
var damage
var gun_num = 0

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
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
	time_out -= delta
	move_local_x(speed * delta)
	speed = speed * 1.01
	if cast_forward.is_colliding():
		FX.explode(2, owned, self.global_position, gun_num, 0, damage)
		call_deferred("_explode", position)
	if time_out <= 0.0:
		_explode(self.global_position)

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast_forward.set_collision_mask(_bit)

func _explode(_pos):
	FX.explode(40, owned, _pos, gun_num, 0, damage)
	call_deferred("free")
