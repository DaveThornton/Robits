extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var arm = $Body/POS_Arm/Pawn_17_Part_Arm
onready var my_gun_pos = $Body/POS_Arm/Pawn_17_Part_Arm/POS_Gun

onready var head = $Body/Pos_Head/Pawn_17_Head
onready var stinger = $Body/Pawn_17_Stinger

onready var body_sprite = $Body
onready var shield_sprite = $Body/Shield

onready var my_anim = $AnimationPlayer

onready var body_s = $CollisionShape2D_Up
onready var body_p = $CollisionShape2D_Down

onready var ray_up = $Raycasts/Up
onready var ray_down_l_stand = $Raycasts/Down_L
onready var ray_down_c_stand = $Raycasts/Down_C
onready var ray_down_r_stand = $Raycasts/Down_R
onready var ray_down_l_prone = $Raycasts/Down_L2
onready var ray_down_c_prone = $Raycasts/Down_C2
onready var ray_down_r_prone = $Raycasts/Down_R2
onready var ray_plat_check = $Raycasts/Plat_Test
onready var ray_plat = $Raycasts/Plat_Test

onready var my_attachment_point = $Body/Pos_Head/Attachment_Point

export var my_grav = 8
export var my_max_x_speed = 190
export var my_armor = 0
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 10
export var my_max_air_jump_power = 1.5
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 8
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 90
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 70
export var my_light_on_nrg = 50

var ray_down_l
var ray_down_c
var ray_down_r

var jumping_up = false
var jump_time = .7
var jump_top_pos = 0.0
var jump_top = false
var jump_height = 150
var going_up = false
var current_body = 0

func _ready():
	# print_debug("---------fix my jump im the bee ----------------")
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

	_body(1)
	timers.set_jump_up(.8)

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat.is_colliding():
				self.set_collision_mask_bit(2,false)
				SFX.play("Move_Jump_08")
				vel.y = terminal_vel / 2
				self.position.y += 10
		else:
			if !is_jump_pressed && on_floor && can_jump && !down_input:
				SFX.play("Move_Jump_01")
				vel.y = -max_jump_power * jump_power_up
				jump_top_pos = global_position.y - jump_height
				jumping_up = true
				stinger.big_ring_on()
			elif !is_jump_pressed && !on_floor && can_jump && max_air_jump_count > air_jump_count && !down_input:
				SFX.play("Move_Jump_05")
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
				stinger.big_ring()
			elif is_jump_pressed && global_position.y <= jump_top_pos && can_jump && !down_input && jumping_up:
				jump_top = true
				can_jump = false
				if timers.is_jump_stopped():
					timers.start_jump()
				stinger.big_ring_on()
		is_jump_pressed = true
		# print_debug("is down : ",is_down, "  DLR : ",down_input, _left_input, _right_input, "  ray platform test : ", ray_plat.is_colliding())

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
	return _vel

func jump_rel():
	self.set_collision_mask_bit(2,true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	stinger.big_ring_off()
	jumping_up = false
	jump_top_pos = global_position.y - jump_height
	is_jump_pressed = false
	jump_top = false
	can_jump = true

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num != current_body:
		print_debug("body changing in pawn 17")
		if _num == 1:
			body_s.disabled = false
			body_p.disabled = true
			_rays_stand()
		elif _num == 2:
			body_s.disabled = true
			body_p.disabled = false
			_rays_prone()
		else:
			print_debug("Pawn 17 bad body number in func _body")
		current_body = _num
##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if ray_up.is_colliding():
		jump_top_pos = position.y

func _is_on_floor():
	if ray_down_r_stand.is_colliding() || ray_down_l_stand.is_colliding() && !is_down:
		if !on_floor && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
			on_floor = true
	elif ray_down_r_prone.is_colliding() || ray_down_l_prone.is_colliding() && is_down:
		if !on_floor && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
			on_floor = true
	else:
		on_floor = false

	if ray_down_c_stand.is_colliding() && !is_down:
		going_up = true
	elif ray_down_c_prone.is_colliding() && is_down:
		going_up = true
	else:
		going_up = false

func _anim_idle():
	_body(1)
	head.play_face("On")
	new_anim = "Idle"
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_run():
	_body(1)
	head.play_face("On")
	if is_right:
		head.is_right(true)
		new_anim = "Run_Right"
	else:
		head.is_right(false)
		new_anim = "Run_Left"

func _anim_jump():
	_body(1)
	head.play_face("Flash")
	new_anim = "Idle"
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_prone_idle():
	_body(2)
	head.play_face("On")
	if is_right:
		head.is_right(true)
		new_anim = "Prone_Right"
	else:
		head.is_right(false)
		new_anim = "Prone_Left"

func _anim_prone_crawl():
	_body(2)
	head.play_face("Flash")
	if is_right:
		head.is_right(true)
		new_anim = "Prone_Right"
	else:
		head.is_right(false)
		new_anim = "Prone_Left"

func _anim_stun():
	_body(1)
	head.play_face("Stun")
	new_anim = "Stun"
	print_debug("make stun anim for pawn 17")
	head.play_face("Stun")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_Knock():
	_body(1)
	new_anim = "Up"
	print_debug("make knock back anim for pawn 17")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func shield_up():
	shield_sprite.visible = true
	head.shield_up()
	stinger.shield_up()

func shield_down():
	shield_sprite.visible = false
	head.shield_down()
	stinger.shield_down()

func _rays_stand():
	ray_down_l = ray_down_l_stand
	ray_down_c = ray_down_c_stand
	ray_down_r = ray_down_r_stand

func _rays_prone():
	ray_down_l = ray_down_l_prone
	ray_down_c = ray_down_c_prone
	ray_down_r = ray_down_r_prone

func _set_gun_dir():
	if is_right:
		arm.is_right(true)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			head.rotation_degrees = -85
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
			head.rotation_degrees =-45
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			head.rotation_degrees = 35
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
			head.rotation_degrees = 85
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		arm.is_right(false)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			head.rotation_degrees = 85
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
			head.rotation_degrees = 45
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			head.rotation_degrees = -35
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
			head.rotation_degrees = -85
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	stinger.color(_pri, _sec)
	arm.color(_pri, _sec)
	shield_sprite.self_modulate = _sec
	body_sprite.self_modulate = _pri


func jumptimer():
	jump_top = false
	jumping_up = false
	is_jump_pressed = false
	stinger.big_ring_off()