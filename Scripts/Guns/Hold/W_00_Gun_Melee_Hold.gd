# extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'
extends Node2D

onready var gun_pos = $POS_Gun
onready var hit_area = $Melee_Area
onready var hit_area_shape = $Melee_Area/CollisionShape2D
onready var pos_throw = $Throw_Pos
onready var throw_cast = $Throw_Ray

export var gun_num = 0
# export var damage = 0
export var damage = 50
export var dmg_type = "none"
export var ammo_max = 1
export var walk_amount = 40.0
export var throw_power = 1000
export var time = 4.0

export var up_swing = 500
export var down_swing = 750

var player:int = 1
var ammo:int = 1
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var take_ammo = false
var just_shot = false
var can_shoot = true 
var stop_shoot = false
var shoot_pos = 3
var explode_num = 10
var change_shoot_pos = true
var is_right = true
var walk = 0.0


var swinging = false
var time_swing = 0.0
var walk_back = 40

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in gun melee hold 00. weap num ",gun_num)
	if Game.get_mode() == 0:
		hit_area.set_collision_layer(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _time, _just_shot):
	set_up()
	player = _player
	ammo = _ammo
	time = _time
	just_shot = _just_shot
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	hit_area.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	emit_signal("ammo_change",player,ammo)
	post_set_up()

func shoot_j():
	swing()

func shoot():
	pass

func shoot_r():
	un_swing()

func _process(delta):
	if swinging:
		walk = walk - down_swing * delta
		walk = clamp(walk,0,walk_back)
		gun_pos.rotation_degrees = gun_pos.rotation_degrees + down_swing * delta
		gun_pos.rotation_degrees = clamp(gun_pos.rotation_degrees,0,90)
	else:
		walk = walk + up_swing * delta
		walk = clamp(walk,0,walk_back)
		gun_pos.rotation_degrees = gun_pos.rotation_degrees - up_swing * delta
		gun_pos.rotation_degrees = clamp(gun_pos.rotation_degrees,0,90)
	if time_swing == 0.0:
		return
	elif time_swing < 0.0:
		hit_area_shape.disabled = true
		time_swing = 0.0
	time_swing -= delta

func swing():
	swinging = true
	Player_Stats.add_shot(player, 1)
	hit_area_shape.disabled = false
	time_swing = 0.5
	SFX.swing()

func un_swing():
	swinging = false
	time_swing = 0.0
	hit_area_shape.disabled = true

func throw():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_pick_ups(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	t.init(ammo, player, time, is_right, shoot_pos, true)
	if throw_cast.is_colliding():
		t.position = self.global_position
		_drop_where(t)
	else:
		t.position = pos_throw.global_position
		_throw_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func drop():
	call_deferred("_drop")
func _drop():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_pick_ups(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, time, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func _throw_where(_obj):
	var _throwing = Vector2(0,0)
	if shoot_pos == 1:
		_throwing = Vector2((throw_power * .1), -(throw_power * .7))
	elif shoot_pos == 2:
		_throwing = Vector2((throw_power * .6), -(throw_power * .4))
	elif shoot_pos == 3 || shoot_pos == 6:
		_throwing = Vector2((throw_power * .6), -(throw_power * .2))
	elif shoot_pos == 4:
		_throwing = Vector2((throw_power * .6), (throw_power * .2))
	elif shoot_pos == 5:
		_throwing = Vector2((throw_power * .1), (throw_power * .7))
	if !is_right:
		_throwing.x *= -1
	_obj.apply_impulse(pos_throw.position, _throwing)

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)

func add_ammo(_ammo):
	ammo = clamp(ammo + _ammo, 0, ammo_max)
	emit_signal("ammo_change",player,ammo)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, gun_num, dmg_type, damage)
			hit_sfx()
		else:
			print_debug("quit hitting your self")
	elif body.get_groups().has("hittable"):
		body.hit(player, gun_num, dmg_type, damage)
		hit_sfx()

func hit_sfx():
	SFX.melee_hit()

func set_up():
	pass

func post_set_up():
	pass
