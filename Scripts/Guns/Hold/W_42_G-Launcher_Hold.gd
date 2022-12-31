extends Node2D

export var power = 25
onready var sprite_gun = $POS_Gun/Gun_Sprite
onready var anim_fire = $AnimationPlayer
onready var shoot_timer = $Shoot_Timer
onready var melee_timer = $Melee_Timer
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var pos_throw = $POS_Gun/POS/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var melee_area = $POS_Gun/Melee_Area

var player = 1
var pawn
var gun_num = 42
var ammo = 50
var ammo_max = 50
var take_ammo = true
var my_name = "Grenade Launcher"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Boom"
var damage = 125
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0
var time = 4.0
var shoot_pressed = false

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 40 RPG")
	if Game.get_mode() == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_b())
		melee_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_b())

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	throw_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	melee_area.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, false)
	pawn = Controllers.get_pawn(player)
	emit_signal("ammo_change",player,ammo)

func _physics_process(delta):
	if shoot_pressed:
		walk += delta * 50
		walk = clamp(walk,0, 90)
	else:
		if walk > 0.0:
			walk -= delta * 45
			if walk < 0.0:
				walk = 0.0

func shoot_j():
	shoot_pressed = true

func shoot_r():
	shoot_pressed = false
	if can_shoot:
		if melee_cast.is_colliding():
			if melee_cast.get_collider().get_groups().has("player"):
				if melee_cast.get_collider().player == player && ammo > 0:
					fire_projectile()
				elif melee_cast.get_collider().player != player:
					melee()	
				else:
					SFX.play("W_42_Empty")
					print_debug("need to add a click sound w 42 no ammo maybe this is in melee in w42 check it out if it seems weird or delete this")
			else:
				melee()
		elif ammo > 0:
			fire_projectile()
		else:
			SFX.play("W_42_Empty")

func fire_projectile():
	if !shoot_cast.is_colliding():
		SFX.play("W_42_Thump")
		anim_fire.play("Shoot")
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		if is_right:
			_sr = pos_shoot.global_rotation
		else:
			_sr = pos_shoot.global_rotation * -1
		var _sss = pos_shoot.global_scale
		FX.proj(gun_num, _sr , _ss, _sss, player, damage)
	else:
		FX.explode(40, player, shoot_cast.get_collision_point(), my_name, 0, damage)

	can_shoot = false
	ammo = clamp(ammo - 1, 0, ammo_max)
#			sprite_gun.frame = 1
	emit_signal("ammo_change",player,ammo)
	Player_Stats.add_shot(player, 1)
	shoot_timer.start()

func shoot():
	pass

func melee():
	if can_shoot:
		can_shoot = false
		anim_fire.play("Melee")
		melee_timer.start()
		Player_Stats.add_shot(player, 1)

func _on_Melee_Area_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type, damage)
		else:
			print_debug("quit hitting your self")

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

func add_ammo(_ammo):
	ammo = clamp(ammo + int(round(_ammo / 10)), 0, ammo_max)
	emit_signal("ammo_change",player,ammo)

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func _throw_where(_obj):
	if is_right:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(100, -800))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -600))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(800, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -800))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -600))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-800, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, 700))

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)


func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true