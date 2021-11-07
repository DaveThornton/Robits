extends Node2D

# export(PackedScene) var bomb_man_pickup
# export(PackedScene) var boom

onready var timer = $Timer
onready var pos_throw = $POS_Gun/POS/Position2D
#onready var sprite_pin = $POS_Gun/Pin
onready var throw_cast = $POS_Gun/Raycast/RayCast2D
onready var anim = $AnimationPlayer

var player = 1
var gun_num = 23
var ammo = 1
var take_ammo = false
var my_name = "Bomb-Man"
var dmg_type = "Boom"
var damage = 100
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var time = 3.8

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 20 Grenade")

func init(_ammo, _player, _time, _just_shot):
	player = _player
	ammo = _ammo
	if _ammo <= 0:
		ammo = 0
		_armed(_time)
	else:
		timer.wait_time = time
	emit_signal("ammo_change",player,ammo)
	
func shoot_j():
	pass

func shoot():
	pass

func shoot_r():
	if can_shoot:
		if ammo > 0:
			ammo = 0
			_armed(time)
			can_shoot = false
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)

func _armed(_time):
	anim.play("Armed")
	anim.seek((time - _time), true)
	timer.wait_time = _time
	timer.start()

func melee():
	pass

func throw():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_map(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	t.init(ammo, player,timer.get_time_left(), is_right, shoot_pos, true)
	if throw_cast.is_colliding():
		t.position = self.global_position
	else:
		t.position = pos_throw.global_position
		_throw_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func drop():
	call_deferred("_drop")
func _drop():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, timer.get_time_left(), is_right, shoot_pos, false)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func _throw_where(_obj):
	if is_right:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(50, -400))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(300, -300))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(400, -100))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(300, 100))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(50, 350))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-50, -400))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-300, -300))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-400, -100))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-300, 100))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-50, 350))

func _on_Timer_timeout():
	var p = Controllers.get_pawn(player)
	p.my_gun = null
	p.is_holding = false
	FX.explode(25, player, self.global_position, my_name, 0, damage)
	call_deferred("free")
