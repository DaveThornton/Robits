extends Area2D

onready var cast = $RayCast2D
onready var timer = $Timer
var speed = 1800
var owned = 1
var my_name = "Cricket"
var damage = 150
var damage_type = "laser"
var gun_num = 0

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
	timer.start()
	rotation = _rot + rand_range(-.02, .02)
	position = _pos
	scale = _scale
	owned = _owner
	cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if cast.is_colliding():
		FX.explode(18, owned, cast.get_collision_point(), gun_num, 0, damage)
		call_deferred("free")
	move_local_x(speed * delta)

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	cast.set_collision_mask(_bit)
	
func _on_Timer_timeout():
	call_deferred("free")