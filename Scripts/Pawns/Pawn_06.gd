extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var arm = $POS_Arm/Pawn_06_Part_Arm
onready var my_gun_pos = $POS_Arm/Pawn_06_Part_Arm/POS_Gun

onready var body_shape_02 = $Shape_Stand
onready var body_shape_04 = $Shape_Down

onready var head = $Pawn_06_Part_Head
onready var hover = $Pawn_06_Part_Hover
onready var hover_part = $Pawn_06_Part_Hover/CPUParticles2D

onready var body_sprite = $Body_Sprite
onready var shield_sprite = $Shield_Sprite

onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycast/Up
onready var ray_down_l = $Raycast/Down_L
onready var ray_down_c = $Raycast/Down_C
onready var ray_down_r = $Raycast/Down_R
onready var ray_down_p = $Raycast/Down_Plat
onready var ray_plat = $Raycast/Plat_Test

onready var my_attachment_point = $Attachment_Point

export var my_grav = 6
export var my_max_x_speed = 240
export var my_armor = 1
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 2
export var my_max_air_jump_power = 3
export var my_min_air_jump_power = 1.5
export var my_max_jump_power = 7.5
export var my_min_jump_power = 1.5

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 110
export var my_nrg_regen_rate = 5
export var my_nrg_regen_max = 40
export var my_light_on_nrg = 39

#---------------------------------------------------------------Extra_JUMP--------
export var jump_time: = 1.4
export var jump_height = 180
var jumping_up: = false
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

# func _physics_process(delta):
# 	var _1 = move_and_slide(Vector2(current_x_speed + knocked_back.x , 0 + knocked_back.y ))
# 	var movement = Vector2(0 , (vel.y + (grav * int(!on_floor)) * delta))#* int(!on_ladder))
# 	vel = movement
# 	if !is_jump_pressed:
# 		if going_up:
# 			vel.y = -1
# 		elif on_floor:
# 			vel.y = 0
# 		elif vel.y > terminal_vel:
# 			vel.y = terminal_vel
# 	else:
# 		if jump_top:
# 			vel.y = 0
# 	var _2 = move_and_collide(vel)

func jump(_down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			pass
		else:
			if is_jump_pressed && global_position.y <= jump_top_pos && can_jump && jumping_up:
				jump_top = true
				can_jump = false
				if timers.is_jump_stopped():
					print_debug('jumptimer started')
					timers.start_jump()
				else:
					print_debug("jumptinmer not started")

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

func jump_j(_down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat.is_colliding():
				self.set_collision_mask_bit(2,false)
				SFX.play("Move_Jump_08")
				vel.y = terminal_vel / 2
				self.position.y += 8
		else:
			if !is_jump_pressed && on_floor && can_jump:
				SFX.play("Move_Jump_01")
				vel.y = -max_jump_power * jump_power_up
				jump_top_pos = global_position.y - jump_height
				jumping_up = true
			elif !is_jump_pressed && !on_floor && can_jump && max_air_jump_count > air_jump_count:
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
	jump_top_pos = global_position.y - jump_height
	is_jump_pressed = false
	jump_top = false
	jumping_up = false
	can_jump = true

func balloon_on():
	grav -= 2
	jump_height *= 3
	jump_top_pos += 1000
	max_jump_power += 2
	min_jump_power += 2

func balloon_off():
	grav +=2
	jump_height /= 3
	max_jump_power -= 2
	min_jump_power -= 2
	
func shield_up():
	shield_sprite.visible = true
	head.shield_up()

func shield_down():
	shield_sprite.visible = false
	head.shield_down()

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
		jump_top_pos = position.y

func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		if !on_floor && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
			on_floor = true
	else:
		on_floor = false

	if ray_down_c.is_colliding():
		going_up = true
	else:
		going_up = false

func _anim_idle():
	_body(2)
	hover_part.angle = 0
	if is_right:
		new_anim = "Right-Idle"
		head.right()
	else:
		new_anim = "Left-Idle"
		head.left()

func _anim_run():
	if is_right:
		head.right()
		new_anim = "Right-Run"
		hover_part.angle = -20
		_body(3)
	else:
		head.left()
		new_anim = "Left-Run"
		hover_part.angle = 20
		_body(1)

func _anim_jump():
	if is_right:
		head.right()
		new_anim = "Right-Run"
		_body(3)
	else:
		head.left()
		new_anim = "Left-Run"
		_body(1)

func _anim_prone_idle():
	_body(4)
	hover_part.angle = 0
	if is_right:
		head.right()
		new_anim = "Right-Prone-Idle"
	else:
		head.left()
		new_anim = "Left-Prone-Idle"

func _anim_prone_crawl():
	_body(4)
	hover_part.angle = 0
	if is_right:
		head.right()
		new_anim = "Right-Prone-Crawl"
	else:
		head.left()
		new_anim = "Left-Prone-Crawl"

func _anim_stun():
	_body(2)
	head.play_face(5)
	if is_right:
		head.right()
		new_anim = "Right-Stun"
	else:
		head.left()
		new_anim = "Left-Stun"

func _anim_Knock():
	_body(2)
	if is_right:
		head.right()
		new_anim = "Right-Knock_Back"
	else:
		head.left()
		new_anim = "Left-Knock_Back"

func _set_gun_dir():
	if is_right:
		arm.is_right(true)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
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
		arm.is_right(false)
		if shoot_spot == 3 || shoot_spot == 6:
			arm.rotation_degrees = 0
			head.rotation_degrees = 0
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
	head.color(_pri, _sec)
	arm.color(_pri, _sec)
	hover.modulate = _sec
	shield_sprite.self_modulate = _sec
	body_sprite.self_modulate = _pri

func jumptimer():
	jump_top = false
	jumping_up = false
	is_jump_pressed = false