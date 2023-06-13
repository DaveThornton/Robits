extends RigidBody2D

export var expire_time = 30.0
export var gun_num = 0
export var damage = 99

onready var sprite = $Sprite
onready var outline = $Sprite/Outline
onready var timer = $Timer
onready var spin_timer = $Timer_Spin

var owned = 1
var dmg_type = "Melee"

var ammo = 0
var time = .1
var is_right = true
var just_shot = false

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	owned = _player
	time = _time
	ammo = _ammo
	self.set_collision_mask_bit( 1, _just_shot)
	self.set_collision_mask_bit( 12, _just_shot)

func _integrate_forces(state):
	if warping:
		state.transform.origin = warp_to_pos
		warping = false

func warp_to(_to:Vector2):
	warp_to_pos = _to
	warping = true

func _on_Timer_timeout():
	self.set_collision_mask_bit( 1, false)
	self.set_collision_mask_bit( 11, false)

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_body_entered(body):
	if body.get_groups().has("hittable"):
		body.hit(owned, gun_num, dmg_type,damage)
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
	FX.smoke(self.global_position)
	call_deferred("free")

func set_outline_color(_color):
	outline.self_modulate = _color
