extends 'res://Scripts/Pawns/Pawn_00.gd'
onready var head = $Body/POS_Head/Pawn_01_Head
onready var my_body = $Body
onready var arm = $Body/POS_Arm/Pawn_05_Part_Arm
onready var legf = $"Pawn_01-Legs_F"
onready var legb = $"Pawn_01-Legs_B"
onready var legfs = $"Pawn_01-Legs_F_Shield"
onready var legbs = $"Pawn_01-Legs_B_Shield"
onready var hip = $"Pawn_01-Legs_Hip"
onready var shield = $Body/Shield
onready var my_anim = $AnimationPlayer
onready var my_gun_pos = $Body/POS_Arm/Pawn_05_Part_Arm/POS_Gun

onready var ray_up = $Raycasts/Up
onready var ray_down_l = $Raycasts/Down_L
onready var ray_down_r = $Raycasts/Down_R
onready var ray_plat = $Raycasts/Plat_Test

onready var body1 = $CollisionShape2D_Up
onready var body2 = $CollisionShape2D_Down

onready var my_attachment_point = $Body/Attachment_Point

export var my_grav = 8
export var my_max_x_speed = 310
export var my_armor = 0
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 0
export var my_max_air_jump_power = 5
export var my_min_air_jump_power = 2
export var my_max_jump_power = 8
export var my_min_jump_power = 2

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 110
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 40
export var my_light_on_nrg = 39

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

#-------------------------------------[Jump]

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
			if !is_jump_pressed && on_floor:# && !down_input:
				jump_ground_sound()
				vel.y = -max_jump_power * jump_power_up
				jump_stat()
		is_jump_pressed = true

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if down_input && on_floor && ray_plat.is_colliding():
				jump_down_sound()
				vel.y += 2
				self.position.y += 7

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
	if ray_up.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		on_floor = true
		SFX.jump_land()
	else :
		on_floor = false

func _anim_idle():
	new_anim = "Stand"
	head.play("On")
	_body(1)
	legs_right(is_right)

func _anim_run():
	new_anim = "Run"
	head.play("On")
	_body(1)
	legs_right(is_right)

func _anim_jump():
	if vel.y < 0:
		new_anim = "Jump"
	elif vel.y > 0:
		new_anim = "Fall"
	head.play("Flash")
	_body(1)
	legs_right(is_right)

func _anim_prone_idle():
	_body(2)
	if is_right:
		new_anim = "Prone-Right-Idle"
	else:
		new_anim = "Prone-Left-Idle"
	head.play("On")

func _anim_prone_crawl():
	_body(2)
	if is_right:
		new_anim = "Crawl-Right"
	else:
		new_anim = "Crawl-Left"
	head.play("On")

func _anim_stun():
	print_debug("make stun animation pawn 01")
	if is_right:
		_body(1)
		new_anim = "Stun-Right"
	else:
		_body(1)
		new_anim = "Stun-Left"
	head.play("Stun")

func _anim_Knock():
	print_debug("make Knock back animation pawn 01")
	if is_right:
		_body(1)
		new_anim = "Right"
	else:
		_body(1)
		new_anim = "Left"
	head.play("Stun")

func _anim_ladder_move():
	print_debug("make ladder animation pawn 01")
	_body(1)
	new_anim = "Ladder_Move"
	head.play("Up")

func _anim_ladder_right():
	_body(1)
	new_anim = "Ladder_Right"
	head.play("On")

func _anim_ladder_left():
	_body(1)
	new_anim = "Ladder_Left"
	head.play("On")

func _set_gun_dir():
	arm.is_right(is_right)
	head.is_right(is_right)
	if is_right:
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
			arm.bend(3)
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			arm.bend(3)
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
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
			arm.bend(3)
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			arm.bend(3)
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
		body1.disabled = false
		body2.disabled = true
	elif _num == 2:
		body1.disabled = true
		body2.disabled = false
	else:
		print_debug("wrong body call in pawn 01")

func shield_up():
	head.shield_up()
	legbs.visible = true
	legfs.visible = true
	shield.visible = true

func shield_down():
	head.shield_down()
	legbs.visible = false
	legfs.visible = false
	shield.visible = false

func legs_right(_is_right):
	if _is_right:
		legf.scale.x = 1
		legb.scale.x = 1
		legfs.scale.x = 1
		legbs.scale.x = 1
	else:
		legf.scale.x = -1
		legb.scale.x = -1
		legfs.scale.x = -1
		legbs.scale.x = -1

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	legf.self_modulate = _pri
	legb.self_modulate = _pri
	legfs.self_modulate = _sec
	legbs.self_modulate = _sec
	hip.self_modulate = _sec
	arm.color(_pri, _sec)
	my_body.self_modulate = _pri
	shield.self_modulate = _sec
