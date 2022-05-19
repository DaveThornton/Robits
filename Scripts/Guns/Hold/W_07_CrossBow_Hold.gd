extends Node2D

onready var anim = $AnimationPlayer
onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var reload_timer = $Reload_Timer
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var pos_throw = $POS_Gun/POS/Throw
onready var melee_area = $POS_Gun/Area2D

var player = 1
var pawn = 0
var gun_num = 7
var ammo = 8
var ammo_max = 16
var take_ammo = true
var my_name = "CrossBow"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Bullet"
var damage = 75
var can_shoot = true 
var just_shot = false
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 15.0
var time = 4.0

signal ammo_change(player, ammo)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 02 M-16")
	if Game.mode == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())
		melee_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_area.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	if walk > 0.0:
		walk -= delta * 35
		if walk < 0.0:
			walk = 0.0

func shoot_j():
	pass

func shoot():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		elif ammo > 0 :
			just_shot = true
			anim.play("Shoot")
			if !shoot_cast.is_colliding():
				can_shoot = false
				shoot_timer.start()
			else:
				print("to close  weap 07 crossbow")
				walk += walk_amount
				if shoot_cast.get_collider().get_groups().has("map"):
					var spot = shoot_cast.get_collision_point()
					var x = FX.stuck_bolt().instance()
					Map_Hand.add_kid_to_map(x)
					x.init(player, damage, spot, rotation, scale, 2)
					print("map")
				else:
					var spot = shoot_cast.get_collision_point()
					print(spot)
					var x = FX.stuck_bolt().instance()
					shoot_cast.get_collider().add_child(x)
					x.init(player, damage, spot, rotation, scale, 2)
					print("not map")
			can_shoot = false
			shoot_timer.start()
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			print("make cross bow have its own sound weap 07")
			SFX.play("W_07_Shoot")
		else:
			can_shoot = false
			shoot_timer.start()
			SFX.play("W_07_Empty")

func shoot_r():
	pass

func melee():
	if can_shoot:
		can_shoot = false
		anim.play("Melee")
		melee_timer.start()
		Player_Stats.add_shot(player, 1)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type, damage)
		else:
			print("quit hitting your self")

func throw():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_map(t)
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

func _on_Shoot_Timer_timeout():
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	#---------------------------------------------------------------
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	#---------------------------------------------------------------
	var _sss = pos_shoot.global_scale
	FX.proj(gun_num, _sr, _ss, _sss, player, damage)
	walk += walk_amount
	just_shot = true
	reload_timer.start()
	

func _on_Melee_Timer_timeout():
	can_shoot = true

func _on_Reload_Timer_timeout():
	if just_shot:
		anim.play("Reload")
		just_shot = false
		can_shoot = true
