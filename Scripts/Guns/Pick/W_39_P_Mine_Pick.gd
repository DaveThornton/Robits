extends RigidBody2D

export var expire_time = 30.0

onready var sprite = $Sprite
onready var timer = $Timer
onready var shape = $Big_CollisionShape2D
onready var ray_up = $Raycast/Up
onready var ray_left = $Raycast/Left
onready var ray_right = $Raycast/Right
onready var ray_down = $Raycast/Down

var player = 0
var gun_num = 39
var ammo = 1
var armed = false
var time = .1
var is_right = true
var dir = 3
var just_shot = false
var my_name = "Prox Mine"
var dmg_type = "Boom"
var damage = 120
var hits = 0
var hits_max = 5

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	if _ammo == -1:
		ammo = 1
	else:
		ammo = _ammo
	if ammo < 1:
		armed = true
		shape.disabled = true
		print("mine 30 armed = ", armed)
	player = _player
	is_right = _is_right
	timer.wait_time = expire_time
	timer.start()
	time = _time

func _physics_process(_delta):
	if armed:
		self.rotation_degrees = 0
		if ray_up.is_colliding():
			var a = ray_up.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 0)
			queue_free()
			return
		if ray_left.is_colliding():
			var a = ray_left.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, -90)
			queue_free()
			return
		if ray_right.is_colliding():
			var a = ray_right.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 90)
			queue_free()
			return
		if ray_down.is_colliding():
			var a = ray_down.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 180)
			queue_free()
			return

func _on_W_39_P_Mine_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		self.set_collision_mask_bit( 1, false)

func _on_Timer_timeout():
	fade_out()

func fade_out():
	FX.smoke(self.global_position)
	call_deferred("free")
	
func dont_hit_player():
	self.set_collision_mask_bit( 1, false)
