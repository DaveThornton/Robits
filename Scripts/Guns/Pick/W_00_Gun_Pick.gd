extends RigidBody2D

onready var sprite = $Sprite
onready var timer = $Timer
onready var outline = $Sprite/Outline
export var gun_num = 0
export var expire_time = 30.0
export var ammo = -2
export var time = .1

var ready = false
var is_right = true
var dir = 3
var just_shot = false
var hits = 0
var hits_max = 5


func _ready():
	ready = true
	set_dir(is_right, dir)
	timer.wait_time = expire_time
	timer.start()
	call_end_ready()
	
func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	if _ammo != -1: 
		ammo = _ammo
	if ammo == 0:
		call_deferred("ammo_is_zero")
	is_right = _is_right
	time = _time
	if _time < 0:
		timer.stop()
	if ready:
		set_dir(is_right, dir)
	call_end_init()

func call_end_init():
	pass

func call_end_ready():
	pass

func _entered(_body_id, body, _body_shape, _local_shape):
	if hits < hits_max :
		hits += 1
		SFX.obj_collision()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		self.set_collision_mask_bit( 1, false)

func set_dir(_is_right, _dir):
	is_right = _is_right
	dir = _dir
	if _is_right:
		set_right()
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
		set_left()
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

func set_right():
	pass

func set_left():
	pass

func ammo_is_zero():
	pass

func _on_Timer_timeout():
	fade_out()

func fade_out():
	FX.smoke(self.global_position)
	call_deferred("free")
	
func dont_hit_player():
	self.set_collision_mask_bit( 1, false)

func set_outline_color(_color):
	outline.self_modulate = _color