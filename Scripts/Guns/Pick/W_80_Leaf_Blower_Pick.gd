# extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'
extends RigidBody2D
export var expire_time = 30.0

onready var timer = $Timer
onready var sprite = $Sprite_Body

#var player = 0
var my_name = "Leaf_Blower"
var time = 3.0
var gun_num = 80
var ammo = 50

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	print_debug("time left: ",_time," in ", my_name)
	if _ammo == 0:
		ammo = 0
	else:
		timer.wait_time = expire_time
		timer.start()
	time = _time

func _on_WeapPick80Leaf_Blower_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		self.set_collision_mask_bit( 1, false)

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

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
			sprite.scale.y = -1

func _on_Timer_timeout():
	fade_out()

func fade_out():
	FX.smoke(self.global_position)
	call_deferred("free")

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)