extends Node2D

onready var pos_shoot = $POS_Gun/POS/Shoot
onready var pos_shell = $POS_Gun/POS/Shell
onready var pos_throw = $POS_Gun/POS/Throw

onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw

onready var melee_area = $POS_Gun/Melee_Area

onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var anim_fire = $AnimationPlayer

export var gun_num = 0
export var damage = 0
export var melee_damage = 50
export var dmg_type = "none"
export var ammo_max = 0
export var can_melee = true
export var take_ammo = true
export var use_ammo = true
export var eject_shell = true
export var walk_amount = 0.0
export var throw_power = 1000
export var time = 4.0

var player:int = 1
var ammo:int = 1
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var just_shot = false
var can_shoot = true 
var stop_shoot = false
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 00 mega cannon")
	if Game.get_mode() == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())
		melee_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _timer, _just_shot):
	set_up()
	player = _player
	ammo = _ammo
	time = _timer
	just_shot = _just_shot
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_area.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	emit_signal("ammo_change",player,ammo)
	anim_fire.play("Idle")
	post_set_up()

func set_up():
	pass

func post_set_up():
	pass

func _process(delta):
	if walk > 0.0:
		if walk > 30:
			walk -= delta * 50
		else:
			walk -= delta * 40
		if walk < 0.0:
			walk = 0.0

func shoot_j():
	pass

func shoot():
	pass

func shoot_r():
	pass

func _fire():
	# print("shoot")
	if can_shoot && !stop_shoot:
		# print("shoot?   ", ammo)
		if ammo > 0:
			# print("shoot? ammo  ", ammo)
			can_shoot = false
			just_shot = true
			shoot_timer.start()
			# shoot_cast.force_raycast_update()
			# melee_cast.force_raycast_update()
			if !shoot_cast.is_colliding():
				_fire_projectile()
			elif can_melee && melee_cast.is_colliding():
				melee()
				
			elif shoot_cast.is_colliding():
				_fire_no_projectile()
		else:
			empty()
		
func _fire_sound():
	SFX.projectile(gun_num)

func _fire_projectile():
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	var _sss = pos_shoot.global_scale
	FX.proj(gun_num, _sr, _ss, _sss, player, damage)
	end_of_fire()
	call_on_projectile_fired()

func _fire_no_projectile():
	var _thing = shoot_cast.get_collider()
	if _thing.get_groups().has("hittable"):
		_thing.hit(player, gun_num, dmg_type, damage)
		end_of_fire()
		call_on_hit_with_no_projectile(_thing)
	
func end_of_fire():
	anim_fire.play("Shoot")
	if use_ammo:
		ammo = clamp(ammo - 1, 0, ammo_max)
	emit_signal("ammo_change",player,ammo)
	Player_Stats.add_shot(player, 1)
	walk += walk_amount
	_fire_sound()
	if eject_shell:
		shell()
	call_on_all_projectile_fire()

func call_on_all_projectile_fire(): pass
func call_on_projectile_fired(): pass
func call_on_hit_with_no_projectile(_thing): pass

func melee():
	can_shoot = false
	anim_fire.play("Melee")
	melee_timer.start()
	Player_Stats.add_shot(player, 1)
	call_on_melee()
func call_on_melee(): pass

func empty():
	pass

func shell(): FX.shell(gun_num, pos_shell.global_position, pos_shell.global_rotation)

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

func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player") && can_melee:
		if body.player != player:
			body.hit(player, gun_num, dmg_type, melee_damage)
		else:
			print_debug("quit hitting your self")
	elif !can_melee:
		print_debug("this gun is set to not melee so no damage was given")
