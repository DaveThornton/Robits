# extends Node2D
extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

var my_gun_num = 1
var my_take_ammo = false
var my_damage = 15
var my_walk_amount = 7.0

func _ready():
	var test1 = self.connect("ammo_change", Player_Stats, "ammo_update")
	if test1 != 0:
		print_debug("failed to connect ammo change in weap hold 00 mega cannon")
	if Game.get_mode() == 0:
		shoot_cast.set_collision_mask(FX.projectiles.get_layer_mode_0_a())

func init(_ammo, _player, _timer, _just_shot):
	gun_num = my_gun_num
	player = _player
	ammo = _ammo
	take_ammo = my_take_ammo
	damage = my_damage
	walk_amount = my_walk_amount
	shoot_cast.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1,false)
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
				if _thing.get_groups().has("player") && _thing.player == player:
					_fire_projectile()
				else:
					_thing.hit(player, gun_num, dmg_type, damage)
				print_debug("gun 00 shot happened but no projectile spawned hit anyways")
			elif _thing.get_groups().has("map"):
				print_debug("gun 00 hitting wall not fireing projectile", _thing)
			else:
				print_debug("gun 00 dont know what im hitting but no projectile spawned")
		anim_fire.play("Shoot")
		Player_Stats.add_shot(player, 1)
		SFX.play("W_11_Shoot")
		walk += walk_amount
	else:
		SFX.play("W_11_Empty")

func shoot_r():
	can_shoot = true