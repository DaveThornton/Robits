extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var sprite_pin = $POS_Gun/Pin

var detonator = null

func shoot_r():
	if can_shoot:
		if ammo > 0:
			FX.shell(gun_num, pos_throw.global_position, pos_throw.global_rotation)
			can_shoot = false
			ammo = 0
			sprite_pin.visible = false
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)
			detonator = FX.get_plasma_det().instance()
			self.add_child(detonator)
			detonator.init(player, time, true, damage, gun_num)
			var test1 = detonator.connect("blowed_up",self ,"blowing_up")
			if test1:
				print_debug("error in w22 plasma hold couldnt connect to detonator")

func init_pick(weap_pick):
	weap_pick.init(ammo, player, time, is_right, shoot_pos, false)
	if detonator != null:
		remove_child(detonator)
		weap_pick.add_det(detonator)

func blowing_up():
	print_debug("calling blowing up in w22 hold connection worked")
	no_gun()
