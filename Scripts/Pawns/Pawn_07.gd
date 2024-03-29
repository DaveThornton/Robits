extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var arm = $Arm_POS/Pawn_07_Part_Arm
onready var my_gun_pos = $Arm_POS/Pawn_07_Part_Arm/POS_Gun

onready var body_shape_02 = $Shape_Stand
onready var body_shape_04 = $Shape_Crouch

onready var head = $Head_POS/Pawn_07_Part_Head
onready var key = $Pawn_05_Part_Key
onready var trax = $Pawn_07_Part_Trax
onready var rockets = $Pawn_07_Part_Fire

onready var body_sprite = $Body
onready var shield_sprite = $Shield

onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycast/Up
onready var ray_down_l = $Raycast/Down_L
onready var ray_down_r = $Raycast/Down_R
onready var ray_plat = $Raycast/Plat_Test

onready var my_attachment_point = $Attachment_Point

export var my_grav = 9
export var my_max_x_speed = 200
export var my_armor = 0
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 6.5
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 5
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 180
export var my_nrg_regen_rate = 10
export var my_nrg_regen_max = 60
export var my_light_on_nrg = 20


#-----------------------------------------------------------EXTRA_JUMP--------
export var jump_time: = 1.4
export var jump_height = 50
var jump_top_pos = 0.0
var jump_top = false
var going_up = false
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

	timers.set_jump(jump_time)

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat.is_colliding():
				self.set_collision_mask_bit(2,false)
				jump_down_sound()
				vel.y = terminal_vel / 2
				self.position.y += 8
				jump_down_stat()
		else:
			if !is_jump_pressed && on_floor && !down_input:# && !down_input:
				jump_ground_sound()
				jump_top_pos = self.position.y - 50
				vel.y = -max_jump_power * jump_power_up
				jump_stat()
			elif is_jump_pressed && air_jump_count == 0 && !down_input:
				if self.position.y <= jump_top_pos && !jump_top:
					jump_top = true
					timers.start_jump()
				if jump_top:
					vel.y = 0
			elif !is_jump_pressed && !on_floor && max_air_jump_count > air_jump_count && !down_input:# && nrg >= 20:
				jump_air_sound()
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
				jump_air_stat()
		is_jump_pressed = true

func fix_vel(_vel):
	if going_up:
		_vel.y = -2
	elif on_floor && !is_jump_pressed:
		_vel.y = 0
	elif _vel.y > terminal_vel:
		_vel.y = terminal_vel
	if is_jump_pressed:
		if jump_top:
			_vel.y = 0
	rocket_test(vel.y)
	return _vel

func jump_rel():
	self.set_collision_mask_bit(2,true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	jump_top = false
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
		body_shape_02.disabled = false
		body_shape_04.disabled = true
	elif _num == 2:
		body_shape_02.disabled = false
		body_shape_04.disabled = true
	elif _num == 3:
		body_shape_02.disabled = false
		body_shape_04.disabled = true
	elif _num == 4:
		body_shape_02.disabled = true
		body_shape_04.disabled = false
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
	_body(2)
	trax.stop()
	if is_right:
		new_anim = "Right-Idle"
	else:
		new_anim = "Left-Idle"

func _anim_run():
	if is_right:
		new_anim = "Right-Run"
		trax.turn(true)
		_body(3)
	else:
		new_anim = "Left-Run"
		trax.turn(false)
		_body(1)

func _anim_jump():
	if is_right:
		new_anim = "Right-Run"
		trax.turn(true)
		_body(3)
	else:
		new_anim = "Left-Run"
		trax.turn(false)
		_body(1)

func _anim_prone_idle():
	_body(2)
	trax.stop()
	if is_right:
		new_anim = "Right-Prone-Idle"
	else:
		new_anim = "Left-Prone-Idle"

func _anim_prone_crawl():
	_body(4)
	if is_right:
		new_anim = "Right-Prone-Crawl"
		trax.turn(true)
	else:
		new_anim = "Left-Prone-Crawl"
		trax.turn(false)

func _anim_stun():
	_body(2)
	if is_right:
		new_anim = "Right-Stun"
	else:
		new_anim = "Left-Stun"

func _anim_Knock():
	_body(2)
	if is_right:
		new_anim = "Right-Knock_Back"
	else:
		new_anim = "Left-Knock_Back"

func _set_gun_dir():
	head.pos(shoot_spot)
	arm.is_right(is_right)
	if is_right:
		head.is_right(true)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			arm.bend(1)
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			arm.bend(2)
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		head.is_right(false)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			arm.bend(1)
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			arm.bend(2)
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk

func _set_new_color(_pri, _sec):
	arm.color(_pri, _sec)
	key.color(_pri, _sec)
	trax.color(_pri, _sec)
	head.color(_pri, _sec)
	shield_sprite.modulate = _sec
	body_sprite.modulate = _pri

func jumptimer():
	jump_top = false
	jump_top_pos -= 50