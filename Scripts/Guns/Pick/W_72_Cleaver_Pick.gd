extends RigidBody2D

export(PackedScene) var smoke
export var expire_time = 30.0

onready var sprite = $Sprite
onready var timer = $Timer
onready var spin_timer = $Timer_Spin

var owned = 1
var my_name = "Cleaver"
var damage_type = "Melee"
var damage = 99
var gun_num = 72
var ammo = 0
var time = .1
var is_right = true
# warning-ignore:unused_class_variable
var just_shot = false

func _ready():
	gun_num = gun_num

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	owned = _player
	time = _time
	ammo = _ammo
	self.set_collision_mask_bit( 1, _just_shot)
	self.set_collision_mask_bit( 9, _just_shot)
	self.set_collision_mask_bit( 11, _just_shot)

func _on_Timer_timeout():
	self.set_collision_mask_bit( 1, false)
	self.set_collision_mask_bit( 9, false)
	self.set_collision_mask_bit( 11, false)

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_WeapPick60Axe_body_entered(body):
	if body.get_groups().has("hittable"):
		body.hit(owned, my_name, damage_type,damage)
	else:
		timer.start()

func set_dir(_is_right, _dir):
	is_right = _is_right
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
			sprite.scale.y = -1
func dont_hit_player():
	self.set_collision_mask_bit( 1, false)

func fade_out():
	print("gun number: ", gun_num, " *poof*")
	var s = smoke.instance()
	Map_Hand.add_kid_to_map(s)
	s.start( 0 , self.global_position, 0, 0)
	call_deferred("free")
