extends KinematicBody2D

onready var player_indicator = $Pawn_Part_Player_Indicator
onready var timers = $Timers
var attachment_point

var player = 1
var play_type = 2
var start_equiped = false
var armor = 1

var wep_array = []
var my_gun
var my_start_gun
var gun_pos
var take_ammo = false
var shoot_spot = 3
var is_holding = false
var poss_pick_obj


var is_right = true
var is_down = false
var on_floor = false
var ready_show_player_ind = false

var vel = Vector2()
var grav = 0
var terminal_vel = 5
var max_x_speed = 0
var current_x_speed = 0
var can_move = true
var moving = false

#-------------------------------------------------------------------JUMP--------
var is_jump_pressed: = false
var can_jump = true
var max_air_jump_count = 0
var max_air_jump_power = 0
var min_air_jump_power = 0
var air_jump_count = 0
var max_jump_power = 0
var min_jump_power = 0
var head_room = 0

##------------------------------------------------------[NRG]-------------------
var nrg_max = 10
var nrg = 10
var last_nrg = 10
var nrg_regen_rate = 0
var nrg_regen_max = 0
var nrg_default_regen_rate = 0
var nrg_default_regen_max = 0
var light_on_nrg = 0

##----------------------------------------------------[Power Ups]---------------
var is_shield_up = false
var is_speed_up = false
var speed_power_up = 1
var is_jump_up = false
var jump_power_up = 1
var knocked_back = Vector2(0, 0)
var default_power_up_time = 10

##---------------------------------------------------------------HIT------------
var _pri_color = Color8(255, 255, 255, 255)
var _sec_color = Color8(255, 255, 255, 255)
var _im_hit = false
var _hit_time = 0.0
var _hit_color_01 = Color8(255, 255, 255, 255)
var _hit_color_02 = Color8(255, 106, 0, 130)
var hit_last_by = -1

var anim
var new_anim = "Right-Run"
var last_anim = "Right-Run"

signal explode_p

func _ready(): pass

func init(_player_num, _pos, _start_equiped, _play_type):
	player = _player_num
	set_collision(_player_num)
	attachment_point.set_player(_player_num)
	play_type = _play_type
	_set_color()
	start_equiped = _start_equiped
	if start_equiped:
		equip_start_weap()
	change_pos(_pos)
	nrg_update()
	shield_down()
	player_indicator.start(_player_num)
	var test1 = Map_Hand.connect("wow", self, "wow")
	if test1 != 0:
		print_debug("error Singleton Map Handler connecting to pawn in pawn 00 gd")

func _process(delta):
	_is_on_floor()
	_test_headroom()
	if on_floor:
		air_jump_count = 0
	if new_anim != last_anim:
		anim.play(new_anim)
		last_anim = new_anim
	if nrg < nrg_regen_max:
		if nrg > light_on_nrg:
			print_debug("pawn 00 fix the low nrg in process")
		nrg = clamp(nrg + (nrg_regen_rate * delta), 0, nrg_regen_max)
	if nrg != last_nrg:
		nrg_update()
		last_nrg = nrg
	if my_gun != null:
		my_gun.is_right = is_right
		my_gun.shoot_pos = shoot_spot
	elif start_equiped:
		my_start_gun.is_right = is_right
		my_start_gun.shoot_pos = shoot_spot
	_set_gun_dir()
	if _im_hit && !is_shield_up:
		if _hit_time > 0.1:
			shield_up()
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
			shield_down()

func _physics_process(delta):
	var my_pos = self.global_position
	var x_move = current_x_speed + knocked_back.x
	var _1 = move_and_slide(Vector2(x_move , 0 + knocked_back.y ))
	var movement = Vector2(0, ((vel.y + grav * delta)))
	if x_move == 0:
		moving = false
	else:
		moving = true
	if on_floor:
		movement.y = movement.y / 1.1
	if movement.y > terminal_vel:
		movement.y = terminal_vel
	vel = fix_vel(movement)
	var _2 = move_and_collide(vel)
	if int(self.global_position.x) != int(my_pos.x):
		if on_floor:
			move_on_land_stat(abs(int(self.global_position.x - my_pos.x)))
		else:
			move_in_air_stat(abs(int(self.global_position.x - my_pos.x)))
	if int(self.global_position.y) != int(my_pos.y) && player == 1:
		if int(self.global_position.y) > int(my_pos.y):
			fall_dn_dis_stat(abs(int(self.global_position.y - my_pos.y)))
		elif int(self.global_position.y) < int(my_pos.y):
			jump_up_dis_stat(abs(int(self.global_position.y - my_pos.y)))

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
				if current_x_speed < 2 && current_x_speed:
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
				if current_x_speed < 2 && current_x_speed:
					current_x_speed = 0
				else:
					current_x_speed -= current_x_speed / 20
	else:
		if current_x_speed < 2 && current_x_speed > -2:
			current_x_speed = 0
		else:
			current_x_speed -= current_x_speed / 10
	current_x_speed = clamp(current_x_speed, -max_x_speed , max_x_speed)

func jump(_down_input, _left_input, _right_input): pass

func jump_j(_down_input, _left_input, _right_input): pass

func jump_rel(): pass

func jump_stat(): Player_Stats.add_jump_count(player, 1)

func jump_air_stat(): Player_Stats.add_air_jump_count(player, 1)

func jump_down_stat(): Player_Stats.add_jump_down_count(player, 1)

func jump_ground_sound(): SFX.jump_ground()

func jump_air_sound(): SFX.jump_air()

func jump_down_sound(): SFX.jump_down()

##-------------------------------------------------------------------------[HIT]
func hit(_by_who, _by_what, _damage_type, _damage):
	if _by_who > 0:
		hit_last_by = _by_who
		timers.start_last_hit_by()

		_im_hit = true
		_hit_time += 0.11
		if _damage > nrg:
			dmg_given_stat(_by_who,nrg)
			dmg_taken_stat(nrg)
		else:
			dmg_given_stat(_by_who,_damage)
			dmg_taken_stat(_damage)
		if play_type == 1:
			if is_shield_up:
				print_debug(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
			else:
				is_shield_up = true
				print_debug("ive been hit. I'm player ",player)
				let_go()
				emit_signal("explode_p", player, self.position, hit_last_by, _by_what)
				call_deferred("free")
		elif play_type > 1:
			if !is_shield_up || _by_who == 0:
				nrg = nrg - (_damage - armor)
				nrg_update()
				shield_up()
				timers.start_shield_hit()
				if nrg <= 0:
					is_shield_up = true
					print_debug("ive been hit. I'm player ",player)
					let_go()
					emit_signal("explode_p", player, self.position, hit_last_by, _by_what)
					call_deferred("free")

##-----------------------------------------------------------------------[Shoot]
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

##-----------------------------------------------------------------------[Equip]
func equip_weap(_weap_num, _ammo_pick_up, _time_left, _just_shot):
	var g = Equipment.get_weap_hold(_weap_num).instance()
	gun_pos.add_child(g)
	g.init(_ammo_pick_up, player, _time_left, _just_shot)
	take_ammo = g.take_ammo
	if g != null:
		my_gun = g
		is_holding = true
	if my_start_gun != null:
		print_debug("equip weap calling start gun to visible false")
		my_start_gun.visible = false

func equip_start_weap():
	var g = Equipment.get_weap_hold(1).instance()
	gun_pos.add_child(g)
	g.init(false, player, 0, false)
	start_equiped = true
	my_start_gun = g
	if is_holding:
		print_debug("equip start weap calling start gun to visible false")
		my_start_gun.visible = false

func remove_start_weap():
	print_debug(gun_pos.get_child_count())
	no_gun()
	start_equiped = false
	my_start_gun.call_deferred("queue_free")
	my_start_gun = null

##-----------------------------------------------------------------------[Throw]
func pick_throw( left_input, right_input, up_input, down_input, hold_input):
	if is_holding == true:
		if my_gun != null:
			my_gun.is_right = is_right
			my_gun.shoot_pos = shoot_spot
		take_ammo = false
		is_holding = false
		if !left_input && !right_input && !up_input && !down_input && !hold_input:
			SFX.drop()
			if my_gun != null:
				my_gun.drop()
				drop_stat()
		else:
			SFX.throw()
			if my_gun != null:
				my_gun.throw()
				throw_stat()
		my_gun = null
		if my_start_gun && start_equiped:
			my_start_gun.visible = true
	elif wep_array.size() > 0:
		pick_up()
		if my_start_gun && start_equiped:
			# print_debug("pick throw calling start gun to visible false")
			my_start_gun.visible = false

func let_go():
	if is_holding == true:
		take_ammo = false
		is_holding = false
		if my_gun != null:
			my_gun.drop()
			my_gun = null

func pick_up():
	SFX.pick_up()
	poss_pick_obj = wep_array.front()
	var _time_left = poss_pick_obj.time
	var _ammo_pick_up = poss_pick_obj.ammo
	var _weap_num = poss_pick_obj.gun_num
	var _just_shot = poss_pick_obj.just_shot
	equip_weap(_weap_num,_ammo_pick_up, _time_left, _just_shot)
	poss_pick_obj.call_deferred("queue_free")
	pick_up_stat()
	if my_start_gun:
		print_debug("pick up calling start gun to visible false")
		my_start_gun.visible = false

func no_gun():
	if is_holding == true:
		take_ammo = false
		is_holding = false
		my_gun.call_deferred("free")
		my_gun = null
		if my_start_gun && start_equiped:
			my_start_gun.visible = true

func pick_up_stat(): Player_Stats.add_pick_up_count(player, 1)
	
func throw_stat(): Player_Stats.add_throw_count(player, 1)
	
func drop_stat(): Player_Stats.add_drop_count(player, 1)
	

##-------------------------------------------------------------------[add stuff]
func add_nrg(_nrg): nrg = clamp(nrg + _nrg, 0, nrg_max)
	
func add_ammo(_ammo):
	if take_ammo:
		if my_gun != null:
			my_gun.add_ammo(_ammo)

func change_pos(_pos): self.position = _pos

func nrg_update(): Player_Stats.nrg_update(player, nrg, nrg_max)
	
##----------------------------------------------------------------[Stun / Knock]
func stun(_gun_num):
	timers.start_stun()
	can_move = false
	_anim_stun()
	let_go()

func knock_dir(_amount, _time, _dir, _is_right):
	timers.set_knock_back(_time)
	timers.start_knock_back()
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
	timers.set_knock_back(_time)
	timers.start_knock_back()
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

func wow():
	if on_floor:
		stun(0)
		knock_dir(200,1,5,is_right)


##---------------------------------------------------------[Set collsion layers]
func set_collision(_player):
	set_collision_layer_bit(Player_Stats.get_player_collision_layer(_player) - 1, true)
	set_collision_mask_bit(Player_Stats.get_player_collision_layer(_player) - 1, true)

##-----------------------------------------------------------------------[Color]
func _set_color():
	_pri_color = Player_Stats.get_body_color(player)
	_sec_color = Player_Stats.get_sec_color(player)
	_set_new_color(_pri_color,_sec_color)

func _set_new_color(_pri, _sec):
	pass

##--------------------------------------------------------------------[Power Up]
func put_shield_up(_how_long):
	is_shield_up = true
	shield_up()
	if _how_long <= 0:
		timers.set_shield_up(default_power_up_time)
	else:
		timers.set_shield_up(_how_long)
	timers.start_shield_up()
	shield_up_stat()

func put_speed_up(_how_long):
	is_speed_up = true
	speed_power_up = 2
	max_x_speed *= 2
	timers.set_speed(_how_long)
	timers.start_speed()
	speed_up_stat()

func put_jump_up(_how_long):
	is_jump_up = true
	jump_power_up = 2
	if _how_long <= 0:
		timers.set_jump_up(default_power_up_time)
	else:
		timers.set_jump_up(_how_long)
	timers.start_jump()
	jump_up_stat()

func put_nrg_regen_speed_up(_how_long, _how_fast):
	nrg_regen_rate = _how_fast
	nrg_regen_max = nrg_max
	timers.set_nrg_up(_how_long)
	timers.start_nrg_up()
	nrg_regen_up_stat()

func ammo_box(how_much):
	add_ammo(how_much)
	ammo_box_stat()

func add_battery(how_much): 
	add_nrg(how_much)
	battery_stat()

func add_coin(how_much_nrg):
	add_nrg(how_much_nrg)
	coin_stat()

func add_dot(how_much_nrg):
	add_nrg(how_much_nrg)
	dot_stat()

func add_back_shield():
	var x = Equipment.get_equiped_item(10).instance()
	self.add_child(x)
	back_shield_stat()

func balloon_on():
	grav -= 2
	max_jump_power += 2
	min_jump_power += 2
	balloon_stat()

func balloon_off():
	grav +=2
	max_jump_power -= 2
	min_jump_power -= 2
#------------------------------------------[stats stuff]------------------------------------------------
func coin_stat(): Player_Stats.add_coin_count(player, 1)

func dot_stat(): Player_Stats.add_dot_count(player, 1)

func battery_stat(): Player_Stats.add_battery_count(player, 1)

func ammo_box_stat(): Player_Stats.add_ammo_box_count(player, 1)

func shield_up_stat(): Player_Stats.add_shield_up_count(player, 1)

func speed_up_stat(): Player_Stats.add_speed_up_count(player, 1)

func jump_up_stat(): Player_Stats.add_jump_up_count(player, 1)

func nrg_regen_up_stat(): Player_Stats.add_nrg_regen_count(player, 1)

func balloon_stat(): Player_Stats.add_balloon_count(player, 1)

func back_shield_stat(): Player_Stats.add_back_shield_count(player, 1)


func dmg_taken_stat(amount): Player_Stats.add_dmg_taken(player, amount)

func dmg_given_stat(_player, amount): if _player > 0: Player_Stats.add_dmg_given(_player, amount)


func move_on_land_stat(amount):  Player_Stats.add_ground_distance(player, amount)

func move_in_air_stat(amount): Player_Stats.add_air_distance(player, amount)

func jump_up_dis_stat(amount): Player_Stats.add_jump_up_distance(player, amount)

func fall_dn_dis_stat(amount): Player_Stats.add_drop_dn_distance(player, amount)

##--------------------------------------------------------------------[Time Out]

func shielduptimer():
	shield_down()
	is_shield_up = false

func shieldhittimer(): shield_down()

func speedtimer():
	is_speed_up = false
	speed_power_up = 1
	max_x_speed /= 2

func jumpuptimer():
	is_jump_up = false
	jump_power_up = 1

func nrguptimer():
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max

func stuntimer(): can_move = true

func knockbacktimer(): knocked_back = Vector2(0, 0)

func jumptimer(): print_debug("jump timer timed out dont know why in this pawn player stats says its pawn ",Player_Stats.get_pawn_num(player))

func hitbytimer(): hit_last_by = -1

##------------------------------------------------------[player indicator stuff]
func set_ready_show_player_ind(_ready):
	ready_show_player_ind = _ready

func get_ready_show_player_ind():
	return ready_show_player_ind

func start_ready_show_player_ind():
	timers.start_show_player_ind()

func show_player_ind(_show):
	toggle_pi_stat()
	if _show:
		player_indicator.visible = true
	else:
		player_indicator.visible = false

func get_player_ind_vis(): return player_indicator.visible

func toggle_pi_stat(): Player_Stats.add_toggle_pi_count(player, 1)

##---------------------------------------------------------------[getter]---

func get_player_num(): return player

func get_on_floor(): return on_floor

##-------------------------------------------------------------[The in and outs]

func _on_Pick_Up_Area_body_entered(body):
	if body.get_groups().has("PickUp"):
		wep_array.append(body)

func _on_Pick_Up_Area_body_exited(body):
	if body.get_groups().has("PickUp"):
		wep_array.erase(body)

func killed_by_map(_by_who, _by_what, _damage_type, _damage):
	hit(_by_who, 0, 0, (nrg* 2))#who,what,type,damage

func start_next_level():
	if !my_gun && start_equiped > 0:
		equip_start_weap()

#----------------------------------------[stuff to be replaced in other scripts]--
func shield_up(): pass

func shield_down(): pass

func _test_headroom(): pass

func _is_on_floor(): pass

func _set_gun_dir(): pass

func fix_vel(_vel): return _vel

func set_right(_right): is_right = _right

##-------------------------------------------------------------------[Animation]

func anim_update(left_input, right_input, up_input, down_input, _jump_input, hold_input, _delta):
	if can_move:
		if !down_input && is_down:
			is_down = false
		elif down_input && !is_down && !left_input && !right_input:
			is_down = true

		if hold_input:
			is_down = false
			if vel.x < 1 && vel.x > -1:
				vel.x = 0
			elif vel.x <= -2.0:
				vel.x += 1.5
			elif vel.x >= 2.0:
				vel.x -= 1.5
			if up_input && !down_input && !left_input && !right_input:
				shoot_spot = 1
			elif !up_input && down_input && !left_input && !right_input:
				shoot_spot = 5
			elif !up_input && !down_input && left_input && !right_input:
				shoot_spot = 3
			elif !up_input && !down_input && !left_input && right_input:
				shoot_spot = 3
			elif up_input && !down_input && left_input && !right_input:
				shoot_spot = 2
			elif up_input && !down_input && !left_input && right_input:
				shoot_spot = 2
			elif !up_input && down_input && left_input && !right_input:
				shoot_spot = 4
			elif !up_input && down_input && !left_input && right_input:
				shoot_spot = 4
			_anim_idle()
			# print_debug("001")

		elif !hold_input && on_floor && !is_down:
			if !up_input && !down_input && !left_input && !right_input:
				shoot_spot = 3
				_anim_idle()
			elif up_input && !down_input && !left_input && !right_input:
				shoot_spot = 1
				_anim_idle()
			elif !up_input && !down_input && left_input && !right_input:
				shoot_spot = 3
				_anim_run()
			elif !up_input && !down_input && !left_input && right_input:
				shoot_spot = 3
				_anim_run()
			elif up_input && !down_input && left_input && !right_input:
				shoot_spot = 2
				_anim_run()
			elif up_input && !down_input && !left_input && right_input:
				shoot_spot = 2
				_anim_run()
			elif !up_input && down_input && left_input && !right_input:
				shoot_spot = 4
				_anim_run()
			elif !up_input && down_input && !left_input && right_input:
				shoot_spot = 4
				_anim_run()
			elif !up_input && down_input && left_input && !right_input:
				shoot_spot = 3 
				_anim_idle()
			elif !up_input && down_input && !left_input && right_input:
				shoot_spot = 3 
				_anim_idle()
			# print_debug("002")

		elif on_floor && is_down:
			if !left_input && !right_input || left_input && right_input:
				shoot_spot = 3
				_anim_prone_idle()
			elif left_input && !right_input:
				shoot_spot = 3
				_anim_prone_crawl()
			elif !left_input && right_input:
				shoot_spot = 3
				_anim_prone_crawl()
			else:
				print_debug("error in pawn 00 anim update 001 on floor and is down")
			# print_debug("003")

		elif !on_floor:
			_anim_jump()
			if !up_input && !down_input && !left_input && !right_input:
				shoot_spot = 3
			elif up_input && !down_input && !left_input && !right_input:
				shoot_spot = 1
			elif !up_input && down_input && !left_input && !right_input:
				shoot_spot = 5
			elif !up_input && !down_input && left_input && !right_input:
				shoot_spot = 3
			elif !up_input && !down_input && !left_input && right_input:
				shoot_spot = 3
			elif up_input && !down_input && left_input && !right_input:
				shoot_spot = 2
			elif up_input && !down_input && !left_input && right_input:
				shoot_spot = 2
			elif !up_input && down_input && left_input && !right_input:
				shoot_spot = 4
			elif !up_input && down_input && !left_input && right_input:
				shoot_spot = 4
			# print_debug("004")
		# else:
			# print_debug("005")

func _anim_idle(): pass

func _anim_run(): pass

func _anim_jump(): pass

func _anim_prone_idle(): pass

func _anim_prone_crawl(): pass

func _anim_stun(): pass

func _anim_Knock(): pass
