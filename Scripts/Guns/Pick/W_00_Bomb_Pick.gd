extends RigidBody2D

# onready var sprite = $Sprite
onready var timer = $Timer
onready var timer_boom = $Timer_Boom
onready var anim = $AnimationPlayer

export var gun_num = 0
export var damage = 100
export var ammo = 1
export var expire_time = 30.0
export var time = 4

var player = 0
var ready = false
var is_right = true
var dir = 3
var just_shot = false
var hits = 0
var hits_max = 5

func _ready():
	timer_boom.wait_time = time

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	player = _player
	timer_boom.wait_time = _time
	if _ammo > -1:
		ammo = int(clamp(_ammo,0,1))
	if _ammo == 0:
		ammo = 0
		timer_boom.start()
		anim.play("Armed")
	else:
		timer.start()
		anim.play("Idle")
	call_end_of_init()
	
func call_end_of_init():
	pass	

func _entered(_body_id, body, _body_shape, _local_shape):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		self.set_collision_mask_bit( 1, false)

func boom():
	FX.explode(10, player, self.global_position, gun_num, 0, damage)
	call_deferred("free")

func _on_body_entered(body):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:# body.get_groups().has("map_part"):
		self.set_collision_layer_bit( 1, false)
		self.set_collision_mask_bit( 1, false)

func _on_body_exited(_body):
	pass
	# if body.get_groups().has("player"):
	# 	body.stun(gun_num)
	# else:
	# 	dont_hit_player()

func set_dir(_is_right, _dir):
	is_right = _is_right
	dir = _dir
	if _is_right:
		# sprite.scale = Vector2(1.5, 1.5)
		if _dir == 1:
			self.rotation_degrees = -85
		elif _dir == 2:
			self.rotation_degrees = -45
		elif _dir == 3 || _dir == 6:
			self.rotation_degrees = 9
		elif _dir == 4:
			self.rotation_degrees = 45
		elif _dir == 5:
			self.rotation_degrees = 85
	else:
		# sprite.scale = Vector2(1.5, -1.5)
		if _dir == 1:
			self.rotation_degrees = -95
		elif _dir == 2:
			self.rotation_degrees = -135
		elif _dir == 3 || _dir == 6:
			self.rotation_degrees = -171
		elif _dir == 4:
			self.rotation_degrees = -220
		elif _dir == 5:
			self.rotation_degrees = -265

func _on_Timer_timeout():
	fade_out()

func fade_out():
	FX.smoke(self.global_position)
	call_deferred("free")
	
func dont_hit_player():
	self.set_collision_mask_bit( 1, false)