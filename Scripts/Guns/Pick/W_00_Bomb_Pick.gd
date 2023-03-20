extends RigidBody2D

onready var timer = $Timer
onready var spin_timer = $Timer_Spin
onready var anim = $AnimationPlayer
onready var label= $"FX-21-Timer_Label"

export var gun_num = 0
export var damage = 100
export var ex_num = 10
export var ammo = 1
export var expire_time = 30.0
export var my_time = 4.0
export var use_time_label = true
export var use_spin = true
export var spin_amount = 2000

var player = 0
var is_right = true
var dir = 3
var just_shot = false
var hits = 0
var hits_max = 5
var time

func _ready():
	time = my_time

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	player = _player
	time = _time
	if _ammo == 0:
		arm()
	else:
		timer.wait_time = expire_time
		timer.start()
		anim.play("Idle")
	if player > 0 && use_spin:
		spin(spin_amount)
	call_end_of_init()

func call_end_of_init(): pass	
func call_if_armed(): pass

func arm():
	ammo = 0
	anim.play("Armed")
	if use_time_label:
		label.visible = true
	else:
		label.visible = false
	call_if_armed()

func _process(_delta):
	if ammo == 0:
		time -= _delta
		if time <= 0:
			go_boom()
		if use_time_label:
			label.set_time(time)
		
func _entered(_body_id, body, _body_shape, _local_shape):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		self.set_collision_mask_bit( 1, false)

func go_boom():
	FX.explode(ex_num, player, self.global_position, gun_num, 0, damage)
	call_deferred("free")

func _on_body_entered(body:Node):
	if hits < hits_max :
		hits += 1
		SFX.hit()
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:# body.get_groups().has("map_part"):
		self.set_collision_layer_bit( 1, false)
		self.set_collision_mask_bit( 1, false)

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
	call_end_of_set_dir()
	
func call_end_of_set_dir(): pass

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_Timer_timeout():
	fade_out()

func fade_out():
	FX.smoke(self.global_position)
	call_deferred("free")
	
func dont_hit_player():
	self.set_collision_mask_bit( 1, false)
