extends Node2D

export(PackedScene) var mega_cannon
export(PackedScene) var projectile

onready var anim_fire = $AnimationPlayer
#onready var shoot_timer = $Shoot_Timer
onready var pos_shoot = $POS_Gun/POS/Shoot
#onready var pos_throw = $POS_Gun/POS/Throw
onready var shoot_cast = $POS_Gun/Raycast/Shoot
onready var throw_cast = $POS_Gun/Raycast/Throw

var player = 1
var gun_num = 0
var ammo = 0
var ammo_max = 0
var take_ammo = false
var my_name = "Mega Cannon"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = "Laser"
var damage = 15
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 7.0
var time = 4.0

signal ammo_change(player, ammo)

func _ready():
	my_name = my_name
	gun_num = gun_num
	time = time
	damage = damage
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print("failed to connect ammo change in weap hold 00 mega cannon")

func init(_ammo, _player, _timer, _just_shot):
	ammo = _ammo
	player = _player
	anim_fire.play("Idle")
	emit_signal("ammo_change",player,ammo)

func _process(delta):
	if walk > 0.0:
		if walk > 30:
			walk -= delta * 50
		else:
			walk -= delta * 40
		if walk < 0.0:
			walk = 0.0

func shoot_j():
	if can_shoot:
		can_shoot = false 
		shoot_cast.force_raycast_update()
		if !shoot_cast.is_colliding():
			_fire_projectile()
		else:
			var _thing = shoot_cast.get_collider()
			if _thing.get_groups().has("hittable"):
				if _thing.player == player:
					_fire_projectile()
				else:
					_thing.hit(player, my_name, dmg_type, damage)
				print("gun 00 shot happened but no projectile spawned hit anyways")
			elif _thing.get_groups().has("map"):
				print("gun 00 hitting wall not fireing projectile", _thing)
			else:
				print("gun 00 dont know what im hitting but no projectile spawned")
		anim_fire.play("Shoot")
		Player_Stats.add_shot(player, 1)
		SFX.play("Mega_Shoot")
		walk += walk_amount
	else:
		SFX.play("Gun_Click")

func shoot():
	pass

func shoot_r():
	can_shoot = true

func _fire_projectile():
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

func throw():
	pass

func drop():
	pass
	
func _drop():
	pass

func set_shoot_pos(_num, _is_right):
	if change_shoot_pos:
		shoot_pos = _num
		is_right = _is_right

func add_ammo(_ammo):
	pass

func _throw_where(_obj):
	pass

func _drop_where(_obj):
	_obj.set_collision_layer_bit( 1, false)
	_obj.set_collision_mask_bit( 1, false)
