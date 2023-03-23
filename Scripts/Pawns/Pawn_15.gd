extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var head = $Pawn_15_Part_Head
onready var arm = $Pawn_15_Part_Head/Pawn_15_Body/POS_Arm/Pawn_15_Part_Arm
onready var legf = $Pawn_15_Leg_F
onready var legb = $Pawn_15_Leg_B
onready var hub = $Pawn_15_Part_Hub


onready var shieldlf = $Pawn_15_Leg_F_Shield
onready var shieldlb = $Pawn_15_Leg_B_Shield
#onready var shield_leg_f = $Shield_Leg_F
#onready var shield_leg_b = $Shield_Leg_B

onready var my_gun_pos = $Pawn_15_Part_Head/Pawn_15_Body/POS_Arm/Pawn_15_Part_Arm/POS_Gun
onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycasts/Up
onready var ray_up2 = $Raycasts/Up2
onready var ray_down_l = $Raycasts/Left
onready var ray_down_r = $Raycasts/Right
onready var ray_plat = $Raycasts/Plat_Test

onready var body_shape_01 = $CollisionShape2D_Stand
onready var body_shape_02 = $CollisionShape2D_Prone

onready var my_attachment_point = $Pawn_15_Part_Head/Attachment_Point

export var my_grav = 8
export var my_max_x_speed = 170
export var my_armor = 2
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 11
export var my_min_air_jump_power = 5
export var my_max_jump_power = 13
export var my_min_jump_power = 2

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 125
export var my_nrg_regen_rate = 8
export var my_nrg_regen_max = 50
export var my_light_on_nrg = 49

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

##-------------------------------------------------------------[Jump]

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
			if !is_jump_pressed && on_floor:# && !is_down:# && !down_input:
				jump_ground_sound()
				vel.y = -max_jump_power * jump_power_up
				jump_stat()
			is_jump_pressed = true

func fix_vel(_vel):
	if head_room > 0 && _vel.y < 0:
		_vel.y *= -1
	return _vel

func jump_rel():
	self.set_collision_mask_bit(2,true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

	
##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if ray_up.is_colliding() || ray_up2.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		if !on_floor && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
			on_floor = true
		on_floor = true

	else :
		on_floor = false

func _anim_idle():
	_body(1)
	hub.stop()
	if is_right:
		new_anim = "Idle_Right"
	else:
		new_anim = "Idle_Left"

func _anim_run():
	if is_right:
		hub.turn(true)
		new_anim = "Run_Right"
		_body(1)
	else:
		hub.turn(false)
		new_anim = "Run_Left"
		_body(1)

func _anim_jump():
#	print_debug("pawn 15 make jump animation")
	_body(1)
	if vel.y < 0:
		if is_right:
			hub.turn(true)
			new_anim = "Jump_Right"
		else:
			hub.turn(false)
			new_anim = "Jump_Left"
	else:
		if is_right:
			hub.turn(true)
			new_anim = "Fall_Right"
		else:
			hub.turn(false)
			new_anim = "Fall_Left"

func _anim_prone_idle():
	_body(2)
	hub.stop()
	if is_right:
		new_anim = "Prone_Idle_Right"
	else:
		new_anim = "Prone_Idle_Left"

func _anim_prone_crawl():
	_body(2)
	if is_right:
		hub.turn(true)
		new_anim = "Prone_Crawl_Right"
	else:
		hub.turn(false)
		new_anim = "Prone_Crawl_Left"

func _anim_stun():
	_body(1)
	hub.stop()
	if is_right:
		new_anim = "Stun_Right"
	else:
		new_anim = "Stun_Left"

func _anim_Knock():
	_body(1)
	hub.stop()
	print_debug("pawn 15 make knock back anim")
	if is_right:
		new_anim = "Right-Knock_Back"
	else:
		new_anim = "Left-Knock_Back"

func _set_gun_dir():
	arm.is_right(is_right)
	head.is_right(is_right)
	if is_right:
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			arm.bend(1)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			arm.bend(1)
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			arm.bend(1)
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
			arm.bend(3)
		elif shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			arm.bend(1)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			arm.bend(1)
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			arm.bend(1)
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
			arm.bend(3)
		elif shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num == 1:
		body_shape_01.disabled = false
		body_shape_02.disabled = true
	elif _num == 2:
		body_shape_01.disabled = true
		body_shape_02.disabled = false

func shield_up():
	head.shield_up()
	shieldlf.visible = true
	shieldlb.visible = true

func shield_down():
	head.shield_down()
	shieldlf.visible = false
	shieldlb.visible = false

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	arm.color(_pri, _sec)
	hub.color(_pri, _sec)
	legf.self_modulate = _pri
	legb.self_modulate = _pri
	shieldlf.self_modulate = _sec
	shieldlb.self_modulate = _sec