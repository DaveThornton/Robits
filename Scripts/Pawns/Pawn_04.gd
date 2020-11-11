extends KinematicBody2D

onready var arm = $Body/POS_Arm/Pawn_04_Part_Arm
onready var gun_pos = $Body/POS_Arm/Pawn_04_Part_Arm/POS_Gun

onready var head = $Body/Pawn_04_Part_Head
onready var hover = $Body/Pawn_04_legs

onready var body_sprite = $Body
onready var shield_sprite = $Body/Shield

onready var timers = $Timers
onready var knockback_timer = $Timers/Knock_Back
onready var shield_hit_timer = $Timers/Shield_Hit
onready var shield_up_timer = $Timers/Shield_Up
onready var stun_timer = $Timers/Stun
onready var speed_timer = $Timers/Speed
onready var jump_timer = $Timers/Jump_Up
onready var nrg_up_timer = $Timers/NRG_Up
onready var jump_up_timer = $Timers/Jump_Up

onready var anim = $AnimationPlayer
onready var ladder_count = [] #shouldnt be here??!!??

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

var ray_down_l
var ray_down_c
var ray_down_r

var player = 1
var play_type = 2
var start_equiped = false
var armor = 1

var my_gun
var my_start_gun
var take_ammo = false
var shoot_spot = 3

var vel = Vector2()
var grav = 8
var terminal_vel = 5

var max_x_speed = 180
var current_x_speed = 0

#-------------------------------------------------------------------JUMP--------
var is_jump_pressed: = false
var jumping_up: = false
var can_jump = true
var jump_top_pos = 0.0
var jump_top = false
var jump_height = 150
var max_air_jump_count = 5
var max_air_jump_power = 3
var min_air_jump_power = 1.5
var air_jump_count = 0
var max_jump_power = 8
var min_jump_power = 1.5

var move_step = 0
var dec_step = 0


#--------------------------------------------------------------------NRG--------
var nrg_max = 90
var nrg = 90
var last_nrg = 90
var nrg_regen_rate = 5
var nrg_regen_max = 40
var nrg_default_regen_rate = 4
var nrg_default_regen_max = 40
var light_on_nrg = 39

var can_move = true
var is_right = true
var is_down = false
var on_floor = false
var going_up = false
var not_on_angle = false

var is_shield_up = false
var speed_power_up = 1
var is_speed_up = false
var jump_power_up = 1
var is_jump_up = false

var new_anim = "Up"
var last_anim = "Up"

var is_holding = false
var wep_array = []
var poss_pick_obj
var knocked_back = Vector2(0, 0)

var on_ladder = false
var over_ladder = false
var ladder_speed = 225
##---------------------------------------------------------------HIT------------
var _pri_color = Color8(255, 255, 255, 255)
var _sec_color = Color8(255, 255, 255, 255)
var _im_hit = false
var _hit_time = 0.0
var _hit_color_01 = Color8(255, 255, 255, 255)
var _hit_color_02 = Color8(255, 106, 0, 130)

signal explode_p

func _ready():
	ray_down_l = ray_down_l_stand
	ray_down_c = ray_down_c_stand
	ray_down_r = ray_down_r_stand
	timers.set_jump_up(.8)

func init(_player_num, _pos, _start_equiped, _play_type):
	player = _player_num
	play_type = _play_type
	_set_color()
	start_equiped = _start_equiped
	if start_equiped:
		equip_start_weap()
	change_pos(_pos)
	nrg_update()

func _process(delta):
	if ladder_count.size() > 0:
		over_ladder = true
	else:
		over_ladder = false
		on_ladder = false
	_is_on_floor()
	_test_headroom()
	_set_gun_dir()
	if on_floor:
		air_jump_count = 0
	if new_anim != last_anim:
		anim.play(new_anim)
		last_anim = new_anim
	if nrg < nrg_regen_max:
		if nrg > light_on_nrg:
			head.play_face("Off")
		else:
			head.play_face("On")
		nrg = clamp(nrg + (nrg_regen_rate * delta), 0, 100)
	if nrg != last_nrg:
		nrg_update()
		last_nrg = nrg
	if my_gun:
		my_gun.is_right = is_right
		my_gun.shoot_pos = shoot_spot
		
	elif start_equiped:
		my_start_gun.is_right = is_right
		my_start_gun.shoot_pos = shoot_spot
	
	if _im_hit:
		if _hit_time > 0.1:
			_hit_time -= delta
			_set_new_color(_hit_color_01, _hit_color_02)
			_hit_time = clamp(_hit_time,0,.3)
		elif _hit_time > 0.05:
			_hit_time -= delta
			_set_new_color(_hit_color_02, _hit_color_01)
		elif _hit_time > 0:
			_hit_time -= delta
			_set_new_color(_hit_color_01, _hit_color_02)
		else:
			_set_new_color(_pri_color, _sec_color)
			_hit_time = 0.0
			_im_hit = false

func _physics_process(delta):
	var _1 = move_and_slide(Vector2(current_x_speed + knocked_back.x , 0 + knocked_back.y ))
	var movement = Vector2(0 , (vel.y + (grav * int(!on_floor)) * delta)* int(!on_ladder))
	vel = movement
	if !is_jump_pressed:
		if going_up:
			vel.y = -2
		elif on_floor && !is_jump_pressed:
			vel.y = 0
		elif vel.y > terminal_vel:
			vel.y = terminal_vel
	else:
		if jump_top:
			vel.y = 0
	var _2 = move_and_collide(vel)

##-------------------------------------------------------------------[Move/jump]
func move_x(_moving, _right):
	if can_move:
		if on_floor:
			if _moving:
				if is_down:
					if _right:
						current_x_speed += max_x_speed /10 * speed_power_up / 3
					else:
						current_x_speed += -max_x_speed /10 * speed_power_up / 3
					current_x_speed = clamp(current_x_speed, -max_x_speed / 4 , max_x_speed / 4)
				else:
					if _right:
						current_x_speed += max_x_speed / 5 * speed_power_up
					else:
						current_x_speed += -max_x_speed / 5 * speed_power_up
			else:
				if current_x_speed < 2 && current_x_speed > -2 || on_ladder:
					current_x_speed = 0
				else:
					current_x_speed -= current_x_speed / 2
		else:
			if _moving:
				if is_down:
					if _right:
						current_x_speed += max_x_speed /5 * speed_power_up / 3
					else:
						current_x_speed += -max_x_speed /5 * speed_power_up / 3
					current_x_speed = clamp(current_x_speed, -max_x_speed / 4 , max_x_speed / 4)
				else:
					if _right:
						current_x_speed += max_x_speed / 2 * speed_power_up
					else:
						current_x_speed += -max_x_speed / 2 * speed_power_up
			else:
				if current_x_speed < 2 && current_x_speed > -2 || on_ladder:
					current_x_speed = 0
				else:
					current_x_speed -= current_x_speed / 20
	else:
		if current_x_speed < 2 && current_x_speed > -2 || on_ladder:
			current_x_speed = 0
		else:
			current_x_speed -= current_x_speed / 10
	current_x_speed = clamp(current_x_speed, -max_x_speed , max_x_speed)

func jump(down_input, left_input, right_input):
	if down_input && ray_plat_check.is_colliding() && !left_input && !right_input:
		SFX.play("Move_Jump_08")
		var thing1 = ray_plat_check.get_collider()
		if thing1:
			if thing1.get_groups().has("map"):
				pass
			else:
				vel.y += terminal_vel / 5
				self.position.y += 2
	
	elif !is_jump_pressed && on_floor && can_jump:
		SFX.play("Move_Jump_01")
		vel.y = -max_jump_power * jump_power_up
		jump_top_pos = global_position.y - jump_height
	
	elif !is_jump_pressed && !on_floor && can_jump && max_air_jump_count > air_jump_count:
		SFX.play("Move_Jump_05")
		vel.y = -max_air_jump_power * jump_power_up
		air_jump_count += 1
	
	elif is_jump_pressed && global_position.y <= jump_top_pos && can_jump:
		jump_top = true
		can_jump = false
		if jump_timer.is_stopped():
			jump_timer.start()
	is_jump_pressed = true
	on_ladder = false

func jump_j(_down_input, _left_input, _right_input):
	pass

func jump_rel():
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	jump_top_pos = global_position.y - jump_height
	is_jump_pressed = false
	jump_top = false
	can_jump = true
	
##-----------------------------------------------------------------------[Shoot]
func shoot_j():
	if my_gun:
		my_gun.shoot_pos = shoot_spot
		my_gun.is_right = is_right
		my_gun.shoot_j()
	elif my_start_gun && start_equiped:
		my_start_gun.shoot_pos = shoot_spot
		my_start_gun.is_right = is_right
		my_start_gun.shoot_j()
func shoot():
	if my_gun:
		my_gun.shoot_pos = shoot_spot
		my_gun.is_right = is_right
		my_gun.shoot()
	elif my_start_gun && start_equiped:
		my_start_gun.shoot_pos = shoot_spot
		my_start_gun.is_right = is_right
		my_start_gun.shoot()
func shoot_r():
	if my_gun:
		my_gun.shoot_pos = shoot_spot
		my_gun.is_right = is_right
		my_gun.shoot_r()
	elif my_start_gun && start_equiped:
		my_start_gun.shoot_pos = shoot_spot
		my_start_gun.is_right = is_right
		my_start_gun.shoot_r()

##-----------------------------------------------------------------------[Throw]
func pick_throw( left_input, right_input, up_input, down_input, hold_input):
	if is_holding == true:
		take_ammo = false
		is_holding = false
		if !left_input && !right_input && !up_input && !down_input && !hold_input:
			SFX.play("Blip_11")
			my_gun.drop()
		else:
			SFX.play("Blip_06")
			my_gun.throw()
		my_gun = null
		if my_start_gun && start_equiped:
			my_start_gun.visible = true
	elif wep_array.size() > 0:
		pick_up()
		if my_start_gun && start_equiped:
			my_start_gun.visible = false

func let_go():
	if is_holding == true:
		take_ammo = false
		is_holding = false
		my_gun.drop()
		my_gun = null

func pick_up():
	SFX.play("Blip_04")
	poss_pick_obj = wep_array.front()
	var _time_left = poss_pick_obj.time
	var _ammo_pick_up = poss_pick_obj.ammo
	var _weap_num = poss_pick_obj.gun_num
	var _just_shot = poss_pick_obj.just_shot
	equip_weap(_weap_num,_ammo_pick_up, _time_left, _just_shot)
	poss_pick_obj.queue_free()

func no_gun():
	if is_holding == true:
		take_ammo = false
		is_holding = false
		my_gun = null

##-----------------------------------------------------------------------[Equip]
func equip_weap(_weap_num, _ammo_pick_up, _time_left, _just_shot):
	var g = Equipment.get_weap_hold(_weap_num).instance()
	gun_pos.add_child(g)
	g.init(_ammo_pick_up, player, _time_left, _just_shot)
	take_ammo = g.take_ammo
	my_gun = g
	is_holding = true

func equip_start_weap():
	var g = Equipment.get_weap_hold(0).instance()
	gun_pos.add_child(g)
	g.init(false, player, 0, false)
	my_start_gun = g

##-------------------------------------------------------------------------[HIT]
func hit(_by_who, _by_what, _damage_type, _damage):
	_im_hit = true
	_hit_time += 0.11
	if play_type == 1:
		if is_shield_up:
			print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
		else:
			is_shield_up = true
			print("ive been hit. I'm player ",player)
			let_go()
			emit_signal("explode_p", player, self.position, _by_who, _by_what)
			call_deferred("free")
	elif play_type > 1:
		shield_sprite.visible = true
		head.shield_up()
#		key.shield_up()
		shield_hit_timer.start()
		if !is_shield_up:
			nrg = nrg - (_damage - armor)
			nrg_update()
			if nrg <= 0:
				is_shield_up = true
				print("ive been hit. I'm player ",player)
				let_go()
				emit_signal("explode_p", player, self.position, _by_who, _by_what)
				call_deferred("free")
			elif nrg < light_on_nrg:
				print("do something with less nrg in pawn 06 hit")
			else:
				print("do something with less nrg in pawn 06 hit")

func change_pos(_pos):
	self.position = _pos

func nrg_update():
	Player_Stats.nrg_update(player, nrg, nrg_max)

##--------------------------------------------------------------------[Power Up]

func put_shield_up(_how_long):
	is_shield_up = true
	shield_sprite.visible = true
	if _how_long <= 0:
		shield_up_timer.wait_time = 10
	else:
		shield_up_timer.wait_time = _how_long
	shield_up_timer.start()

func put_speed_up(_how_long):
	is_speed_up = true
	speed_power_up = 2
	speed_timer.wait_time = _how_long
	speed_timer.start()

func put_jump_up(_how_long):
	is_jump_up = true
	jump_power_up = 2
	if _how_long <= 0:
		jump_up_timer.wait_time = 10
	else:
		jump_up_timer.wait_time = _how_long
	jump_up_timer.start()

func put_nrg_regen_speed_up(_how_long, _how_fast, _how_much):
	nrg_regen_rate = _how_fast
	nrg_regen_max = _how_much
	nrg_up_timer.wait_time = _how_long
	nrg_up_timer.start()

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
#	print("fix body in pawn 04")
	if _num == 1:
		body_s.disabled = false
		body_p.disabled = true
	elif _num == 2:
		body_s.disabled = true
		body_p.disabled = false
	else:
		print("Pawn 04 bad body number in func _body")
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
#	print(on_floor, "     ",going_up)

##----------------------------------------------------------------[Stun / Knock]
func stun(_gun_num):
	stun_timer.start()
	can_move = false
	_anim_stun()
	let_go()

func knock_back(_amount, _time):
	knockback_timer.wait_time = _time
	knockback_timer.start()
	if is_right:
		if shoot_spot == 1:
			knocked_back = Vector2(-(_amount * .1), (_amount * .9))
		if shoot_spot == 2:
			knocked_back = Vector2(-(_amount * .5), (_amount * .5))
		if shoot_spot == 3 ||shoot_spot == 6:
			knocked_back = Vector2(-(_amount * .95), (_amount * .05))
		if shoot_spot == 4:
			knocked_back = Vector2(-(_amount * .5), -(_amount * .5))
		if shoot_spot == 5:
			knocked_back = Vector2(-(_amount * .1), -(_amount * .9))
	else:
		if shoot_spot == 1:
			knocked_back = Vector2((_amount * .1), (_amount * .9))
		if shoot_spot == 2:
			knocked_back = Vector2((_amount * .5), (_amount * .5))
		if shoot_spot == 3 ||shoot_spot == 6:
			knocked_back = Vector2((_amount * .95), (_amount * .05))
		if shoot_spot == 4:
			knocked_back = Vector2((_amount * .5), -(_amount * .5))
		if shoot_spot == 5:
			knocked_back = Vector2((_amount * .1), -(_amount * .9))

##-------------------------------------------------------------------[add stuff]
func add_nrg(_nrg):
	nrg = clamp(nrg + _nrg, 0, nrg_max)

func add_ammo(_ammo):
	if take_ammo:
		if my_gun:
			my_gun.add_ammo(_ammo)

##-------------------------------------------------------------------[Animation]
# warning-ignore:unused_argument
func anim_update(left_input, right_input, up_input, down_input, jump_input, hold_input, delta):
	if !down_input:
		is_down = false
	if can_move:
		if !hold_input:
			if !is_down:
				if right_input || left_input:
					_anim_run()
					if up_input:
						shoot_spot = 2
					elif down_input:
						shoot_spot = 4
					else:
						shoot_spot = 3
				elif up_input:
					shoot_spot = 1
					if over_ladder || on_ladder:
						air_jump_count = 0
						on_ladder = true
						self.position.y -= ladder_speed * delta
						_anim_ladder_move()
					elif on_floor:
						_anim_idle()
					else:
						_anim_jump()
				elif down_input:
					if over_ladder || on_ladder:
						on_ladder = true
						self.position.y += ladder_speed * delta
					elif on_floor:
						is_down = true
						shoot_spot = 6
						_anim_prone_idle()
					else:
						shoot_spot = 5
						_anim_jump()
				elif !left_input && !right_input:
					shoot_spot = 3
					if on_floor:
						_anim_idle()
					if !on_floor:
						_anim_jump()
					elif down_input:
						if on_floor:
							is_down = true
							shoot_spot = 6
							_anim_prone_idle()
						else:
							shoot_spot = 5
							_anim_prone_crawl()
			else:
				if left_input || right_input:
					_anim_prone_crawl()
				else:
					_anim_prone_idle()
					vel.x = 0
		else:
			_anim_idle()
			if right_input || left_input:
				if !up_input && !down_input:
					shoot_spot = 3
				elif down_input:
					shoot_spot = 4
				elif up_input:
					shoot_spot = 2
			elif up_input && !left_input && !right_input:
				shoot_spot = 1
			elif down_input && !left_input && !right_input:
				shoot_spot = 5
	
#	if !on_floor && vel.y > 1:
#		hover.play("Fall")
#	elif !on_floor && vel.y > -1:
#		hover.play("Jump")
	
	if on_ladder && !up_input && !down_input:
		if is_right:
			_anim_ladder_right()
		else:
			_anim_ladder_left()
#	print(vel.y)

func _anim_idle():
	_body(1)
	hover.rotation_degrees = 0
	new_anim = "Up"
	_rays_stand()
	hover.play("Idle")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_run():
	_body(1)
	new_anim = "Up"
	_rays_stand()
	hover.play("Idle")
	if is_right:
		head.is_right(true)
		hover.rotation_degrees = 45
	else:
		head.is_right(false)
		hover.rotation_degrees = -45

func _anim_jump():
#	print("pawn 04 jump")
	_body(1)
	new_anim = "Up"
	_rays_stand()
	if vel.y > 1:
		hover.play("Fall")
	elif vel.y > -1:
		hover.play("Jump")
		
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_prone_idle():
	_body(2)
	_rays_prone()
	hover.rotation_degrees = 0
	new_anim = "Prone"
	hover.play("Off")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_prone_crawl():
	_body(2)
	_rays_prone()
	new_anim = "Prone"
	hover.play("Off")
	if is_right:
		head.is_right(true)
		hover.rotation_degrees = 55
	else:
		head.is_right(false)
		hover.rotation_degrees = -55

func _anim_stun():
	_body(1)
	new_anim = "Up"
	_rays_stand()
	print("make stun anim for pawn 04")
	head.play_face("Stun")
	hover.play("Off")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_Knock():
	_body(1)
	new_anim = "Up"
	_rays_stand()
	print("make knock back anim for pawn 04")
	hover.play("Off")
	if is_right:
		head.is_right(true)
	else:
		head.is_right(false)

func _anim_ladder_move():
	_body(1)
	_rays_stand()
	hover.play("Off")
	print("make ladder anim for pawn 04")
	new_anim = "Up"
	head.is_right(true)
#	head.up()

func _anim_ladder_right():
	_body(1)
	_rays_stand()
	hover.play("Off")
	print("make ladder anim for pawn 04")
	new_anim = "Up"
	head.is_right(true)

func _anim_ladder_left():
	_body(1)
	_rays_stand()
	hover.play("Off")
	print("make ladder anim for pawn 04")
	new_anim = "Up"
	head.is_right(false)

func _rays_stand():
	_body(1)
	ray_down_l = ray_down_l_stand
	ray_down_c = ray_down_c_stand
	ray_down_r = ray_down_r_stand

func _rays_prone():
	_body(1)
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
		if my_gun:
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
		if my_gun:
			arm.rotation_degrees += my_gun.walk

##-----------------------------------------------------------------------[Color]
func _set_color():
	_pri_color = Player_Stats.get_body_color(player)
	_sec_color = Player_Stats.get_sec_color(player)
	_set_new_color(_pri_color,_sec_color)

func _set_new_color(_pri, _sec):
	head.color(_pri, _sec)
	hover.color(_pri, _sec)
	arm.color(_pri, _sec)
	shield_sprite.self_modulate = _sec
	body_sprite.self_modulate = _pri

##--------------------------------------------------------------------[Time Out]
func shielduptimer():
	shield_sprite.visible = false
	is_shield_up = false

func shieldhittimer():
	shield_sprite.visible = false
	head.shield_down()
	is_shield_up = false

func speedtimer():
	is_speed_up = false
	speed_power_up = 1

func jumptimer():
	is_jump_up = false
	jump_power_up = 1

func nrguptimer():
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max

func stuntimer():
	can_move = true

func knockbacktimer():
	knocked_back = Vector2(0, 0)

func jumpuptimer():
	jump_top = false
	is_jump_pressed = false
	
##-------------------------------------------------------------[The in and outs]

func _on_Pick_Up_Area_body_entered(body):
	if body.get_groups().has("PickUp"):
		wep_array.append(body)

func _on_Pick_Up_Area_body_exited(body):
	if body.get_groups().has("PickUp"):
		wep_array.erase(body)

func _on_Ladder_Area_body_entered(body):
	ladder_count.append(body)

func _on_Ladder_Area_body_exited(body):
	ladder_count.erase(body)

func killed_by_map(_by_who, _by_what, _damage_type, _damage):
	hit(_by_who, _by_what, _damage_type, (nrg* 2))

func start_next_level():
	if !my_gun && start_equiped > 0:
		equip_start_weap()
