extends Node2D

export(PackedScene) var RPG_Pickup
export(PackedScene) var projectile

onready var sprite_gun = $POS_Gun/Gun_Sprite
onready var anim_fire = $AnimationPlayer
onready var shoot_timer = $Shoot_Timer
onready var melee_timer = $Melee_Timer
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var pos_throw = $POS_Gun/POS/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot

var player = 1
var pawn = 0
var gun_num = 2
var ammo = 3
var ammo_max = 9
# warning-ignore:unused_class_variable
var take_ammo = true
var my_name = "RPG"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Boom"
var damage = 100
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0
var time = 4.0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 40 RPG")

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	emit_signal("ammo_change",player,ammo)
	if ammo <= 0:
		sprite_gun.frame = 1
	else:
		sprite_gun.frame = 0

func shoot_j():
	if can_shoot:
		if melee_cast.is_colliding():
			melee()
		elif ammo > 0:
			if !shoot_cast.is_colliding():
				var new_projectile = projectile.instance()
				Map_Hand.add_kid_to_map(new_projectile)
				var _ss = pos_shoot.global_position
				var _sr = pos_shoot.global_rotation
				if is_right:
					_sr = pos_shoot.global_rotation
				else:
					_sr = pos_shoot.global_rotation * -1
				var _sss = pos_shoot.global_scale
				new_projectile.start( _sr , _ss, _sss, player, damage)
			else:
				var _thing = shoot_cast.get_collider()
				if _thing.get_groups().has("hittable"):
					_thing.hit(player, my_name, dmg_type, damage)
					print("gun 40 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print("gun 40 hitting wall not fireing projectile", _thing)
				else:
					print("gun 40 dont know what im hitting but no projectile spawned")
			
			ammo = clamp(ammo - 1, 0, ammo_max)
			sprite_gun.frame = 1
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			shoot_timer.start()

func shoot():
	pass

func shoot_r():
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
			print("quit hitting your self")

func throw():
	var t = RPG_Pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.init(ammo, player, 1, is_right, shoot_pos, false)
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
	var t = RPG_Pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func add_ammo(_ammo):
	ammo = clamp(ammo + int(round(_ammo / 10)), 0, ammo_max)
	_tip_update()
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

func _tip_update():
	if ammo > 0:
		sprite_gun.frame = 0
	else:
		sprite_gun.frame = 1

func _on_Shoot_Timer_timeout():
	can_shoot = true
	_tip_update()

func _on_Melee_Timer_timeout():
	can_shoot = true
	_tip_update()
