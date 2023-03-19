extends 'res://Scripts/Guns/Pick/W_00_Gun_Pick.gd'

# export var expire_time = 30.0

# onready var sprite = $Sprite
# onready var timer = $Timer

# var ready = false
# var gun_num = 6
# var ammo = 150
# var time = .1
# var is_right = true
# var dir = 3
# # warning-ignore:unused_class_variable
# var just_shot = false
# var hits = 0
# var hits_max = 5

# func _ready():
# 	ready = true
# 	set_dir(is_right, dir)
	
# func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
# 	if ammo != _ammo:
# 		if ammo < _ammo:
# 			expire_time = expire_time * 2
# 		elif ammo > _ammo:
# 			expire_time = expire_time * .75
# 		elif _ammo == 0:
# 			expire_time = expire_time * .1
		
# 		if _ammo != -1: 
# 			ammo = _ammo
# 	timer.wait_time = expire_time
# 	timer.start()
# 	time = _time
# 	if ready:
# 		set_dir(is_right, dir)

func _on_WeapPick10Blaster_Pistol_body_shape_entered(_body_id, body, _body_shape, _local_shape):
	_entered(_body_id, body, _body_shape, _local_shape)
# 	if hits < hits_max :
# 		hits += 1
# 		SFX.hit()
# 	if body.get_groups().has("player"):
# 		body.stun(gun_num)
# 	else:
# 		self.set_collision_mask_bit( 1, false)

# func _on_Timer_Hit_timeout():
# 	self.set_collision_layer_bit( 1, false)
# 	self.set_collision_mask_bit( 1, false)

# func set_dir(_is_right, _dir):
# 	is_right = _is_right
# 	dir = _dir
# 	if _is_right:
# 		if _dir == 1:
# 			self.rotation_degrees = -85
# 			sprite.scale.y = 1
# 		elif _dir == 2:
# 			self.rotation_degrees = -45
# 			sprite.scale.y = 1
# 		elif _dir == 3 || _dir == 6:
# 			self.rotation_degrees = 9
# #			sprite.scale.y = 1
# 		elif _dir == 4:
# 			self.rotation_degrees = 45
# 			sprite.scale.y = 1
# 		elif _dir == 5:
# 			self.rotation_degrees = 85
# 			sprite.scale.y = 1
# 	else:
# 		if _dir == 1:
# 			self.rotation_degrees = -95
# 			sprite.scale.y = -1
# 		elif _dir == 2:
# 			self.rotation_degrees = -135
# 			sprite.scale.y = -1
# 		elif _dir == 3 || _dir == 6:
# 			self.rotation_degrees = -171
# 			sprite.scale.y = -1
# 		elif _dir == 4:
# 			self.rotation_degrees = -220
# 			sprite.scale.y = -1
# 		elif _dir == 5:
# 			self.rotation_degrees = -265
# 			sprite.scale.y = -1
			
# func _on_Timer_timeout():
# 	fade_out()

# func fade_out():
# 	FX.smoke(self.global_position)
# 	call_deferred("free")
	
# func dont_hit_player():
# 	self.set_collision_mask_bit( 1, false)
