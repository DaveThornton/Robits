extends KinematicBody2D

onready var arm = $Robit_11/Pawn_11_Body/Pos_Arm/Pawn_11_Part_Arm
onready var gun_pos = $Robit_11/Pawn_11_Body/Pos_Arm/Pawn_11_Part_Arm/POS_Gun

onready var body_shape_01 = $Shape_Stand
onready var body_shape_02 = $Shape_Prone

onready var head = $Robit_11/Pawn_11_Body/Pawn_11_Part_Head
onready var key = $Robit_11/Pawn_11_Body/Pawn_05_Part_Key
onready var trax = $Robit_11/Pawn_11_Part_Tracks
onready var rockets = $Robit_11/Pawn_11_Part_Tracks/Pawn_07_Part_Fire
#onready var body = $Pawn_11_Part_Body
onready var body_sprite = $Robit_11/Pawn_11_Body
onready var shield_sprite = $Robit_11/Shield

onready var knockback_timer = $Timers/Knock_Back
onready var shield_hit_timer = $Timers/Shield_Hit
onready var shield_up_timer = $Timers/Shield_Up
onready var stun_timer = $Timers/Stun
onready var speed_timer = $Timers/Speed
onready var jump_up_timer = $Timers/Jump_Up
onready var nrg_up_timer = $Timers/NRG_Up
onready var last_hit_timer = $Timers/Last_Hit_By

onready var anim = $AnimationPlayer

onready var ladder_count = [] #shouldnt be here??!!??

onready var ray_up = $Raycast/Up
onready var ray_down_l = $Raycast/Down_L
onready var ray_down_r = $Raycast/Down_R
onready var ray_plat = $Raycast/Plat_Test
onready var attachment_point = $Robit_11/Pawn_11_Body/Pawn_11_Part_Head/Attachment_Point

var player = 0
var play_type = 2
var start_equiped = false
var armor = 1

var my_gun
var my_start_gun
var take_ammo = false
var shoot_spot = 3

var vel = Vector2()
var grav = 9
var terminal_vel = 6

var max_x_speed = 220
var current_x_speed = 0
#-------------------------------------------------------------------JUMP--------
var is_jump_pressed = false
var max_air_jump_count = 1
var max_air_jump_power = 6
var min_air_jump_power = 1.5
var air_jump_count = 0
var max_jump_power = 6.25
var min_jump_power = 1.5
var head_room = 0
var last_vel = 0.0

var move_step = 0
var dec_step = 0

#--------------------------------------------------------------------NRG--------
var nrg_max = 200
var nrg = 200
var last_nrg = 200
var nrg_regen_rate = 10
var nrg_regen_max = 60
var nrg_default_regen_rate = 10
var nrg_default_regen_max = 60
var light_on_nrg = 20

var can_move = true
var is_right = true
var is_down = false
var on_floor = false
var not_on_angle = false

var is_shield_up = false
var speed_power_up = 1
var is_speed_up = false
var jump_power_up = 1
var is_jump_up = false

var new_anim = "Right-Run"
var last_anim = "Right-Run"

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
var hit_last_by = -1

signal explode_p

func init(_player_num, _pos, _start_equiped, _play_type):
	player = _player_num
	attachment_point.set_player(_player_num)
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
			pass
#			light.off()
		nrg = clamp(nrg + (nrg_regen_rate * delta), 0, 100)
	if nrg != last_nrg:
		nrg_update()
		last_nrg = nrg
	if my_gun != null:
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
	var movement = Vector2(0 , ((vel.y + (grav * int(!on_floor)) * delta) + head_room) * int(!on_ladder))# + (map_movement * delta)
	vel = movement
	if on_floor:
		vel.y = vel.y / 1.1
	if vel.y > terminal_vel:
		vel.y = terminal_vel
	var _2 = move_and_collide(vel)
	rocket_test(vel.y)

##-------------------------------------------------------------------[Move/jump]
func move_x(_moving, _right):
	if can_move:
		if on_floor:
			if _moving:
				if is_down:
					if _right:
						current_x_speed += max_x_speed /10 * speed_power_up / 3 #* delta
					else:
						current_x_speed += -max_x_speed /10 * speed_power_up / 3 #* delta
					current_x_speed = clamp(current_x_speed, -max_x_speed / 4 , max_x_speed / 4)
				else:
					if _right:
						current_x_speed += max_x_speed / 5 * speed_power_up #* delta
					else:
						current_x_speed += -max_x_speed / 5 * speed_power_up #* delta
			else:
				if current_x_speed < 2 && current_x_speed > -2 || on_ladder:
					current_x_speed = 0
				else:
					current_x_speed -= current_x_speed / 2
		else:
			if _moving:
				if is_down:
					if _right:
						current_x_speed += max_x_speed /50 * speed_power_up / 3 #* delta
					else:
						current_x_speed += -max_x_speed /50 * speed_power_up / 3 #* delta
					current_x_speed = clamp(current_x_speed, -max_x_speed / 4 , max_x_speed / 4)
				else:
					if _right:
						current_x_speed += max_x_speed / 35 * speed_power_up #* delta
					else:
						current_x_speed += -max_x_speed / 35 * speed_power_up #* delta
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

##-------------------------------------------------------------[jump]

func jump(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if down_input && on_floor && ray_plat.is_colliding():
				SFX.play("Move_Jump_08")
				vel.y += 1.5
				self.position.y += 3

func jump_j(down_input, _left_input, _right_input):
	if can_move:
		if is_down:
			if down_input && on_floor && ray_plat.is_colliding():
				SFX.play("Move_Jump_08")
				vel.y += 1.5
				self.position.y += 3
		else:
			if !is_jump_pressed && on_floor:# && !down_input:
				SFX.play("Move_Jump_01")
				vel.y = -max_jump_power * jump_power_up
			elif !is_jump_pressed && !on_floor && max_air_jump_count > air_jump_count:# && nrg >= 20:
				SFX.play("Move_Jump_05")
				vel.y = -max_air_jump_power * jump_power_up
				air_jump_count += 1
			is_jump_pressed = true
			on_ladder = false

func jump_rel():
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

func rocket_test(_vel_y):
	if _vel_y < 0.0 && !rockets.on:
		rockets.flame_up()
	elif _vel_y > 0.0 && rockets.on:
		rockets.flame_down()

##------------------------------------------------------------[Shoot]
func shoot_j():
	if my_gun != null:
		my_gun.shoot_pos = shoot_spot
		my_gun.is_right = is_right
		my_gun.shoot_j()
	elif my_start_gun && start_equiped:
		my_start_gun.shoot_pos = shoot_spot
		my_start_gun.is_right = is_right
		my_start_gun.shoot_j()
func shoot():
	if my_gun != null:
		my_gun.shoot_pos = shoot_spot
		my_gun.is_right = is_right
		my_gun.shoot()
	elif my_start_gun && start_equiped:
		my_start_gun.shoot_pos = shoot_spot
		my_start_gun.is_right = is_right
		my_start_gun.shoot()
func shoot_r():
	if my_gun != null:
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
			if my_gun != null:
				my_gun.drop()
		else:
			SFX.play("Blip_06")
			if my_gun != null:
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
		if my_gun != null:
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
	g.position = Vector2(0,0)
	take_ammo = g.take_ammo
	my_gun = g
	is_holding = true

func equip_start_weap():
	var g = Equipment.get_weap_hold(0).instance()
	gun_pos.add_child(g)
	g.init(false, player, 0, false)
	start_equiped = true
	my_start_gun = g
	if is_holding:
		my_start_gun.visible = false

func remove_start_weap():
	print(gun_pos.get_child_count())
	no_gun()
	start_equiped = false
	my_start_gun = null
	for i in gun_pos.get_child_count():
		gun_pos.get_child(i).call_deferred("free")
##-------------------------------------------------------------------------[HIT]
# func hit(_by_who, _by_what, _damage_type, _damage):
# 	_im_hit = true
# 	_hit_time += 0.11
# 	if play_type == 1:
# 		if is_shield_up:
# 			print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
# 		else:
# 			is_shield_up = true
# 			print("ive been hit. I'm player ",player)
# 			let_go()
# 			emit_signal("explode_p", player, self.position, _by_who, _by_what)
# 			call_deferred("free")
# 	elif play_type > 1:
# 		key.shield_up()
# 		head.shield_up()
# 		trax.shield_up()
# 		shield_sprite.visible = true
# 		shield_hit_timer.start()
# 		if !is_shield_up:
# 			nrg = nrg - (_damage - armor)
# 			nrg_update()
# 			if nrg <= 0:
# 				is_shield_up = true
# 				print("ive been hit. I'm player ",player)
# 				let_go()
# 				emit_signal("explode_p", player, self.position, _by_who, _by_what)
# 				call_deferred("free")
# 			elif nrg < light_on_nrg:
# 				pass
# 			else:
# 				pass
func hit(_by_who, _by_what, _damage_type, _damage):
	if _by_who > 0:
		hit_last_by = _by_who
		last_hit_timer.start()
	_im_hit = true
	_hit_time += 0.11
	if play_type == 1:
		if is_shield_up:
			print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
		else:
			is_shield_up = true
			print("ive been hit. I'm player ",player)
			let_go()
			emit_signal("explode_p", player, self.position, hit_last_by, _by_what)
			call_deferred("free")
	elif play_type > 1:
		if !is_shield_up:
			shield_up()
			shield_hit_timer.start()
			nrg = nrg - (_damage - armor)
			nrg_update()
			if nrg <= 0:
				is_shield_up = true
				print("ive been hit. I'm player ",player)
				let_go()
				emit_signal("explode_p", player, self.position, hit_last_by, _by_what)
				call_deferred("free")

func change_pos(_pos):
	self.position = _pos

func nrg_update():
	Player_Stats.nrg_update(player, nrg, nrg_max)

##--------------------------------------------------------------------[Power Up]

func put_shield_up(_how_long):
	is_shield_up = true
	shield_up()
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

func balloon_on():
	grav -= 2
	max_jump_power += 2
	min_jump_power += 2

func balloon_off():
	grav +=2
	max_jump_power -= 2
	min_jump_power -= 2
	
func shield_up():
	key.shield_up()
	head.shield_up()
	trax.shield_up()
	shield_sprite.visible = true

func _body(_num: int):
	call_deferred("_body_",_num)
func _body_(_num: int):
	if _num == 1:
		body_shape_01.disabled = false
		body_shape_02.disabled = true
#		body_shape_03.disabled = true
#		body_shape_04.disabled = true
	elif _num == 2:
		body_shape_01.disabled = true
		body_shape_02.disabled = false
#		body_shape_03.disabled = true
#		body_shape_04.disabled = true
	else:
		print("pawn 11 ERROR : bad body number")

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
	else :
		on_floor = false

##----------------------------------------------------------------[Stun / Knock]
func stun(_gun_num):
	stun_timer.start()
	can_move = false
	on_ladder = false
	_anim_stun()
	let_go()

func knock_dir(_amount, _time, _dir, _is_right):
	knockback_timer.wait_time = _time
	knockback_timer.start()
	if _is_right:
		if _dir == 1:
			knocked_back = Vector2(-(_amount * .1), (_amount * .9))
		if _dir == 2:
			knocked_back = Vector2(-(_amount * .5), (_amount * .5))
		if _dir == 3 ||shoot_spot == 6:
			knocked_back = Vector2(-(_amount * .95), (_amount * .05))
		if _dir == 4:
			knocked_back = Vector2(-(_amount * .5), -(_amount * .5))
		if _dir == 5:
			knocked_back = Vector2(-(_amount * .1), -(_amount * .9))
	else:
		if _dir == 1:
			knocked_back = Vector2((_amount * .1), (_amount * .9))
		if _dir == 2:
			knocked_back = Vector2((_amount * .5), (_amount * .5))
		if _dir == 3 ||_dir == 6:
			knocked_back = Vector2((_amount * .95), (_amount * .05))
		if _dir == 4:
			knocked_back = Vector2((_amount * .5), -(_amount * .5))
		if _dir == 5:
			knocked_back = Vector2((_amount * .1), -(_amount * .9))

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
		if my_gun != null:
			my_gun.add_ammo(_ammo)

##-------------------------------------------------------------------[Animation]

func anim_update(left_input, right_input, up_input, down_input, _jump_input, hold_input, delta):
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

	if on_ladder && !up_input && !down_input:
		if is_right:
			_anim_ladder_right()
		else:
			_anim_ladder_left()

func _anim_idle():
	_body(1)
	head.play("Idle")
	trax.stop()
	key.stop()
	if is_right:
		new_anim = "Right-Idle"
#		head.right()
	else:
		new_anim = "Left-Idle"

func _anim_run():
	_body(1)
	head.play("Idle")
	if is_right:
		new_anim = "Right-Run"
		trax.turn(true)
		key.turn(true)
	else:
		new_anim = "Left-Run"
		trax.turn(false)
		key.turn(false)

func _anim_jump():
	_body(1)
	head.play("Idle")
	if is_right:
		new_anim = "Right-Idle"
		trax.stop()
#		trax.turn(true)
		key.turn(true)
	else:
		new_anim = "Left-Idle"
		trax.stop()
#		trax.turn(false)
		key.turn(false)

func _anim_prone_idle():
	_body(2)
	head.play("Idle")
	trax.stop()
	key.stop()
	if is_right:
		new_anim = "Right-Prone-Crawl"
	else:
		new_anim = "Left-Prone-Crawl"

func _anim_prone_crawl():
	_body(2)
	head.play("Idle")
	if is_right:
		new_anim = "Right-Prone-Crawl"
		trax.turn(true)
		key.turn(true)
	else:
		new_anim = "Left-Prone-Crawl"
		trax.turn(false)
		key.turn(false)

func _anim_stun():
	_body(1)
	head.play("Stun")
	if is_right:
		new_anim = "Right-Stun"
	else:
		new_anim = "Left-Stun"

func _anim_Knock():
	_body(1)
	head.play("Idle")
	if is_right:
		new_anim = "Right-Knock_Back"
	else:
		new_anim = "Left-Knock_Back"

func _anim_ladder_move():
	_body(1)
	head.play("Idle")
	new_anim = "Ladder-Move"
	trax.ladder()
	key.ladder()
#	head.up()

func _anim_ladder_right():
	_body(1)
	head.play("Idle")
	new_anim = "Ladder-Right"
	trax.ladder()
	key.ladder()

func _anim_ladder_left():
	_body(1)
	head.play("Idle")
	new_anim = "Ladder-Left"
	trax.ladder()
	key.ladder()

func _set_gun_dir():
	arm.is_right(is_right)
	head.is_right(is_right)
	if is_right:
		if shoot_spot == 3:
			head.rotation_degrees = 0
			body_sprite.rotation_degrees = 0
			arm.rotation_degrees = 0
			arm.bend(2)
		elif shoot_spot == 1:
			head.rotation_degrees = -10
			body_sprite.rotation_degrees = -42
			arm.rotation_degrees = -40#head.rotation_degrees
			arm.bend(1)
		elif shoot_spot == 2:
			head.rotation_degrees = -7
			body_sprite.rotation_degrees = -22
			arm.rotation_degrees = -23#head.rotation_degrees
			arm.bend(1)
		elif shoot_spot == 4:
			head.rotation_degrees = 9
			body_sprite.rotation_degrees = 17
			arm.rotation_degrees = 18#head.rotation_degrees
			arm.bend(2)
		elif shoot_spot == 5:
			head.rotation_degrees = 21
			body_sprite.rotation_degrees = 42
			arm.rotation_degrees = 43#head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 6:
			head.rotation_degrees = -90
			body_sprite.rotation_degrees = 90
			arm.rotation_degrees = -30
			arm.bend(1)
		if my_gun != null:
			arm.rotation_degrees -= my_gun.walk
	else:
		if shoot_spot == 3:
			head.rotation_degrees = 0
			body_sprite.rotation_degrees = 0
			arm.rotation_degrees = 0#head.rotation_degrees
			arm.bend(2)
		elif shoot_spot == 1:
			head.rotation_degrees = 10
			body_sprite.rotation_degrees = 42
			arm.rotation_degrees = 43 #head.rotation_degrees
			arm.bend(1)
		elif shoot_spot == 2:
			head.rotation_degrees = 7
			body_sprite.rotation_degrees = 22
			arm.rotation_degrees = 23#head.rotation_degrees
			arm.bend(1)
		elif shoot_spot == 4:
			head.rotation_degrees = -9
			body_sprite.rotation_degrees = -17
			arm.rotation_degrees = -18#head.rotation_degrees
			arm.bend(2)
		elif shoot_spot == 5:
			head.rotation_degrees = -21
			body_sprite.rotation_degrees = -42
			arm.rotation_degrees = -43#head.rotation_degrees
			arm.bend(3)
		elif shoot_spot == 6:
			head.rotation_degrees = 90
			body_sprite.rotation_degrees = -90
			arm.rotation_degrees = 30
			arm.bend(1)
		if my_gun != null:
			arm.rotation_degrees += my_gun.walk


##-----------------------------------------------------------------------[Color]
func _set_color():
	_pri_color = Player_Stats.get_body_color(player)
	_sec_color = Player_Stats.get_sec_color(player)
	_set_new_color(_pri_color,_sec_color)

func _set_new_color(_pri, _sec):
	arm.color(_pri, _sec)
	key.color(_pri, _sec)
	trax.color(_pri, _sec)
	head.color(_pri, _sec)
	body_sprite.self_modulate = _pri

##--------------------------------------------------------------------[Time Out]

func shielduptimer():
	shield_sprite.visible = false
	is_shield_up = false

func shieldhittimer():
	key.shield_down()
	head.shield_down()
	trax.shield_down()
	shield_sprite.visible = false
	is_shield_up = false

func speedtimer():
	is_speed_up = false
	speed_power_up = 1

func jumpuptimer():
	is_jump_up = false
	jump_power_up = 1

func nrguptimer():
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max

func stuntimer():
	can_move = true

func knockbacktimer():
	knocked_back = Vector2(0, 0)

func jumptimer():
	print("jump timer timed out dont know why in pawn 11 player stats says its pawn ",Player_Stats.get_pawn_num(player))

func hitbytimer():
	hit_last_by = -1

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
