extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var my_gun_pos = $Pawn_10_Part_Body/POS_Arm/Pawn_10_Part_Arm/POS_Gun

onready var body_shape_01 = $Shape_Stand
onready var body_shape_02 = $Shape_Prone

onready var head = $Pawn_10_Part_Body/POS_Head/Pawn_10_Head
onready var head_pos = $Pawn_10_Part_Body/POS_Head
onready var arm = $Pawn_10_Part_Body/POS_Arm/Pawn_10_Part_Arm
onready var arm_pos = $Pawn_10_Part_Body/POS_Arm
onready var wheel = $Pawn_10_Part_Wheel

onready var body_sprite = $Pawn_10_Part_Body
onready var shield_sprite = $Pawn_10_Part_Body/Shield_Sprite

onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycast/Up
onready var ray_down_l = $Raycast/Down_L
onready var ray_down_r = $Raycast/Down_R
onready var ray_plat = $Raycast/Plat_Test

onready var my_attachment_point = $Pawn_10_Part_Wheel/Attachment_Point

export var my_grav = 9
export var my_max_x_speed = 330
export var my_armor = 2
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 0
export var my_max_air_jump_power = 5
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 7
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 80
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

##-------------------------------------------------------------[Jump]

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if down_input && on_floor && ray_plat.is_colliding():
				SFX.play("Move_Jump_08")
				vel.y += 1.5
				self.position.y += 3

func jump_j(_down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat.is_colliding():
				self.set_collision_mask_bit(2,false)
				SFX.play("Move_Jump_08")
				vel.y = terminal_vel / 2
				self.position.y += 8
		else:
			if !is_jump_pressed && on_floor:# && !down_input:
				SFX.play("Move_Jump_01")
				vel.y = -max_jump_power * jump_power_up
			elif !is_jump_pressed && !on_floor && max_air_jump_count > air_jump_count:# && nrg >= 20:
				SFX.play("Move_Jump_05")
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
			is_jump_pressed = true

func jump_rel():
	self.set_collision_mask_bit(2,true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

func balloon_on():
	grav -= 2
	max_jump_power += 2
	min_jump_power += 2

func balloon_off():
	grav +=2
	max_jump_power -= 2
	min_jump_power -= 2
	
func shield_up():
	wheel.shield_up()
	head.shield_up()
	shield_sprite.visible = true

func shield_down():
	wheel.shield_down()
	head.shield_down()
	shield_sprite.visible = false

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num == 1:
		body_shape_01.disabled = false
		body_shape_02.disabled = true

	elif _num == 2:
		body_shape_01.disabled = false
		body_shape_02.disabled = true
	elif _num == 3:
		body_shape_01.disabled = false
		body_shape_02.disabled = true
	elif _num == 4:
		body_shape_01.disabled = true
		body_shape_02.disabled = false
	elif _num == 5:
		body_shape_01.disabled = true
		body_shape_02.disabled = false
##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if ray_up.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		if !on_floor && !is_jump_pressed:
			on_floor = true
			wheel.on_floor = true
			SFX.play("Move_Jump_19_Land")
	else :
		on_floor = false
	
func _anim_idle():
	_body(1)
	wheel.stop()
	head.play("Idle")
	if is_right:

		new_anim = "Right-Idle"
	else:
		new_anim = "Left-Idle"

func _anim_run():
	head.play("Idle")
	if is_right:
		new_anim = "Right-Run"
		wheel.turn(true)
		_body(3)
	else:
		new_anim = "Left-Run"
		wheel.turn(false)
		_body(2)

func _anim_jump():
	head.play("Idle")
	if is_right:
		new_anim = "Right-Run"
		wheel.turn(true)
		_body(1)
	else:
		new_anim = "Left-Run"
		wheel.turn(false)
		_body(1)

func _anim_prone_idle():
	head.play("Idle")
	wheel.stop()
	if is_right:
		_body(5)
		new_anim = "Right-Prone-Idle"
	else:
		new_anim = "Left-Prone-Idle"
		_body(4)

func _anim_prone_crawl():
	head.play("Idle")
	if is_right:
		new_anim = "Right-Prone-Crawl"
		wheel.turn(true)
		_body(5)
	else:
		new_anim = "Left-Prone-Crawl"
		wheel.turn(false)
		_body(4)

func _anim_stun():
	_body(1)
	head.play("Stun")
	if is_right:
		new_anim = "Left-Stun"
	else:
		new_anim = "Left-Stun"

func _anim_Knock():
	_body(1)
	head.play("Idle")
	if is_right:
		new_anim = "Right-Knock_Back"
	else:
		new_anim = "Left-Knock_Back"

func _set_gun_dir():
	if is_right:
		arm.is_right(true)
		head.is_right(true)
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
			arm.bend(1)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			head.rotation_degrees = -50
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = -35
			head.rotation_degrees = -20
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			head.rotation_degrees = 20
			arm.bend(3)
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
			head.rotation_degrees = 50
			arm.bend(3)
		elif shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		arm.is_right(false)
		head.is_right(false)
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
			arm.bend(1)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			head.rotation_degrees = 50
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = 35
			head.rotation_degrees = 20
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			head.rotation_degrees = -20
			arm.bend(3)
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
			head.rotation_degrees = -50
			arm.bend(3)
		elif shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk

func _set_new_color(_pri, _sec):
	arm.color(_pri, _sec)
	wheel.color(_pri, _sec)
	head.color(_pri, _sec)
	body_sprite.self_modulate = _pri