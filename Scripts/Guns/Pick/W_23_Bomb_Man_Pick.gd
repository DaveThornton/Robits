extends RigidBody2D

onready var timer = $Timer
onready var timer_boom = $Timer_Boom
onready var anim = $AnimationPlayer
onready var label_time= $"FX-21-Timer_Label"

var player = 0
var my_name = "Bomb-Man"
var damage = 100
var time = 3.8
var gun_num = 23
var ammo = 1
var ready = false
var just_shot = false
var hits = 0
var hits_max = 5

func _ready():
	self.set_collision_mask_bit( 1, just_shot)
	self.set_collision_mask_bit( 9, just_shot)
	self.set_collision_mask_bit( 11, just_shot)

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	player = _player
	if _ammo == 0:
		ammo = 0
		label_time.visible = true
		_armed(_time)
	else:
		label_time.visible = false
		timer.wait_time = 30
		timer.start()
	just_shot = _just_shot
	self.set_collision_mask_bit( 1, just_shot)
	self.set_collision_mask_bit( 9, just_shot)
	self.set_collision_mask_bit( 11, just_shot)

func _process(_delta):
	if ready:
		time = timer_boom.get_time_left()
		label_time.set_time(time)

func _armed(_time):
	ready = true
	anim.play("Lit")
	print_debug(_time,"  this is the time it is tring to set in bomb man pick maybe why it randomly explodes?")
	anim.seek((time -_time),true)
	timer_boom.wait_time = _time
	timer_boom.start()

func hit(_owned, _my_name, _damage_type, _damage1):
	if ready:
		_armed(time)
		player =  _owned

func _on_TimerBoom_timeout():
	fade_out()

func fade_out():
	FX.explode(25, player, self.global_position, my_name, 0, damage)
	call_deferred("free")

func _on_Timer_timeout():
	ready = true

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)

func _on_W_23_Bomb_Man_Pick_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
		dont_hit_player()

func _on_W_23_Bomb_Man_Pick_body_entered(body):
	if body.get_groups().has("player"):
		body.stun(gun_num)
		dont_hit_player()
	else:
		dont_hit_player()
