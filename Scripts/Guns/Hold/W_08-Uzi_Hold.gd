extends Node2D

export(PackedScene) var uzi_pickup
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
var gun_num = 8
var ammo = 120
var ammo_max = 240
var take_ammo = true
var my_name = "UZI"
var dmg_type = "Bullet"
var damage = 15
var can_shoot = true
var just_shot = false
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 4.0
var time = 4.0
var walk_count = 0
signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 08 Uzi")

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	if walk_count == 0:
		if walk > 0.0:
			walk -= delta * 10
	#		if walk < 0.0:
	#			walk = 0.0
		elif walk < 0.0:
			walk += delta * 10
func shoot_j():
	pass

func shoot():
	if can_shoot:
#		print("shoot Uzi")
		if ammo > 0:
#			print("uzi has ammo")
			if !shoot_cast.is_colliding():
#				print("Shoot Shoot Uzi")
				var new_projectile = projectile.instance()
				Map_Hand.add_kid_to_map(new_projectile)
				var _ss = pos_shoot.global_position
				var _sr = pos_shoot.global_rotation
				if is_right:
					_sr = pos_shoot.global_rotation
				else:
					_sr = pos_shoot.global_rotation * -1
				#---------------------------------------------------------------
				var _sss = pos_shoot.global_scale
				new_projectile.start( _sr , _ss, _sss, player, damage)
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
			walk = walk_where()
#			walk *= -1
			can_shoot = false
			shoot_timer.start()
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
			SFX.play("W_08_Shoot")
		elif melee_cast.is_colliding() && shoot_pos == 3:
#			print("uzi trying to melee")
			melee()
		else:
#			print("no ammo Uzi")
			anim_fire.play("Click")
			can_shoot = false
			shoot_timer.start()
			SFX.play("W_08_Empty")
#		print("Uzi end of shoot")

func walk_where():
	walk_count += 1
	if walk_count  == 0:
		return walk_amount * 3
	elif walk_count  == 1:
		return -walk_amount * 2
	elif walk_count  == 2:
		return -walk_amount * 1.5
	elif walk_count  == 3:
		return walk_amount * 2
	elif walk_count  == 4:
		return -walk_amount * 3
	elif walk_count  == 5:
		return 0
	elif walk_count  == 6:
		return walk_amount
	elif walk_count  == 7:
		return -walk_amount * 2
	elif walk_count  == 8:
		walk_count = -1
		return walk_amount * 2.2


func shoot_r():
	walk_count = 0

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
	var t = uzi_pickup.instance()
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
	var t = uzi_pickup.instance()
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
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true
