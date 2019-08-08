extends Node2D

export(PackedScene) var RPG_Pickup
#export(PackedScene) var shell
export(PackedScene) var projectile

onready var sprite_gun = $Pos2D_Walk/Sprite_Gun
onready var anim_pos = $Anim_Pos
onready var anim_fire = $Anim_Shoot
onready var shoot_timer = $Shoot_Timer
onready var melee_timer = $Melee_Timer
onready var shoot_cast = $Pos2D_Walk/RayCast2D
onready var melee_cast = $Pos2D_Walk/Melee_Cast
onready var pos_walk = $Pos2D_Walk
onready var pos_throw = $Pos2D_Throw
onready var pos_shoot = $Pos2D_Walk/Pos2D_Shoot


var player = 1
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
var walk = 45
var time = 4.0

signal ammo_change(player, ammo)
#signal shot(player)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", get_tree().get_current_scene(), "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 40 RPG")
#	var test2 = self.connect("shot", get_tree().get_current_scene(), "shot")
#	if test2 != 0:
#		print("failed to connect shot in weap hold 40 RPG")

func init(_ammo, _player, _timer):
	ammo = _ammo
	player = _player
	emit_signal("ammo_change",player,ammo)
	if ammo <= 0:
		sprite_gun.frame = 3
	else:
		sprite_gun.frame = 2
	

func _process(delta):
	_set_anim()
	if pos_walk.rotation_degrees < 0:
		if pos_walk.rotation_degrees < 24:
#			if pos_walk.rotation_degrees < 48:
#				pos_walk.rotation_degrees += (walk * 3) * delta#.6
			pos_walk.rotation_degrees += (walk * 1.5) * delta#.1
		pos_walk.rotation_degrees += (walk * .75) * delta#.01
	if new_anim != old_anim:
		anim_pos.play(new_anim)
		old_anim = new_anim

func shoot_j():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		elif ammo > 0:
			if !shoot_cast.is_colliding():
				var new_projectile = projectile.instance()
				get_tree().get_current_scene().add_child(new_projectile)
				var _ss = pos_shoot.global_position
				var _sr = pos_shoot.global_rotation
				if is_right:
					_sr = pos_shoot.global_rotation
				else:
					_sr = pos_shoot.global_rotation * -1
				var _sss = pos_shoot.scale
				new_projectile.start( _sr , _ss, _sss, player, damage)
			else:
				var _thing = shoot_cast.get_collider()
#				if _thing.get_groups().has("player")
				if _thing.get_groups().has("hittable"):
					_thing.hit(player, my_name, dmg_type, damage)
					print("gun 40 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print("gun 40 hitting wall not fireing projectile", _thing)
				else:
					print("gun 40 dont know what im hitting but no projectile spawned")
#
#			can_shoot = false 
#			var new_projectile = projectile.instance()
#			get_tree().get_current_scene().add_child(new_projectile)
#			var _ss = pos_shoot.global_position
#			var _sr = pos_shoot.global_rotation
#			if is_right:
#				_sr = pos_shoot.global_rotation
#			else:
#				_sr = pos_shoot.global_rotation * -1
#			var _sss = pos_shoot.scale
#			new_projectile.start( _sr , _ss, _sss, player)
			
			ammo = clamp(ammo - 1, 0, ammo_max)
			pos_walk.rotation_degrees -= walk
			sprite_gun.frame = 3
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
#			emit_signal("shot", player)
			shoot_timer.start()

func shoot():
	pass

func shoot_r():
	pass

func melee():
	if can_shoot:
		print("melee attack")
		can_shoot = false
		anim_fire.play("Melee")
		melee_timer.start()
		Player_Stats.add_shot(player, 1)
#		emit_signal("shot", player)
		print("melee called on gun 02")

func _on_Melee_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
#		body.stun(gun_num)
			body.hit(player, my_name, dmg_type, damage)
		else:
			print("quit hitting your self")

func throw():
	var t = RPG_Pickup.instance()
	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = RPG_Pickup.instance()
	self.get_tree().get_current_scene().add_kid_to_map(t)
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

func _set_anim():
	if is_right:
		if shoot_pos == 1:
			new_anim = "Up-Right"
		if shoot_pos == 2:
			new_anim = "Right-Up"
		if shoot_pos == 3 ||shoot_pos == 6:
			new_anim = "Right"
		if shoot_pos == 4:
			new_anim = "Right-Down"
		if shoot_pos == 5:
			new_anim = "Down-Right"
	else:
		if shoot_pos == 1:
			new_anim = "Up-Left"
		if shoot_pos == 2:
			new_anim = "Left-Up"
		if shoot_pos == 3 ||shoot_pos == 6:
			new_anim = "Left"
		if shoot_pos == 4:
			new_anim = "Left-Down"
		if shoot_pos == 5:
			new_anim = "Down-Left"

func _tip_update():
	if ammo > 0:
		sprite_gun.frame = 2

func _on_Shoot_Timer_timeout():
	can_shoot = true
	_tip_update()

func _on_Melee_Timer_timeout():
	can_shoot = true
	_tip_update()
