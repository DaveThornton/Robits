extends Node2D

export(PackedScene) var p_mine_pickup
#export(PackedScene) var boom

onready var pos_throw = $Position2D
onready var throw_cast = $RayCast2D

var player = 1
var gun_num = 39
var ammo = 1
# warning-ignore:unused_class_variable
var take_ammo = false
#var armed = false
var my_name = "Prox Mine"
var dmg_type = "Boom"
var damage = 120
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var time = 4.0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 20 Grenade")

func init(_ammo, _player, _time, _just_shot):
	player = _player
	ammo = _ammo
#	if _ammo <= 0:
#		ammo = 0
#		timer.wait_time = _time
#		timer.start()
#	else:
#		timer.wait_time = time
	emit_signal("ammo_change",player,ammo)
	
func shoot_j():
	pass

func shoot():
	pass

func shoot_r():
	if can_shoot:
		if ammo > 0:
			can_shoot = false
			ammo = 0
			Controllers.get_pawn(player).no_gun()
			throw()
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)

func melee():
	pass

func throw():
	var t = p_mine_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	t.init(ammo, player, time, is_right, shoot_pos, false)
	if throw_cast.is_colliding():
		t.position = self.global_position
		_drop_where(t)
	else:
		t.position = pos_throw.global_position
		_throw_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = p_mine_pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, time, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func _throw_where(_obj):
	if is_right:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(100, -700))
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -400))
		elif shoot_pos == 3 || shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -700))
		elif shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -400))
		elif shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -200))
		elif shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		elif shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)
