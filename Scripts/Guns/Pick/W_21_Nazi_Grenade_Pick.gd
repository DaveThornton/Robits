extends RigidBody2D

# export(PackedScene) var boom
# export(PackedScene) var smoke
export var armed = false 

onready var timer = $Timer
onready var spin_timer = $Timer_Spin
onready var timer_boom = $Timer_Boom
onready var sprite = $Sprite_Body
onready var pin = $Sprite_Pin
onready var hand_right = $handle
onready var hand_left = $handle2
onready var label= $"FX-21-Timer_Label"

var player = 0
var my_name = "Nazi Grenade"
var damage = 100
var time = 3.5
var gun_num = 21
var ammo = 1
var is_right = false
var just_shot = false
var hits = 0
var hits_max = 5

func _ready():
	if armed:
		ammo = 0
		pin.visible = false
		label.visible = true
		timer_boom.wait_time = time
		timer_boom.start()

func _process(_delta):
	if ammo == 0:
		time = timer_boom.time_left
		print(time)
		label.set_time(time)

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	player = _player
	timer_boom.wait_time = _time
	if _ammo == 0:
		ammo = 0
		pin.visible = false
		label.visible = true
		timer_boom.start()
	else:
		label.visible = false
		timer.start()
func _on_Timer_Boom_timeout():
	FX.explode(10,player, self.global_position, my_name, 0, damage)
	call_deferred("free")

func spin(_how_much):
	if is_right:
		self.applied_torque = _how_much
	else:
		self.applied_torque = -_how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_WeapPick21NaziGrenade_body_entered(body):
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
		hand_right.disabled = false
		hand_left.disabled = true
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
		hand_right.disabled = true
		hand_left.disabled = false
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

func _on_Timer_Hit_timeout():
	dont_hit_player()

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)
