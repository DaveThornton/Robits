extends Node2D

onready var anim_fire = $AnimationPlayer
onready var pos_shoot = $POS_Gun/POS/Shoot
onready var shoot_cast = $POS_Gun/Raycast/Shoot

var player = 1
var gun_num = 0
var ammo = 0
var ammo_max = 0
var take_ammo = true
# var my_name = "Gun"
var new_anim = "Un_pos"
var old_anim = "Un_pos"
var dmg_type = " "
var damage = 0
var can_shoot = true 
var shoot_pos = 3
var change_shoot_pos = true
var is_right = true
var walk = 0.0
var walk_amount = 0.0
var time = 4.0

signal ammo_change(player, ammo)

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 00 mega cannon")
	if Game.get_mode() == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _timer, _just_shot):
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1,false)
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
	pass

func shoot():
	pass

func shoot_r():
	pass

func _fire_projectile():
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	var _sss = pos_shoot.global_scale
	FX.proj(gun_num, _sr, _ss, _sss, player, damage)

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

func _on_Shoot_Timer_timeout():
	can_shoot = true

func _on_Melee_Timer_timeout():
	can_shoot = true