extends RigidBody2D

export(PackedScene) var boom
export(PackedScene) var smoke
export var armed = false 

onready var timer = $Timer
onready var spin_timer = $Timer_Spin
#onready var hit_timer =  $Timer_Hit
onready var timer_boom = $Timer_Boom
onready var sprite = $Sprite_Body
onready var pin = $Sprite_Pin
onready var hand_right = $handle
onready var hand_left = $handle2

var player = 0
var my_name = "Nazi Grenade"
var damage = 100
var time = 3.5
var gun_num = 21
var ammo = 1

func _ready():
	if armed:
		ammo = 0
		pin.visible = false
		timer_boom.wait_time = time
		timer_boom.start()		

#warning-ignore:unused_argument
func _process(delta):
	time = timer_boom.wait_time

func init(_ammo, _player, _time, _is_right, _dir, _just_shot):
	set_dir(_is_right, _dir)
	print(_time)
	player = _player
	if _ammo  == 0:
		ammo = 0
		pin.visible = false
		timer_boom.wait_time = _time
		timer_boom.start()
	else:
		timer.wait_time = 30
		timer.start()

func _on_Timer_Boom_timeout():
	var b = boom.instance()
	Map_Hand.add_kid_to_map(b)
#	self.get_tree().get_current_scene().add_child(b)
#	b.position = self.global_position
	b.init(player, self.global_position, my_name, 0, damage)
	queue_free()

#func _on_WeapPick20Grenade_body_exited(body):
#	if body.get_groups().has("player"):
#		body.stun(gun_num)
#	else:# body.get_groups().has("map_part"):
#		self.set_collision_layer_bit( 1, false)
#		self.set_collision_mask_bit( 1, false)

func spin(_how_much):
	self.applied_torque = _how_much
	spin_timer.start()

func _on_Timer_Spin_timeout():
	self.applied_torque = 0

func _on_WeapPick21NaziGrenade_body_entered(body):
	if body.get_groups().has("player"):
		body.stun(gun_num)
	else:# body.get_groups().has("map_part"):
		self.set_collision_layer_bit( 1, false)
		self.set_collision_mask_bit( 1, false)

func set_dir(_is_right, _dir):
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
	var s = smoke.instance()
	Map_Hand.add_kid_to_map(s)
#	get_tree().get_current_scene().add_child(s)
	s.start( 0 , self.global_position, 0, 0)
	queue_free()

func _on_Timer_Hit_timeout():
	dont_hit_player()

func dont_hit_player():
	self.set_collision_mask_bit( 1, false)