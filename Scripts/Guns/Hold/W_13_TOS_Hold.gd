extends Node2D

const MAX_LENGTH = 750

onready var anim_fire = $AnimationPlayer

onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
# onready var shoot_cast = $POS_Gun/Gun_Sprite/Shoot_cast
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var beam_end = $POS_Gun/Gun_Sprite/Laser_Sprite/Shoot
onready var pos_throw = $POS_Gun/POS/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var beam = $POS_Gun/Gun_Sprite/Laser_Sprite
onready var melee_area = $POS_Gun/Melee_Area

var player = 1
var gun_num = 13
var ammo = 250
var ammo_max = 550
#var shot_count = 0
var take_ammo = true
var my_name = "TOS"
var dmg_type = "Laser"
var damage = 10
var m_damage = 35
var can_shoot = true
var just_shot = false
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 0.0
var time = 4.0
var shoot_pressed = false
var shoot_real = true #if true it shoots a laser that kills if false its for fx

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 13 TOS")
	if Game.mode == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_b())
		melee_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_b())

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_area.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	emit_signal("ammo_change",player,ammo)

func _physics_process(_delta):

	if shoot_pressed && can_shoot && ammo >= 1 && !melee_cast.is_colliding():
		SFX.play("W_13_Shoot")
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		if is_right:
			_sr = pos_shoot.global_rotation
		else:
			_sr = pos_shoot.global_rotation * -1
		var _sss = pos_shoot.global_scale
		FX.proj(gun_num, _sr, _ss, _sss, player, damage)
		ammo = clamp(ammo - 1, 0, ammo_max)
		emit_signal("ammo_change",player,ammo)
		Player_Stats.add_shot(player, 1)
		shoot_timer.start()
		can_shoot = false
	elif shoot_pressed && !can_shoot && ammo >= 1 && !melee_cast.is_colliding():
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		if is_right:
			_sr = pos_shoot.global_rotation
		else:
			_sr = pos_shoot.global_rotation * -1
		var _sss = pos_shoot.global_scale
		FX.proj(gun_num, _sr, _ss, _sss, player, 0)
	elif shoot_pressed && melee_cast.is_colliding():
		melee()
	else:
		SFX.stop("W_13_Shoot")

func shoot_j():
	shoot_pressed = true
	anim_fire.play("Shoot")

func shoot():
	pass

func shoot_r():
	shoot_pressed = false
	anim_fire.play("UnShoot")
	SFX.stop("W_13_Shoot")


func melee():
	if can_shoot:
		can_shoot = false
		anim_fire.play("Melee")
		melee_timer.start()
		Player_Stats.add_shot(player, 1)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("hittable"):
		if body.player != player:
			body.hit(player, my_name, dmg_type, m_damage)
		else:
			print_debug("quit hitting your self")

func throw():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_map(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
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
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func add_ammo(_ammo):
	ammo = clamp(ammo + _ammo, 0, ammo_max)
	emit_signal("ammo_change",player,ammo)

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

func _hit(_pos):
	FX.proj_hit(gun_num, _pos, true)

func _hit_nothing(_pos):
	FX.proj_hit(gun_num, _pos, false)

func _on_Melee_Timer_timeout():
	can_shoot = true


func _on_Shoot_Timer_timeout():
	can_shoot = true
