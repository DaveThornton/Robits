#func init(_player_num, _pos):
#	player = _player_num
#	if player == 1:
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-01.png")
#	if player == 2:
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-02.png")
#	if player == 3:
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-03.png")
#	if player == 4:
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-04.png")
#	if player == 5:
#		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-05.png")
#	self.position = _pos
#	nrg_update()
extends KinematicBody2D

export(PackedScene) var gun_02
export(PackedScene) var gun_03
export(PackedScene) var gun_04
#export(PackedScene) var gun_05
#export(PackedScene) var gun_06
#export(PackedScene) var gun_07
#export(PackedScene) var gun_08
#export(PackedScene) var gun_09
export(PackedScene) var gun_10
export(PackedScene) var gun_11
export(PackedScene) var gun_20
export(PackedScene) var gun_21
#export(PackedScene) var gun_22
export(PackedScene) var gun_40
export(PackedScene) var gun_50
export(PackedScene) var gun_60
export(PackedScene) var gun_61

export var move_speed_time_needed = .15
export var deceleration_time_needed = .25

onready var sprite = $Sprite
onready var sprite_shield = $Sprite_Shield
onready var anim = $AnimationPlayer
onready var gun_pos = $"Position2D-Arm-Gun"
onready var knockback_timer = $KnockBack_Timer
onready var shield_timer = $Shield_Timer
onready var speed_timer = $Speed_Timer
onready var jump_timer = $Jump_Timer
onready var nrg_up_timer = $NRG_Up_Timer
onready var stun_timer = $Stun_Timer
onready var ray_up = $RayCast2D_Up
onready var ray_down_r = $RayCast2D_Down2
onready var ray_down_l = $RayCast2D_Down
onready var ray_right = $RayCast2D_Right
onready var ray_right_down = $RayCast2D_Right_Down
onready var ray_left_down = $RayCast2D_Left_Down
onready var ray_left = $RayCast2D_Left
onready var ray_down_plat = $RayCast2D

onready var ray_left_melee = $RayCast2D_Left_Melee
onready var ray_right_melee = $RayCast2D_Right_Melee

var take_ammo = false
var shoot_spot = 3
var my_gun 
var vel = Vector2()
var grav = 10
var terminal_vel = 9
var walk_speed = 17500
var speed_power_up = 1
var starting_walk_speed
var max_air_jump_count = 3
var max_air_jump_power = 4
var min_air_jump_power = 1.5
var jump_power_up = 1
var air_jump_count = 0
var max_jump_power = 8
var min_jump_power = 1.5
var move_step = 0
var dec_step = 0
var nrg = 100
var last_nrg = 100
var nrg_regen_rate = 5
var nrg_regen_max = 20
var nrg_default_regen_rate = 5
var nrg_default_regen_max = 20
var head_room = 0
var player = 1
var can_move = true
#var can_shoot = true
var is_right = true
var is_jump_pressed = false
var is_down = false
var on_floor = false 
var on_wall = false
var not_on_angle = false
#var next_to_player = false
var is_shield_up = false 
var is_speed_up = false
var is_jump_up = false
var new_anim = "Right-Run"
var last_anim = "Right-Run"
var is_holding = false
var poss_pick_obj
var knocked_back = Vector2(0, 0)

var wep_array = []

signal explode_p
signal nrg_update(_player, _nrg)

func _ready():
	move_step = walk_speed / move_speed_time_needed
	dec_step = walk_speed / deceleration_time_needed
	starting_walk_speed = walk_speed
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max
	var test = self.connect("nrg_update", get_tree().get_current_scene(), "nrg_update")
	if test != 0:
		print("error Robit 01 connecting nrg update")

func init(_player_num, _pos):
	player = _player_num
	if player == 1:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-01.png")
	if player == 2:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-02.png")
	if player == 3:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-03.png")
	if player == 4:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-04.png")
	if player == 5:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02-05.png")
	self.position = _pos
	nrg_update()

func _process(delta):
	_is_on_floor()
	_test_wall()
	if on_floor:
		air_jump_count = 0
	if new_anim != last_anim:
		anim.play(new_anim)
		last_anim = new_anim
#	move_and_slide(Vector2(vel.x + knocked_back.x, 0 + knocked_back.y))
	if nrg < nrg_regen_max:
		nrg = clamp(nrg + (nrg_regen_rate * delta), 0, 100)
	if nrg != last_nrg:
		nrg_update()
		last_nrg = nrg
	if my_gun:
		my_gun.is_right = is_right
		my_gun.shoot_pos = shoot_spot
#warning-ignore:return_value_discarded
	move_and_slide(Vector2(vel.x + knocked_back.x, 0 + knocked_back.y))
#	if ptest1 != 0:
#		print("error in robit 02  _process move and slide")


func _physics_process(delta):
	var movement = Vector2(0 , (vel.y + (grav * int(!on_floor)) * delta) + head_room)
	vel = movement
	if on_floor:
		vel.y = vel.y / 1.1
	if vel.y > terminal_vel:
		vel.y = terminal_vel
#warning-ignore:return_value_discarded
	move_and_collide(vel)
#	if pptest1 != 0:
#		print("error in move and collide robit 02 physics process")

func move_x(_moving, _right, delta):
	if _moving:
		if is_down:
			if can_move:
				if _right:
					vel.x = walk_speed * speed_power_up / 3 * delta
				else:
					vel.x = -walk_speed * speed_power_up / 3 * delta
		else:
			if can_move:
				if _right:
					vel.x = walk_speed * speed_power_up * delta
				else:
					vel.x = -walk_speed * speed_power_up * delta
	else:
		vel.x = 0

func jump(down_input):
	if down_input && on_floor:
		vel.y += 1.5
		set_collision_mask_bit(2, false)
	elif !is_jump_pressed && on_floor && !down_input:
		vel.y = -max_jump_power * jump_power_up
	elif !is_jump_pressed && !down_input && !on_floor && max_air_jump_count > air_jump_count:# && nrg >= 20:
		vel.y = -max_air_jump_power * jump_power_up
		air_jump_count += 1
	is_jump_pressed = true 
	
func jump_rel():
	set_collision_mask_bit(2, true)
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

func shoot_j():
	if my_gun:
		var _melee = false
		if is_right:
			if ray_right_melee.is_colliding():
				my_gun.melee()
				_melee = true
		else:
			if ray_left_melee.is_colliding():
				my_gun.melee()
				_melee = true
		if !_melee:
			my_gun.shoot_j()

func shoot():
	if my_gun:
		var _melee = false
		if is_right:
			if ray_right_melee.is_colliding():
				my_gun.melee()
				_melee = true
		else:
			if ray_left_melee.is_colliding():
				my_gun.melee()
				_melee = true
		if !_melee:
			my_gun.shoot()

func shoot_r():
	if my_gun:
		my_gun.shoot_r()

func pick_throw( left_input, right_input, up_input, down_input, hold_input):
	if is_holding == true:
		take_ammo = false
		is_holding = false 
		if !left_input && !right_input && !up_input && !down_input && !hold_input:
			my_gun.drop()
		else:
			my_gun.throw()
		my_gun = null
	elif wep_array.size() > 0: 
		pick_up()

func let_go():
	if is_holding == true:
		take_ammo = false
		is_holding = false 
		my_gun.drop()
		my_gun = null

func pick_up():
	poss_pick_obj = wep_array.front()
	var _time_left = poss_pick_obj.time
	var _ammo_pick_up = poss_pick_obj.ammo
	var _wep_num = poss_pick_obj.gun_num
	var _just_shot = false
	var g
	if _wep_num == 2:
		g = gun_02.instance()
		take_ammo = true
	elif _wep_num == 3:
		g = gun_03.instance()
		take_ammo = true
	elif _wep_num == 4:
		g = gun_04.instance()
		take_ammo = true
	elif _wep_num == 10:
		g = gun_10.instance()
		take_ammo = true
	elif _wep_num == 11:
		g = gun_11.instance()
		take_ammo = true
	elif _wep_num == 20:
		g = gun_20.instance()
		take_ammo = false
	elif _wep_num == 21:
		g = gun_21.instance()
		take_ammo = false
	elif _wep_num == 40:
		g = gun_40.instance()
		take_ammo = true
	elif _wep_num == 50:
		g = gun_50.instance()
		take_ammo = true
		g.just_shot = poss_pick_obj.just_shot
	elif _wep_num == 60:
		g = gun_60.instance()
		take_ammo = false
	elif _wep_num == 61:
		g = gun_61.instance()
		take_ammo = false
	gun_pos.add_child(g)
	g.init(_ammo_pick_up, player, _time_left)
	my_gun = g
	is_holding = true 
	poss_pick_obj.queue_free()

#warning-ignore:unused_argument
func anim_update(left_input, right_input, up_input, down_input, jump_input, hold_input):
	if !down_input:
		is_down = false
	if can_move:
		if !hold_input:
			if !is_down:
				ray_down_plat.enabled = true
				if right_input && !left_input:
					new_anim = "Right-Run"
					if !up_input && !down_input:
						shoot_spot = 3
					elif up_input:
						shoot_spot = 2
					elif down_input:
						shoot_spot = 4
					else:
						print("error anim 01")
				elif !right_input && left_input:
					new_anim = "Left-Run"
					if !up_input && !down_input:
						shoot_spot = 3
					elif up_input:
						shoot_spot = 2
					elif down_input:
						shoot_spot = 4
					else:
						print("error anim 02")
				elif up_input:
					shoot_spot = 1
					if is_right:
						if on_floor:
							new_anim = "Right-Idle"
						else:
							new_anim = "Right-Jump"
					else:
						if on_floor:
							new_anim = "Left-Idle"
						else:
							new_anim = "Left-Jump"
				elif down_input:
					if on_floor:
						is_down = true 
						shoot_spot = 6
						if is_right:
							new_anim = "Right-Prone-Crawl"
						else:
							new_anim = "Left-Prone-Crawl"
					else:
						shoot_spot = 5
						if is_right:
							new_anim = "Right-Jump"
						else:
							new_anim = "Left-Jump"
				elif !left_input && !right_input:
					shoot_spot = 3
					if on_floor:
						if is_right:
							new_anim = "Right-Idle"
						else:
							new_anim = "Left-Idle"
					if !on_floor:
						if is_right:
							new_anim = "Right-Jump"
						else:
							new_anim = "Left-Jump"
					elif down_input:
						if on_floor:
							is_down = true 
							shoot_spot = 6
							if is_right:
								new_anim = "Right-Prone-Crawl"
							else:
								new_anim = "Left-Prone-Crawl"
						else:
							shoot_spot = 5
							if is_right:
								new_anim = "Right-Jump"
							else:
								new_anim = "Left-Jump"
			else:
				ray_down_plat.enabled = false
				if is_right:
					new_anim = "Right-Prone-Crawl"
				else:
					new_anim = "Left-Prone-Crawl"
		else:
			if is_right:
				new_anim = "Right-Idle"
			else:
				new_anim = "Left-Idle"
		
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

	if on_wall:
		if !not_on_angle:
			if shoot_spot == 3:
				shoot_spot = 2
		else:
			shoot_spot = 1

func _test_wall():
	var _obj
	if is_right:
		on_wall = ray_right.is_colliding()
		_obj = ray_right.get_collider()
		if on_wall:
			if _obj:
				on_wall = !_obj.get_groups().has("player")
			not_on_angle = ray_right_down.is_colliding()
	else:
		on_wall = ray_left.is_colliding()
		_obj = ray_left.get_collider()
		if on_wall:
			if _obj:
				on_wall = !_obj.get_groups().has("player")
			not_on_angle = ray_left_down.is_colliding()
	
	if ray_up.is_colliding():
		head_room = 1
	else:
		head_room = 0

func nrg_update():
	emit_signal("nrg_update", player, nrg)
	
func add_nrg(_nrg):
	nrg = clamp(nrg + _nrg, 0, 100)

func add_ammo(_ammo):
	if take_ammo:
		if my_gun:
			my_gun.add_ammo(_ammo)

func stun(_gun_num):
	print("stunned")
	stun_timer.start()
	can_move = false
	if is_right:
		new_anim = "Right-Stun"
	else:
		new_anim = "Left-Stun"
	let_go()

func hit(_by_who, _by_what, _damage_type, _damage):
	var _play_type = 1
	if _play_type == 1:
		if is_shield_up:
			print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
		else:
			is_shield_up = true
			print("ive been hit. I'm player ",player)
			let_go()
			emit_signal("explode_p", player, self.position, _by_who, _by_what)
			queue_free()
	else:
		nrg = nrg - _damage
		nrg_update()
		print(nrg)
		if nrg <= 0:
			if is_shield_up:
				print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
			else:
				is_shield_up = true
				print("ive been hit. I'm player ",player)
				let_go()
				emit_signal("explode_p", player, self.position, _by_who, _by_what)
				queue_free()

func knock_back(_amount, _time):
#	print("knock back ", _amount, " for ", _time, " seconds")
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

func killed_by_map(_by_who, _by_what, _damage_type, _damage):
	emit_signal("explode_p", player, self.position, _by_who, _by_what)
	queue_free()

func game_over(_winner):
	print("game_over in player. won by ",_winner)

func put_shield_up(_how_long):
	is_shield_up = true 
	sprite_shield.visible = true
	if _how_long <= 0:
		shield_timer.wait_time = 10
	else:
		shield_timer.wait_time = _how_long
	shield_timer.start()

func _on_Shield_Timer_timeout():
	sprite_shield.visible = false
	is_shield_up = false 

func put_speed_up(_how_long):
#	if !is_speed_up:
	is_speed_up = true
	speed_power_up = 2
#		walk_speed += 20
#		move_step = walk_speed / move_speed_time_needed
#		dec_step = walk_speed / deceleration_time_needed
#		is_speed_up = true
	speed_timer.wait_time = _how_long
	speed_timer.start()

func _on_Speed_Timer_timeout():
	is_speed_up = false 
	speed_power_up = 1
#	walk_speed = starting_walk_speed
#	move_step = walk_speed / move_speed_time_needed
#	dec_step = walk_speed / deceleration_time_needed

func put_jump_up(_how_long):
	is_jump_up = true 
	jump_power_up = 2
	if _how_long <= 0:
		jump_timer.wait_time = 10
	else:
		jump_timer.wait_time = _how_long
	jump_timer.start()

func _on_Jump_Timer_timeout():
	is_jump_up = false
	jump_power_up = 1

func put_nrg_regen_speed_up(_how_long, _how_fast, _how_much):
	nrg_regen_rate = _how_fast
	nrg_regen_max = _how_much
	nrg_up_timer.wait_time = _how_long
	nrg_up_timer.start()
	
func _on_NRG_Up_Timer_timeout():
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max

func _on_Stun_Timer_timeout():
	can_move = true

func _on_KnockBack_Timer_timeout():
	knocked_back = Vector2(0, 0)

func _on_Grab_Area2D_body_entered(body):
	if body.get_groups().has("PickUp"):
		wep_array.append(body)

func _on_Grab_Area2D_body_exited(body):
	if body.get_groups().has("PickUp"):
		wep_array.erase(body)
		
func _is_on_floor():
	if ray_down_r.is_colliding() || ray_down_l.is_colliding():
		on_floor = true
	else :
		on_floor = false
	if ray_down_plat.is_colliding():
		position.y += -14