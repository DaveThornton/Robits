extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var arm = $Body/POS_Arm/Pawn_14_Part_Arm
onready var my_gun_pos = $Body/POS_Arm/Pawn_14_Part_Arm/POS_Gun

onready var body_shape_01 = $CollisionShape2D_Stand
onready var body_shape_02 = $CollisionShape2D_Prone

onready var head = $Body/Pawn_14_Part_Head
onready var trax = $Body/Pawn_14_Part_Tracks
onready var exhaust = $Body/Pawn_14_Exhaust

onready var rockets = $Body/Pawn_14_Part_Tracks/Pawn_07_Part_Fire

onready var body_sprite = $Body
onready var shield_sprite = $Body/Shield

onready var my_anim = $AnimationPlayer
onready var ray_up = $Raycasts/Up
onready var ray_down_l = $Raycasts/Down_L
onready var ray_down_r = $Raycasts/Down_R
onready var ray_plat = $Raycasts/Plat_Test

onready var my_attachment_point = $Body/Attachment_Point

export var my_grav = 9
export var my_max_x_speed = 120
export var my_armor = 2.5
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 8
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 4
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 175
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 30
export var my_light_on_nrg = 20

func _ready():
	gun_pos = my_gun_pos
	grav = my_grav
	max_x_speed = my_max_x_speed
	max_air_jump_power = my_max_air_jump_power
	min_air_jump_power = my_min_air_jump_power
	max_air_jump_count = my_max_air_jump_count
	max_jump_power = my_max_jump_power
	min_jump_power = my_min_jump_power
	nrg_max = my_nrg_max
	nrg = my_nrg_max
	last_nrg = my_nrg_max
	nrg_max = my_nrg_max
	nrg_regen_rate = my_nrg_regen_rate
	nrg_default_regen_max = my_nrg_regen_max
	nrg_default_regen_rate = my_nrg_regen_rate
	light_on_nrg = my_light_on_nrg
	anim = my_anim
	attachment_point = my_attachment_point
	armor = my_armor

func _physics_process(_delta):
	rocket_test(vel.y)

func jump(_down_input, _left_input, _right_input):
	pass

func jump_j(_down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat.is_colliding():
				self.set_collision_mask_bit(2,false)
				jump_down_sound()
				vel.y = terminal_vel / 2
				self.position.y += 8
				jump_down_stat()
		else:
			if !is_jump_pressed && on_floor:
				jump_ground_sound()
				vel.y = -max_jump_power * jump_power_up
				jump_stat()
			elif !is_jump_pressed && !on_floor && max_air_jump_count > air_jump_count:# && nrg >= 20:
				jump_air_sound()
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
				jump_air_stat()
			is_jump_pressed = true


func jump_rel():
	self.set_collision_mask_bit(2,true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

func rocket_test(_vel_y):
	if _vel_y < 0.0 && !rockets.on:
		rockets.flame_up()
	elif _vel_y > 0.0 && rockets.on:
		rockets.flame_down()
	
func shield_up():
	head.shield_up()
	trax.shield_up()
	shield_sprite.visible = true

func shield_down():
	head.shield_down()
	trax.shield_down()
	shield_sprite.visible = false

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num == 1:
		body_shape_01.disabled = false
		body_shape_02.disabled = true
	elif _num == 2:
		body_shape_01.disabled = true
		body_shape_02.disabled = false
	else:
		print_debug("Pawn_14 error body number wrong in _body")

##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if ray_up.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		if !on_floor && !is_jump_pressed:
			SFX.jump_land()
			on_floor = true
	else :
		on_floor = false

func _anim_idle():
	_body(1)
	head.up(false)
	head.stun(false)
	trax.stop()
	exhaust.idle()
	new_anim = "Idle"

func _anim_run():
	_body(1)
	head.up(false)
	head.stun(false)
	new_anim = "Go"
	exhaust.go()
	if is_right:
		trax.turn(true)
		_body(1)
	else:
		trax.turn(false)
		_body(1)

func _anim_jump():
	_body(1)
	head.up(false)
	head.stun(false)
	new_anim = "Idle"
	exhaust.idle()
	if is_right:
		trax.turn(true)
		_body(1)
	else:
		trax.turn(false)
		_body(1)

func _anim_prone_idle():
	head.up(false)
	head.stun(false)
	new_anim = "Prone"
	exhaust.idle()
	_body(2)
	trax.stop()

func _anim_prone_crawl():
	new_anim = "Prone"
	head.up(false)
	head.stun(false)
	exhaust.go()
	_body(2)
	if is_right:
		trax.turn(true)
	else:
		trax.turn(false)

func _anim_stun():
	_body(1)
	head.up(false)
	head.stun(true)
	exhaust.stop()
	new_anim = "Stun"

func _anim_Knock():
	_body(1)
	exhaust.idle()
	head.up(false)
	new_anim = "Idle"

func _set_gun_dir():
	arm.is_right(is_right)
	head.is_right(is_right)
	exhaust.is_right(is_right)
	if is_right:
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk

func _set_new_color(_pri, _sec):
	arm.color(_pri, _sec)
	trax.color(_pri, _sec)
	head.color(_pri, _sec)
	exhaust.color(_pri, _sec)
	shield_sprite.self_modulate = _sec
	body_sprite.self_modulate = _pri