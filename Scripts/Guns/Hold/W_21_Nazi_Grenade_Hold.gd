extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

# onready var sprite_pin = $POS_Gun/Pin

var ex_num = 10

func post_set_up():
	explode_num = ex_num
	if ammo <= 0:
		# sprite_pin.visible = false
		anim_fire.play("Armed")

func shoot_r():
	if can_shoot:
		if ammo > 0:
			FX.shell(gun_num, pos_throw.global_position, pos_throw.global_rotation)
			can_shoot = false
			ammo = 0
			# sprite_pin.visible = false
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)
			anim_fire.play("Armed")
