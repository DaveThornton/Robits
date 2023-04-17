extends RigidBody2D

onready var timer = $Timer
onready var parts = $CPUParticles2D
onready var ray_forward = $RayCast2D
onready var ray_back = $RayCast2D2
onready var ray_down = $RayCast2D3
onready var ray_up = $RayCast2D4

var power = 25
var speed = 800
var owned = 0
var damage = 0
var gun_num = 0
var exploded = false

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
	timer.start()
	damage = _dmg
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	owned = _owner
	self.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	self.apply_impulse(self.global_position,(self.global_position - Controllers.get_pawn(owned).arm.global_position) * Vector2(power,power))
	if _scale.y < 0:
		rotation *= -1

func _process(_delta):
	if ray_forward.is_colliding() || ray_back.is_colliding() || ray_down.is_colliding() || ray_up.is_colliding():
		entered()

func entered():
	call_deferred("_explode",self.global_position)

func _on_Timer_timeout():
	entered()

func _explode(_pos):
	if !exploded:
		exploded = true
		FX.explode(gun_num, owned, _pos, gun_num, 0, damage )
		self.remove_child(parts)
		Map_Hand.add_kid_to_map(parts)
		parts.time_out()
		call_deferred("free")

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)

func _on_Proj42G_Launcher_body_entered(_body):
	entered()