extends RigidBody2D

export var expire_time = 30.0
export var armed = false

onready var timer = $Timer
onready var hit_timer =  $Timer_Hit
onready var spin_timer = $Timer_Spin
# onready var timer_boom = $Timer_Boom
onready var sprite = $Sprite_Body
onready var label= $"FX-21-Timer_Label"

var player = 0
var my_name = "Time Bomb"
var damage = 100
var time = 6.0
var gun_num = 25
var ammo = 1
var is_right = false
var just_shot = false
var hits = 0 
var hits_max = 5

func _ready():
	if armed:
		ammo = 0
		label.visible = true
		# timer_boom.wait_time = time
		# timer_boom.start()

func _process(delta):
	# time = timer_boom.time_left
	label.set_time(time)
	if ammo <= 0:
		time -= delta
		if time <= 0:
			go_boom()
	

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	player = _player
	if _ammo == 0:
		ammo = 0
		time = _time
		# timer_boom.wait_time = _time
		# timer_boom.start()
	else:
		timer.wait_time = expire_time
		timer.start()

func go_boom():
	FX.explode(25, player, self.global_position, gun_num, 0, damage)
	call_deferred("free")

func _on_WeapPick20Grenade_body_exited(body):
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:
		dont_hit_player()

func _on_Timer_Hit_timeout():
	dont_hit_player()

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func set_dir(_is_right, _dir):
	is_right = _is_right
	if _is_right:
		# label.rotation = 0
		# label.position = Vector2(0,20)
		# label.scale.y = 1
		self.scale.y = 1
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
		# label.rotation = 180
		# label.position = Vector2(0,-20)
		# label.scale.y = -1
		self.scale.y = -1
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


func _on_W_24_TNT_Pick_body_entered(_body):
	if hits < hits_max :
		hits += 1
		SFX.hit()
