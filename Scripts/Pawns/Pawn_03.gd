extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var my_gun_pos = $Body/POS_Arm/Pawn_03_Part_Arm/POS_Gun

onready var body_shape_01 = $CollisionShape2D_Stand
# onready var body_shape_02 = $CollisionShape2D_Left
# onready var body_shape_03 = $CollisionShape2D_Right
onready var body_shape_04 = $CollisionShape2D_Prone

onready var head = $Body/Pawn_03_Part_Head
onready var neck = $Body/Pawn_03_Part_Head/Pawn_03_Part_Neck
onready var arm = $Body/POS_Arm/Pawn_03_Part_Arm
onready var arm_pos = $Body/POS_Arm
onready var wheel1 = $Pawn_03_Part_Big_Wheel
onready var wheel2 = $Body/Pawn_03_Part_Small_Wheel

onready var body_sprite = $Body
onready var shield_sprite = $Body/Shield

onready var my_anim = $AnimationPlayer

onready var ray_up_r = $Raycasts/UpR
onready var ray_up_l = $Raycasts/UpL
onready var ray_down_l = $Raycasts/Left
onready var ray_down_r = $Raycasts/Right
onready var ray_down_l2 = $Raycasts/Left2
onready var ray_down_r2 = $Raycasts/Right2
onready var ray_plat = $Raycasts/Plat_Test

onready var my_attachment_point = $Body/Attachment_Point

export var my_grav = 9
export var my_max_x_speed = 340
export var my_armor = 0
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 5
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 6.75
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 105
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 30
export var my_light_on_nrg = 20

var body_state = 3

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

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if down_input && on_floor && ray_plat.is_colliding():
				jump_down_sound()
				vel.y += 2
				self.position.y += 7

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
			elif !is_jump_pressed && !on_floor && max_air_jump_count > air_jump_count:# && nrg >= 20:
				jump_air_sound()
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
				jump_air_stat()
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

func shield_up():
	head.shield_up()
	wheel1.shield_up()
	wheel2.shield_up()
	shield_sprite.visible = true

func shield_down():
	head.shield_down()
	wheel1.shield_down()
	wheel2.shield_down()
	shield_sprite.visible = false

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num == 1:
		body_shape_01.disabled = false
		body_shape_04.disabled = true
		shield_sprite.scale.x = 1
	elif _num == 2:
		body_shape_01.disabled = false
		body_shape_04.disabled = true
		shield_sprite.scale.x = -1
	elif _num == 3:
		body_shape_01.disabled = true
		body_shape_04.disabled = false
		shield_sprite.scale.x = 1
	elif _num == 4:
		body_shape_01.disabled = true
		body_shape_04.disabled = false
		shield_sprite.scale.x = -1
	else:
		print_debug("error in _body pawn 03 invalid body number")
	if body_state == 3:
		body_sprite.frame = 0
		wheel2.position.x = 20
	elif body_state == 1:
		body_sprite.frame = 1
		wheel2.position.x = -20
	elif body_state == 2:
		body_sprite.frame = 2
		wheel2.position.x = 0
##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if  ray_up_r.is_colliding() || ray_up_l.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding() || ray_down_r2.is_colliding() || ray_down_l2.is_colliding():
		if !on_floor && !is_jump_pressed:
			on_floor = true
			SFX.play("Move_Jump_19_Land")
	else :
		on_floor = false

func _anim_idle():
	anim.play("Idle")
	neck.play("Idle")
	wheel1.stop()
	wheel2.stop()
	if is_right:
		body_state = 3
		_body(1)
	else:
		body_state = 1
		_body(2)

func _anim_run():
	anim.play("Idle")
	neck.play("Idle")
	if is_right:
		wheel1.turn(true)
		wheel2.turn(true)
		body_state = 3
		_body(1)
	else:
		wheel1.turn(false)
		wheel2.turn(false)
		body_state = 1
		_body(2)

func _anim_jump():
	anim.play("Idle")
	neck.play("Idle")
	if is_right:
		wheel1.turn(true)
		wheel2.turn(true)
		body_state = 3
		_body(1)
	else:
		wheel1.turn(false)
		wheel2.turn(false)
		body_state = 1
		_body(2)

func _anim_prone_idle():
	anim.play("Prone")
	neck.play("Idle")
	wheel1.stop()
	wheel2.stop()
	if is_right:
		body_state = 3
		_body(3)
	else:
		body_state = 1
		_body(4)

func _anim_prone_crawl():
	anim.play("Prone")
	neck.play("Idle")
	if is_right:
		wheel1.turn(true)
		wheel2.turn(true)
		body_state = 3
		_body(3)
	else:
		wheel1.turn(false)
		wheel2.turn(false)
		body_state = 1
		_body(4)

func _anim_stun():
	anim.play("Stun")
	neck.play("Stun")
	if is_right:
		body_state = 3
		_body(1)
	else:
		body_state = 1
		_body(2)

func _anim_Knock():
	anim.play("Idle")
	neck.play("Idle")
	if is_right:
		body_state = 3
		_body(1)
	else:
		body_state = 1
		_body(2)

func _set_gun_dir():
	if is_right:
		arm.is_right(true)
		head.is_right(true)
		head.pos(shoot_spot)
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			arm.bend(3)
		elif shoot_spot == 1:
			arm.rotation_degrees = -85
			arm.bend(2)
		elif shoot_spot == 2:
			arm.rotation_degrees = -35
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
		arm.is_right(false)
		head.is_right(false)
		head.pos(shoot_spot)
		if shoot_spot == 3:
			arm.rotation_degrees = 0
			arm.bend(3)
		elif shoot_spot == 1:
			arm.rotation_degrees = 85
			arm.bend(2)
		elif shoot_spot == 2:
			arm.rotation_degrees = 35
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

func _set_new_color(_pri, _sec):
	arm.color(_pri, _sec)
	wheel1.color(_pri, _sec)
	wheel2.color(_pri, _sec)
	head.color(_pri, _sec)
	neck.color(_pri, _sec)
	body_sprite.self_modulate = _pri
	shield_sprite.self_modulate = _sec
