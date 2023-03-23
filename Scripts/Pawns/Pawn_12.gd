extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var head = $Pawn_12_Part_Body/Pawn_12_Part_Head
onready var my_body = $Pawn_12_Part_Body
onready var pack = $Pawn_12_Part_Body/Pawn_12_Part_Jet_Pack
onready var arm = $Pawn_12_Part_Body/Pawn_12_Part_Arm
onready var legf = $Pawn_12_Part_Body/Pawn_12_Part_Legs_F
onready var legb = $Pawn_12_Part_Body/Pawn_12_Part_Legs_B
onready var hip = $Pawn_12_Part_Body/Pawn_12_Part_Hip

onready var shield = $Pawn_12_Part_Body/Shield

onready var my_gun_pos = $Pawn_12_Part_Body/Pawn_12_Part_Arm/POS_Gun
onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycasts/Up
onready var ray_down_l = $Raycasts/Down_L
onready var ray_down_r = $Raycasts/Down_R
onready var ray_plat = $Raycasts/Plat_Test

onready var body_shape_01 = $Shape_Stand
onready var body_shape_02 = $Shape_Crouch

onready var my_attachment_point = $Pawn_12_Part_Body/Attachment_Point

export var my_grav = 8
export var my_max_x_speed = 230
export var my_armor = 2
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 9
export var my_min_air_jump_power = 4
export var my_max_jump_power = 6
export var my_min_jump_power = 1

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 90
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 45
export var my_light_on_nrg = 44

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
	_jet_pack(vel.y)

# ##-------------------------------------------------------------[Jump]
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
			if !is_jump_pressed && on_floor && !is_down:
				jump_ground_sound()
				vel.y = -max_jump_power * jump_power_up
				jump_stat()
			elif !on_floor && air_jump_count < max_air_jump_count && !is_down:
				air_jump_count += 1
				jump_ground_sound()
				vel.y = -max_air_jump_power * jump_power_up
				jump_air_stat()
			is_jump_pressed = true

func fix_vel(_vel):
	if air_jump_count < 0:
		_jet_pack(_vel)
	if head_room > 0 && _vel.y < 0 && air_jump_count == 0:
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
		if !on_floor && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
			on_floor = true
		on_floor = true
	else :
		on_floor = false

func _anim_idle():
	_body(1)
	hip.stop()
	_jet_pack_right(is_right)
	if is_right:
		new_anim = "Right-Idle"
	else:
		new_anim = "Left-Idle"

func _anim_run():
	_jet_pack_right(is_right)
	if is_right:
		hip.turn(true)
		new_anim = "Right-Run"
		_body(1)
	else:
		hip.turn(false)
		new_anim = "Left-Run"
		_body(1)

func _anim_jump():
	_jet_pack_right(is_right)
	if air_jump_count == 0:
		if is_right:
			hip.turn(true)
			new_anim = "Right-Jump-1"
			_body(1)
		else:
			hip.turn(false)
			new_anim = "Left-Jump-1"
			_body(1)
	else:
		if is_right:
			hip.turn(true)
			new_anim = "Right-Jump-2"
			_body(1)
		else:
			hip.turn(false)
			new_anim = "Left-Jump-2"
			_body(1)

func _anim_prone_idle():
	_body(2)
	hip.stop()
	_jet_pack_right(is_right)
	if is_right:
		new_anim = "Right-Prone-Idle"
	else:
		new_anim = "Left-Prone-Idle"

func _anim_prone_crawl():
	_body(2)
	_jet_pack_right(is_right)
	if is_right:
		hip.turn(true)
		new_anim = "Right-Prone-Crawl"
	else:
		hip.turn(false)
		new_anim = "Left-Prone-Crawl"

func _anim_stun():
	_body(1)
	hip.stop()
	head.stun()
	_jet_pack_right(is_right)
	if is_right:
		new_anim = "Right-Stun"
	else:
		new_anim = "Left-Stun"

func _anim_Knock():
	_body(1)
	hip.stop()
	_jet_pack_right(is_right)
	if is_right:
		new_anim = "Right-Knock_Back"
	else:
		new_anim = "Left-Knock_Back"

func _set_gun_dir():
	arm.is_right(is_right)
	if is_right:
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = -45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = 35
			arm.bend(3)
		elif shoot_spot == 5:
			arm.rotation_degrees = 85
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			arm.bend(3)
		elif shoot_spot == 2:
			arm.rotation_degrees = 45
			arm.bend(2)
		elif shoot_spot == 4:
			arm.rotation_degrees = -35
			arm.bend(3)
		elif shoot_spot == 5:
			arm.rotation_degrees = -85
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

func _right(_is_right: bool):
	if _is_right:
		my_body.frame = 0
	else:
		my_body.frame = 1
	head.is_right(is_right)
	arm.is_right(is_right)

func _jet_pack_right(_right):
	if _right:
		pack.new_pos(1)
	else:
		pack.new_pos(2)
		
func _jet_pack(_vel):
	if air_jump_count != 0:
		if _vel < 0.0 :
			pack.flame_up()
			return
	pack.flame_down()

func shield_up():
	shield.visible = true
	pack.shield_up()
	head.shield_up()

func shield_down():
	shield.visible = false
	pack.shield_down()
	head.shield_down()

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	pack.color(_pri, _sec)
	arm.color(_pri, _sec)
	hip.color(_pri, _sec)
	my_body.self_modulate = _pri
	legf.self_modulate = _pri
	legb.self_modulate = _pri
	shield.modulate = _sec
