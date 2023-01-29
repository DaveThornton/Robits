extends 'res://Scripts/Pawns/Pawn_00.gd'

onready var head = $Pawn_16_Head
onready var arm = $Pawn_16_Head/Pawn_16_Part_Arm
onready var legs = $Pawn_16_Body

onready var my_gun_pos = $Pawn_16_Head/Pawn_16_Part_Arm/POS_Gun
onready var my_anim = $AnimationPlayer

onready var ray_up = $Raycasts/Up
onready var ray_down_l = $Raycasts/Down_L
onready var ray_down_c = $Raycasts/Down_C
onready var ray_down_r = $Raycasts/Down_R
onready var ray_plat1 = $Raycasts/Plat_Test
onready var ray_plat2 = $Raycasts/Plat_Test2

onready var body1 = $"CollisionShape2D-Stand"
# onready var ladder_l = $"Ladder_Area/CollisionShape2D-L"
# onready var ladder_r = $"Ladder_Area/CollisionShape2D-R"

onready var my_attachment_point = $Pawn_16_Head/Attachment_Point

export var my_grav = 8
export var my_max_x_speed = 150
export var my_armor = 1
#-------------------------------------------------------------------JUMP--------
export var my_max_air_jump_count = 1
export var my_max_air_jump_power = 5
export var my_min_air_jump_power = 5
export var my_max_jump_power = 14
export var my_min_jump_power = 2

#--------------------------------------------------------------------NRG--------
export var my_nrg_max = 125
export var my_nrg_regen_rate = 8
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

func jump_j(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if ray_plat1.is_colliding() || ray_plat2.is_colliding():
				self.set_collision_mask_bit(2,false)
				SFX.play("Move_Jump_08")
				vel.y = terminal_vel / 2
				self.position.y += 8
		else:
			if !is_jump_pressed && on_floor && !down_input:
				SFX.play("Move_Jump_01")
				vel.y = -max_jump_power * jump_power_up
			is_jump_pressed = true

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
	if ray_down_r.is_colliding() || ray_down_l.is_colliding() || ray_down_c.is_colliding():
		if !on_floor: # && !is_jump_pressed:
			SFX.play("Move_Jump_19_Land")
		on_floor = true
	else :
		on_floor = false

func _anim_idle():
	legs.play(1)
	if is_right:
		_body(2)
		anim.play("Idle")
	else:
		_body(1)
		anim.play("Idle")

func _anim_run():
#	legs.run(is_right)
	if is_right:
		_body(2)
		legs.play(2)
		anim.play("Idle")
	else:
		_body(1)
		legs.play(3)
		anim.play("Idle")

func _anim_jump():
	anim.play("Idle")

func _anim_prone_idle():
	legs.play(4)
	_body(3)
	anim.play("Crouch")

func _anim_prone_crawl():
	legs.play(5)
	_body(3)
	anim.play("Crouch")

func _anim_stun():
	head.play_eye(1)
	head.look(1, is_right)
	legs.play(7)
	if is_right:
		_body(2)
		anim.play("Right_Stun")
	else:
		_body(1)
		anim.play("Left_Stun")

func _anim_Knock():
	if is_right:
		_body(2)
		new_anim = "Right"
	else:
		_body(1)
		new_anim = "Left"

func _anim_ladder_move():
#	_body(1)
	print_debug("there should be no ladders sucka")

func _anim_ladder_right():
	_body(2)
	print_debug("there should be no ladders sucka")

func _anim_ladder_left():
	_body(1)
	print_debug("there should be no ladders sucka")

func _set_gun_dir():
	if can_move:
		arm.is_right(is_right)
		head.look(shoot_spot, is_right)
		if is_right:
			if shoot_spot == 3:
	#			head.rotation_degrees = 0
				arm.rotation_degrees = 0
				arm.bend(2)
			elif shoot_spot == 1:
	#			head.rotation_degrees = -43
				arm.rotation_degrees = -88
				arm.bend(2)
			elif shoot_spot == 2:
	#			head.rotation_degrees = -23
				arm.rotation_degrees = -45
				arm.bend(2)
			elif shoot_spot == 4:
	#			head.rotation_degrees = 18
				arm.rotation_degrees = 45
				arm.bend(3)
			elif shoot_spot == 5:
	#			head.rotation_degrees = 43
				arm.rotation_degrees = 88
				arm.bend(3)
			elif shoot_spot == 6:
				head.rotation_degrees = 0
				arm.rotation_degrees = 0
				arm.bend(2)
			if my_gun != null:
				arm.rotation_degrees -= my_gun.walk
		else:
			if shoot_spot == 3:
	#			head.rotation_degrees = 0
				arm.rotation_degrees = 0
				arm.bend(2)
			elif shoot_spot == 1:
	#			head.rotation_degrees = 43
				arm.rotation_degrees = 88
				arm.bend(2)
			elif shoot_spot == 2:
	#			head.rotation_degrees = 23
				arm.rotation_degrees = 45
				arm.bend(2)
			elif shoot_spot == 4:
	#			head.rotation_degrees = -18
				arm.rotation_degrees = -45
				arm.bend(3)
			elif shoot_spot == 5:
	#			head.rotation_degrees = -43
				arm.rotation_degrees = -88
				arm.bend(3)
			elif shoot_spot == 6:
	#			head.rotation_degrees = 0
				arm.rotation_degrees = 0
				arm.bend(2)
			if my_gun != null:
				arm.rotation_degrees += my_gun.walk

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	pass
#	print_debug("fix body in pawn 13")
#	if _num == 1:
#		body1.disabled = false
#		ladder_l.disabled = false
#		ladder_r.disabled = true
#	elif _num == 2:
#		body1.disabled = false
#		ladder_l.disabled = true
#		ladder_r.disabled = false
#	elif _num == 3:
#		body1.disabled = true
#		ladder_l.disabled = false
#		ladder_r.disabled = false

func shield_up():
	head.shield_up()
	legs.shield_up()

func shield_down():
	head.shield_down()
	legs.shield_down()

# ##---------------------------------------------------------[Set collsion layers]
# func set_collision(_player):
# 	set_collision_layer_bit(Player_Stats.get_player_collision_layer(_player) - 1, true)
# 	set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, true)

# ##-----------------------------------------------------------------------[Color]
# func _set_color():
# 	_pri_color = Player_Stats.get_body_color(player)
# 	_sec_color = Player_Stats.get_sec_color(player)
# 	_set_new_color(_pri_color,_sec_color)

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	legs.color(_pri, _sec)
	arm.color(_pri, _sec)
##--------------------------------------------------------------------[Time Out]
# func shielduptimer():
# 	shield_down()
# 	is_shield_up = false

# func shieldhittimer():
# 	shield_down()

# func speedtimer():
# 	is_speed_up = false
# 	speed_power_up = 1

# func jumpuptimer():
# 	is_jump_up = false
# 	jump_power_up = 1

# func nrguptimer():
# 	nrg_regen_rate = nrg_default_regen_rate
# 	nrg_regen_max = nrg_default_regen_max

# func stuntimer():
# 	can_move = true

# func knockbacktimer():
# 	knocked_back = Vector2(0, 0)

# func jumptimer():
# 	print_debug("jump timer timed out dont know why in pawn 13 player stats says its pawn ",Player_Stats.get_pawn_num(player))

# func hitbytimer():
# 	hit_last_by = -1
	
# ##------------------------------------------------------[player indicator stuff]
# func set_ready_show_player_ind(_ready):
# 	ready_show_player_ind = _ready

# func get_ready_show_player_ind():
# 	return ready_show_player_ind

# func start_ready_show_player_ind():
# 	timers.start_show_player_ind()

# func show_player_ind(_show):
# 	if _show:
# 		player_indicator.visible = true
# 	else:
# 		player_indicator.visible = false

# func get_player_ind_vis():
# 	return player_indicator.visible

# ##-------------------------------------------------------------[The in and outs]

# func _on_Pick_Up_Area_body_entered(body):
# 	if body.get_groups().has("PickUp"):
# 		wep_array.append(body)

# func _on_Pick_Up_Area_body_exited(body):
# 	if body.get_groups().has("PickUp"):
# 		wep_array.erase(body)

# func _on_Ladder_Area_body_entered(body):
# 	ladder_count.append(body)

# func _on_Ladder_Area_body_exited(body):
# 	ladder_count.erase(body)

# func killed_by_map(_by_who, _by_what, _damage_type, _damage):
# 	hit(_by_who, _by_what, _damage_type, (nrg* 2))

# func start_next_level():
# 	if !my_gun && start_equiped > 0:
# 		equip_start_weap()
