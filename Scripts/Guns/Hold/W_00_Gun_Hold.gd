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

export var gun_num: int = 0
export var damage: int = 0
export var melee_damage: int = 50
export var dmg_type: String = "none"
export var ammo_max: int = 0
export var can_melee: bool = true
export var take_ammo: bool = true
export var use_ammo: bool = true
export var eject_shell: bool = true
export var is_bomb: bool = false
export var walk_amount: float = 0.0
export var throw_power: int = 1000
export var time: float = 4.0
export var ammo_up_amount: int = 0

var player:int = 1
var ammo:int = 1
var new_anim: String = "Un_pos"
var old_anim: String = "Un_pos"
var just_shot:bool = false
var can_shoot:bool = true 
var stop_shoot:bool = false
var shoot_pos:int = 3
var explode_num:int = 10
var change_shoot_pos:bool = true
var is_right:bool = true
var walk:float = 0.0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 00 mega cannon")
	if Game.get_mode() == 0 && !is_bomb:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())
		melee_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _time, _just_shot):
	set_up()
	player = _player
	ammo = _ammo
	time = _time
	just_shot = _just_shot
	
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	if !is_bomb:
		shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	if can_melee:
		melee_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
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
	if is_bomb:
		if ammo <= 0:
			time -= delta
			if time <= 0:
				go_boom()
	called_on_process(delta)
func called_on_process(_delta): pass

func shoot_j():
	pass

func shoot():
	pass

func shoot_r():
	can_shoot = true

func _fire():
	if can_shoot && !stop_shoot:
		if ammo > 0:
			can_shoot = false
			shoot_timer.start()
			anim_fire.play("Shoot")
			if !shoot_cast.is_colliding():
				_fire_projectile()
				just_shot = true
			elif can_melee && melee_cast.is_colliding():
				melee()
			elif shoot_cast.is_colliding():
				_fire_no_projectile()
				just_shot = true
		else:
			empty()
			can_shoot = false
		
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
	else:
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
	SFX.swing()
	call_on_melee()
func call_on_melee(): pass

func go_boom():
	var p = Controllers.get_pawn(player)
	p.my_gun = null
	p.is_holding = false
	FX.explode(explode_num, player, self.global_position, gun_num, 0, damage)
	call_deferred("free")

func empty():
	SFX.empty(gun_num)

func shell(): FX.shell(gun_num, pos_shell.global_position, pos_shell.global_rotation)

func throw():
	var t = Equipment.get_weap_pick(gun_num).instance()
	Map_Hand.add_kid_to_map(t)
	if shoot_pos == 6:
		pos_throw.position.x = 30
	t.position = pos_throw.global_position
	init_pick(t)
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
	init_pick(t)
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
	ammo = clamp(ammo + (_ammo * ammo_up_amount), 0, ammo_max)
	emit_signal("ammo_change",player,ammo)

func init_pick(weap_pick):
	weap_pick.init(ammo, player, time, is_right, shoot_pos, false)

func no_gun():
	Controllers.get_pawn(player).no_gun()

func _on_Shoot_Timer_timeout():
	if is_bomb:
		go_boom()
	else:
		can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player") && can_melee:
		if body.player != player:
			body.hit(player, gun_num, dmg_type, melee_damage)
			melee_hit_sound()
		else:
			print_debug("quit hitting your self")
	elif body.get_groups().has("hittable") && can_melee:
		body.hit(player, gun_num, dmg_type,damage)
		melee_hit_sound()
	elif !can_melee:
		print_debug("this gun is set to not melee so no damage was given")

func melee_hit_sound():
	SFX.melee_hit()