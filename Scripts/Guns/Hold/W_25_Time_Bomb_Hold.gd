extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var label = $"POS_Gun/Gun_Sprite/FX-21-Timer_Label"

var ex_num = 25
var was_right = true

func post_set_up():
	explode_num = ex_num
	if ammo <= 0:
		anim_fire.play("Armed")

func shoot_r():
	if can_shoot:
		if ammo > 0:
			can_shoot = false
			ammo = 0
			emit_signal("ammo_change",player, ammo)
			Player_Stats.add_shot(player, 1)
			anim_fire.play("Armed")

func called_on_process(_delta):
	label.set_time(time)
	if is_right != was_right:
		was_right = is_right
		label.up(is_right)