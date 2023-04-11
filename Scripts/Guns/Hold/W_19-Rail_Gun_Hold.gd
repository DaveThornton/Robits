extends 'res://Scripts/Guns/Hold/W_00_Gun_Hold.gd'

onready var beam = $POS_Gun/Gun_Sprite/Beam
onready var beam_end =$POS_Gun/Gun_Sprite/Beam_End
onready var partic = $POS_Gun/Gun_Sprite/CPUParticles2D

onready var ammo_01 = $POS_Gun/Gun_Sprite/Ammo_01
onready var ammo_02 = $POS_Gun/Gun_Sprite/Ammo_02
onready var ammo_03 = $POS_Gun/Gun_Sprite/Ammo_03
onready var ammo_04 = $POS_Gun/Gun_Sprite/Ammo_04
onready var ammo_05 = $POS_Gun/Gun_Sprite/Ammo_05

export var ex_num = 19

var max_beam = 2000
var shoot_pressed = false
var shoot_pressed_time = 0

func post_set_up():
	ammo_update()

func _physics_process(delta):
	if shoot_cast.is_colliding():
		beam_end.global_position = shoot_cast.get_collision_point()
	else: 
		beam_end.global_position = shoot_cast.cast_to
	beam.region_rect.end.x = beam_end.position.length()
	if shoot_pressed && can_shoot:
		shoot_pressed_time += delta

func shoot_j():
	if ammo > 0:
		shoot_pressed = true
		anim_fire.play("ChargeUp")
		SFX.play("W_19_Charge_Up")

func shoot():
	if shoot_pressed_time > 1 && shoot_pressed:
		if can_shoot:
			if melee_cast.is_colliding() && shoot_pos == 3:
				melee()
			elif ammo > 0:
				if !shoot_cast.is_colliding():
					print_debug("shoot cast not colliding why gun 19")
				else: 
					FX.explode(ex_num, player, shoot_cast.get_collision_point(), gun_num, 0, damage)
				anim_fire.play("Shoot")
				ammo = clamp(ammo - 1, 0, ammo_max)
				emit_signal("ammo_change",player,ammo)
				ammo_update()
				Player_Stats.add_shot(player, 1)
				just_shot = true
				SFX.projectile(gun_num)
				shoot_timer.start()
				can_shoot = false
			else:
				SFX.empty(gun_num)
			shoot_pressed = false

func shoot_r():
	anim_fire.play("Chargedown")
	SFX.stop("W_19_Charge_Up")
	shoot_pressed = false
	shoot_pressed_time = 0 

func ammo_update():
	ammo_01.visible = false
	ammo_02.visible = false
	ammo_03.visible = false
	ammo_04.visible = false
	ammo_05.visible = false
	if ammo >= 5:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
		ammo_04.visible = true
		ammo_05.visible = true
	elif ammo >= 4:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
		ammo_04.visible = true
	elif ammo >= 3:
		ammo_01.visible = true
		ammo_02.visible = true
		ammo_03.visible = true
	elif ammo >= 2:
		ammo_01.visible = true
		ammo_02.visible = true
	elif ammo >= 1:
		ammo_01.visible = true