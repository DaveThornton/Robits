extends RigidBody2D

export(PackedScene) var smoke
export var expire_time= 30.0
onready var sprite = $Sprite
#onready var tip = $CollisionPolygon2D
onready var timer = $Timer

var ready = false
var dir = 3
var is_right = true
var gun_num = 40
var ammo = 4
var time = 4.0
var frame = 0

func _ready():
	sprite.frame = frame
	ready = true
	set_dir(is_right, dir)

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	if ammo != _ammo:
		if ammo < _ammo:
			expire_time = expire_time * 2
		elif _ammo == 0:
			frame = 1
			sprite.frame = 1
			expire_time = expire_time * .1
		elif ammo > _ammo:
			expire_time = expire_time * .75
		if _ammo != -1: 
			ammo = _ammo
	timer.wait_time = expire_time
	timer.start()
	time = _time
	is_right = _is_right
	dir = _dir
	if ready:
		set_dir(is_right, dir)

func _on_Des_Timer_timeout():
	var s = smoke.instance()
	get_tree().get_current_scene().add_child(s)
	s.start( 0 , self.global_position, 0, 0)
	queue_free()

func _on_WeapPick40RPG_body_entered(body):
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:#
		self.set_collision_mask_bit( 1, false)

func set_dir(_is_right, _dir):
	if _is_right:
		if _dir == 1:
			self.rotation_degrees = -85
			sprite.scale.y = 1
		elif _dir == 2:
			self.rotation_degrees = -45
			sprite.scale.y = 1
		elif _dir == 3 || _dir == 6:
			self.rotation_degrees = 9
			sprite.scale.y = 1
		elif _dir == 4:
			self.rotation_degrees = 45
			sprite.scale.y = 1
		elif _dir == 5:
			self.rotation_degrees = 85
			sprite.scale.y = 1
	else:
		if _dir == 1:
			self.rotation_degrees = -95
			sprite.scale.y = -1
		elif _dir == 2:
			self.rotation_degrees = -135
			sprite.scale.y = -1
		elif _dir == 3 || _dir == 6:
			self.rotation_degrees = -171
			sprite.scale.y = -1
		elif _dir == 4:
			self.rotation_degrees = -220
			sprite.scale.y = -1
		elif _dir == 5:
			self.rotation_degrees = -265