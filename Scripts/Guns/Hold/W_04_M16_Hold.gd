extends Node2D

export(PackedScene) var M16_Pickup
export(PackedScene) var projectile
export(PackedScene) var shell

onready var anim_fire = $AnimationPlayer
onready var melee_timer = $Melee_Timer
onready var shoot_timer = $Shoot_Timer
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var melee_cast = $POS_Gun/Raycast/Melee
onready var throw_cast = $POS_Gun/Raycast/Throw
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var pos_shell = $POS_Gun/POS/Shell
onready var pos_throw = $POS_Gun/POS/Throw

var player = 1
var pawn = 0
var gun_num = 2
var ammo = 30
var ammo_max = 90
var take_ammo = true
var how_many_burst = 3
var burst = 0
var color_change = 0
var my_name = "M-16"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Bullet"
var damage = 21
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 8.0
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

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
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
		elif ammo > 0 && burst <= (how_many_burst - 1):
			if !shoot_cast.is_colliding():
				var new_projectile = projectile.instance()
				Map_Hand.add_kid_to_map(new_projectile)
				var _ss = pos_shoot.global_position
				var _sr = pos_shoot.global_rotation
				#---------------------------------------------------------------
				print(is_right)
				if is_right:
					_sr = pos_shoot.global_rotation
				else:
					_sr = pos_shoot.global_rotation * -1
				#---------------------------------------------------------------
				var _sss = pos_shoot.global_scale
				new_projectile.start( _sr , _ss, _sss, player, damage)
				if color_change == 1:
					new_projectile.sprite.frame = 0
				elif color_change == 2:
					new_projectile.sprite.frame = 3
				color_change += 1
				if color_change == 3:
					color_change = 0
			else:
				var _thing = shoot_cast.get_collider()
				if _thing.get_groups().has("hittable"):
					_thing.hit(player, my_name, dmg_type, damage)
					print("gun 02 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print("gun 02 hitting wall not fireing projectile", _thing)
				else:
					print("gun 02 dont know what im hitting but no projectile spawned")
			var s = shell.instance()
			Map_Hand.add_kid_to_map(s)
			s.position = pos_shell.global_position
			s.rotation = pos_shell.global_rotation
			burst += 1
			walk += walk_amount
			can_shoot = false
			shoot_timer.start()
			anim_fire.play("Fire")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("AK_Shoot")
		else:
			can_shoot = false
			shoot_timer.start()
			SFX.play("Gun_Click")

func shoot_r():
	burst = 0
	can_shoot = true

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
	var t = M16_Pickup.instance()
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
	var t = M16_Pickup.instance()
	Map_Hand.add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

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
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true
