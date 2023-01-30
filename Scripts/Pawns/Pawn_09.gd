extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var head = $POS_Body/Body/POS_Head/Pawn_09_Part_Head
onready var hbody = $POS_Body/Body
onready var arm = $POS_Body/Body/POS_Arm/Pawn_09_Part_Arm
onready var legs = $Pawn_09_Part_Legs
onready var shield = $Shield
onready var shield_body = $POS_Body/Body/BodyShield
onready var my_anim = $AnimationPlayer
onready var my_gun_pos = $POS_Body/Body/POS_Arm/Pawn_09_Part_Arm/POS_Gun

onready var ray_up = $Raycasts/Up
onready var ray_up2 = $Raycasts/Up2
onready var ray_down_l = $Raycasts/Down_L
onready var ray_down_r = $Raycasts/Down_R
onready var ray_down_l2 = $Raycasts/Down_L2
onready var ray_down_r2 = $Raycasts/Down_R2
onready var ray_plat = $Raycasts/Plat_Test

onready var body1 = $CollisionShape2D_Stand
onready var body2 = $CollisionShape2D_Down

onready var my_attachment_point = $POS_Body/Body/Attachment_Point


export var my_grav = 8
export var my_max_x_speed = 325
export var my_armor = 0
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 0
export var my_max_air_jump_power = 4
export var my_min_air_jump_power = 2
export var my_max_jump_power = 7
export var my_min_jump_power = 2

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 90
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
		if on_floor:
			is_jump_pressed = false
		else:
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

func balloon_on():
	grav -= 2
	max_jump_power += 2
	min_jump_power += 2

func balloon_off():
	grav +=2
	max_jump_power -= 2
	min_jump_power -= 2
	
##--------------------------------------------------------------------[Raycasts]
func _test_headroom():
	if ray_up.is_colliding() || ray_up2.is_colliding():
		head_room = 1
	else:
		head_room = 0

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding() || ray_down_r2.is_colliding() || ray_down_l2.is_colliding():
		on_floor = true
	else :
		on_floor = false

func _anim_idle():
	_body(1)
	legs.idle(is_right)
	if is_right:
		anim.play("Right")
	else:
		anim.play("Left")

func _anim_run():
	_body(1)
	legs.run(is_right)
	if is_right:
		anim.play("Right")
	else:
		anim.play("Left")

func _anim_jump():
	_body(1)
	if vel.y < 0:
		legs.jump(is_right)
	elif vel.y > 0:
		legs.fall(is_right)
	if is_right:
		anim.play("Right")
	else:
		anim.play("Left")

func _anim_prone_idle():
	legs.prone(is_right)
	_body(2)
	if is_right:
		anim.play("Right_Prone")
	else:
		anim.play("Left_Prone")

func _anim_prone_crawl():
	legs.crawl(is_right)
	_body(2)
	if is_right:
		anim.play("Right_Prone")
	else:
		anim.play("Left_Prone")

func _anim_stun():
	_body(1)
	legs.stun(is_right)
	if is_right:
		anim.play("Right_Stun")
	else:
		anim.play("Left_Stun")

func _anim_Knock():
	_body(1)
	if is_right:
		new_anim = "Right"
	else:
		new_anim = "Left"

func _set_gun_dir():
	arm.is_right(is_right)
	head.is_right(is_right)
	if is_right:
		if shoot_spot == 3:
			head.rotation_degrees = 0
			hbody.rotation_degrees = 0
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			head.rotation_degrees = -43
			hbody.rotation_degrees = -42
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 2:
			head.rotation_degrees = -23
			hbody.rotation_degrees = -22
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 4:
			head.rotation_degrees = 18
			hbody.rotation_degrees = 17
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 5:
			head.rotation_degrees = 43
			hbody.rotation_degrees = 42
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 6:
			head.rotation_degrees = 0
			hbody.rotation_degrees = 0
			arm.rotation_degrees = 0
			arm.bend(3)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		if shoot_spot == 3:
			head.rotation_degrees = 0
			hbody.rotation_degrees = 0
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(2)
		elif shoot_spot == 1:
			head.rotation_degrees = 43
			hbody.rotation_degrees = 42
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 2:
			head.rotation_degrees = 23
			hbody.rotation_degrees = 22
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 4:
			head.rotation_degrees = -18
			hbody.rotation_degrees = -17
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 5:
			head.rotation_degrees = -43
			hbody.rotation_degrees = -42
			arm.rotation_degrees = head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 6:
			head.rotation_degrees = 0
			hbody.rotation_degrees = 0
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
		print_debug("wrong body type called in pawn 09")

func shield_up():
	head.shield_up()
	legs.shield_up()
	shield.visible = true
	shield_body.visible = true

func shield_down():
	head.shield_down()
	legs.shield_down()
	shield.visible = false
	shield_body.visible = false

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	legs.color(_pri, _sec)
	arm.color(_pri, _sec)
	hbody.self_modulate = _pri
	shield.self_modulate = _sec
	shield_body.self_modulate = _sec
