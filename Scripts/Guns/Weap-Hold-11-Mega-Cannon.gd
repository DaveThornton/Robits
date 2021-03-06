extends Node2D

export(PackedScene) var mega_cannon
export(PackedScene) var projectile

onready var anim_pos = $Anim_Player_Pos
onready var anim_fire = $Anim_Player_Shoot
onready var shoot_timer = $Shoot_Timer
onready var melee_timer = $Melee_Timer
onready var pos_shoot = $Pos2D_Walk/Pos2D_Shoot
onready var pos_walk = $Pos2D_Walk
onready var pos_throw = $Pos2D_Throw
onready var shoot_cast = $Pos2D_Walk/RayCast2D
onready var melee_cast = $Pos2D_Walk/RayCast2D_Melee
#onready var sfx = $SFX_Lib

var player = 1
var gun_num = 11
var ammo = 90
var ammo_max = 150
# warning-ignore:unused_class_variable
var take_ammo = true
var my_name = "Mega Cannon"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Laser"
var damage = 19
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 10
var time = 4.0

signal ammo_change(player, ammo)
#signal shot(player)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 11 mega cannon")
#	var test2 = self.connect("shot", get_tree().get_current_scene(), "shot")
#	if test2 != 0:
#		print("failed to connect shot in weap hold 11 mega cannon")
#	print(test1, test2)

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	anim_fire.play("Idle")
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	_set_anim()
	if pos_walk.rotation_degrees < 0:
		if pos_walk.rotation_degrees < 24:
			if pos_walk.rotation_degrees < 48:
				pos_walk.rotation_degrees += (walk * 3) * delta#.6
			pos_walk.rotation_degrees += (walk * 1.5) * delta#.1
		pos_walk.rotation_degrees += (walk * .75) * delta#.01
		
	if new_anim != old_anim:
		anim_pos.play(new_anim)
		old_anim = new_anim

func shoot_j():
	if can_shoot:
		if melee_cast.is_colliding() && shoot_pos == 3:
			melee()
		if ammo > 0:
			can_shoot = false 
			shoot_timer.start()
			if !shoot_cast.is_colliding():
				_fire_projectile()
			else:
				var _thing = shoot_cast.get_collider()
				if _thing.get_groups().has("hittable"):
					if _thing.player == player:
						_fire_projectile()
					else:
						_thing.hit(player, my_name, dmg_type, damage)
					print("gun 11 shot happened but no projectile spawned hit anyways")
				elif _thing.get_groups().has("map"):
					print("gun 11 hitting wall not fireing projectile", _thing)
				else:
					print("gun 11 dont know what im hitting but no projectile spawned")
			anim_fire.play("Shoot")
			ammo = clamp(ammo - 1, 0, ammo_max)
			pos_walk.rotation_degrees -= walk
			emit_signal("ammo_change",player,ammo)
			Player_Stats.add_shot(player, 1)
#			emit_signal("shot", player)
			SFX.play("Mega_Shoot")
		else:
			SFX.play("Gun_Click")

func shoot():
	pass

func shoot_r():
	pass

func _fire_projectile():
	var new_projectile = projectile.instance()
	Map_Hand.add_kid_to_map(new_projectile)
#	get_tree().get_current_scene().add_child(new_projectile)
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	var _sss = pos_shoot.scale
	new_projectile.start( _sr , _ss, _sss, player, damage)

func melee():
	if can_shoot:
		print("melee attack")
		can_shoot = false
		anim_fire.play("Melee")
		melee_timer.start()
#		emit_signal("shot", player)
		Player_Stats.add_shot(player, 1)
		print("melee called on gun 11")

func throw():
	var t = mega_cannon.instance()
	Map_Hand.add_kid_to_map(t)
#	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_throw_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free") #queue_free()

func drop():
	call_deferred("_drop")
func _drop():
	var t = mega_cannon.instance()
	Map_Hand.add_kid_to_map(t)
#	self.get_tree().get_current_scene().add_kid_to_map(t)
	t.position = pos_throw.global_position
	t.init(ammo, player, 1, is_right, shoot_pos, false)
	_drop_where(t)
	emit_signal("ammo_change",player,0)
	call_deferred("free")#queue_free()

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
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -400))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(600, -200))
		if shoot_pos == 4:
			_obj.apply_impulse(pos_throw.position, Vector2(600, 200))
		if shoot_pos == 5:
			_obj.apply_impulse(pos_throw.position, Vector2(100, 700))
	else:
		if shoot_pos == 1:
			_obj.apply_impulse(pos_throw.position, Vector2(-100, -700))
		if shoot_pos == 2:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -400))
		if shoot_pos == 3 ||shoot_pos == 6:
			_obj.apply_impulse(pos_throw.position, Vector2(-600, -200))
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


func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Area2D_Melee_body_entered(body):
	if body.get_groups().has("player"):
		if body.player != player:
			body.hit(player, my_name, dmg_type, damage)

func _on_Melee_Timer_timeout():
	can_shoot = true
