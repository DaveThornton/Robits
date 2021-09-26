extends RigidBody2D

export(PackedScene) var boom
export(PackedScene) var smoke
export var armed = false 

onready var spin_timer = $Timer_Spin
#onready var timer_boom = $Timer_Boom
onready var timer_boom = $"22-plasma-det/Timer"
onready var sprite = $Sprite_Body
onready var pin = $Sprite_Pin
onready var det = $"22-plasma-det"

var player = 0
var my_name = "Plasma Grenade"
var damage = 100
var time = 5.5
var gun_num = 22
var ammo = 1
var is_right = false
var just_shot = false
var hits = 0
var hits_max = 5

func _ready():
	if armed:
		ammo = 0
		det.init(player, time, true)
		pin.visible = false
		det.visible = true
		timer_boom.wait_time = time
		timer_boom.start()		

func _process(_delta):
	time = timer_boom.time_left

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	print(_time)
	player = _player
	if _ammo  == 0:
		ammo = 0
		pin.visible = false
		det.init(player,_time,true)
		timer_boom.wait_time = _time
		timer_boom.start()

func add_det(_det):
	# det.queue_free()
	self.add_child(_det)
	det = _det

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_WeapPick22PlasmaGrenade_body_entered(body):
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
	if _is_right:
		sprite.rotation_degrees = 180
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
		sprite.rotation_degrees = 0
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
	var s = smoke.instance()
	Map_Hand.add_kid_to_map(s)
	s.start( 0 , self.global_position, 0, 0)
	call_deferred("free")#queue_free()

func _on_Area2D_body_entered(body):
	# print(det.part.visible, body)
	if ammo == 0 && body.get_groups().has("player"):
		self.remove_child(det)
		body.attachment_point.attach(det)
		print("hit person")
		call_deferred("free")

func booming():
	call_deferred("free")

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)