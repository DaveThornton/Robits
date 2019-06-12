extends KinematicBody2D

export(PackedScene) var gun_02
export(PackedScene) var gun_03
export(PackedScene) var gun_04
export(PackedScene) var gun_05
export(PackedScene) var gun_06
export(PackedScene) var gun_07
export(PackedScene) var gun_08
export(PackedScene) var gun_09
export(PackedScene) var gun_10
export(PackedScene) var gun_20
export(PackedScene) var gun_21
export(PackedScene) var gun_40
export(PackedScene) var gun_60

export var move_speed_time_needed = .15
export var deceleration_time_needed = .25

onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var gun_pos = $"Position2D-Arm-Gun"
onready var shield_timer = $Shield_Timer
onready var speed_timer = $Speed_Timer
onready var nrg_up_timer = $NRG_Up_Timer
onready var stun_timer = $Stun_Timer
onready var ray_up = $RayCast2D_Up
onready var ray_down = $RayCast2D_Down
onready var ray_right = $RayCast2D_Right
onready var ray_left = $RayCast2D_Left

var take_ammo = false
var shoot_spot = 3
var my_gun 
var vel = Vector2()
var grav = 10
var terminal_vel = 15
var walk_speed = 40
var starting_walk_speed
var max_air_jump_count = 3
var max_air_jump_power = 4
var min_air_jump_power = 1.5
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
var can_shoot = true
var is_right = true
var is_jump_pressed = false
var is_down = false
var on_floor = false 
var on_wall = false
#var next_to_player = false
var is_shield_up = false 
var is_speed_up = false
var new_anim = "Right-Run"
var last_anim = "Right-Run"
var is_holding = false
var poss_pick_obj

var wep_array = []

signal explode_p
signal nrg_update(_player, _nrg)

func _ready():
	move_step = walk_speed / move_speed_time_needed
	dec_step = walk_speed / deceleration_time_needed
	starting_walk_speed = walk_speed
	nrg_regen_rate = nrg_default_regen_rate
	nrg_regen_max = nrg_default_regen_max
	self.connect("nrg_update", get_tree().get_current_scene(), "nrg_update")

func init(_player_num, _pos):
	player = _player_num
	if player == 1:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-01.png")
	if player == 2:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-02.png")
	if player == 3:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-03.png")
	if player == 4:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-04.png")
	if player == 5:
		sprite.texture = load("res://Sprites/Pawns/Robit_Pawn-05.png")
	self.position = _pos

func _process(delta):
	on_floor = ray_down.is_colliding()
	_test_wall()
	if on_floor:
		air_jump_count = 0
	if new_anim != last_anim:
		anim.play(new_anim)
		last_anim = new_anim
	move_and_collide(Vector2(vel.x,0))
	if nrg < nrg_regen_max:
		nrg = clamp(nrg + (nrg_regen_rate * delta), 0, 100)
	if nrg != last_nrg:
		nrg_update()
		last_nrg = nrg
	if my_gun:
		my_gun.is_right = is_right
		my_gun.shoot_pos = shoot_spot

func _physics_process(delta):
	var movement = Vector2( 0, (vel.y + grav * delta) + head_room)
	vel = movement
	if on_floor:
		vel.y = vel.y / 1.1
	if vel.y > terminal_vel:
		vel.y = terminal_vel
	move_and_collide(vel)

func move_x(_right, delta):
	if is_down:
		if can_move:
			if _right:
				vel.x += move_step / 3 * delta
			else:
				vel.x -= move_step / 3 * delta
	else:
		if can_move:
			if _right:
				vel.x += move_step * delta
			else:
				vel.x -= move_step * delta

func jump( jump_input, down_input):
	if down_input && on_floor:
		self.position = self.position - Vector2(0,-.25)
	elif !is_jump_pressed && on_floor && !down_input:
		vel.y = -max_jump_power
	elif !is_jump_pressed && !down_input && !on_floor && nrg >= 20:
		vel.y = -max_air_jump_power
		air_jump_count += 1
		nrg -= 20
	is_jump_pressed = true 
		
func jump_rel( jump_input, down_input):
	if air_jump_count!= 0 && vel.y < -min_air_jump_power:
		vel.y = -min_air_jump_power
	elif vel.y < -min_jump_power:
		vel.y = min_jump_power
	is_jump_pressed = false

func shoot():
	if my_gun:
		my_gun.shoot()
		
func shoot_j():
#	print(next_to_player)
	if my_gun:
		my_gun.shoot_j()

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
	var g
	if _wep_num == 2:
		g = gun_02.instance()
		take_ammo = true
	elif _wep_num == 3:
		g = gun_03.instance()
		take_ammo = true
	elif _wep_num == 10:
		g = gun_10.instance()
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
	elif _wep_num == 60:
		g = gun_60.instance()
		take_ammo = false
	gun_pos.add_child(g)
	g.init(_ammo_pick_up, player, _time_left)
	my_gun = g
	is_holding = true 
	poss_pick_obj.queue_free()

func anim_update(left_input, right_input, up_input, down_input, jump_input, hold_input):
	if !down_input:
		is_down = false
	if can_move:
		if !hold_input:
			if !is_down:
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
		shoot_spot = 1

func _test_wall():
	if is_right:
		on_wall = ray_right.is_colliding()
#		if on_wall:
#			next_to_player = ray_right.get_collider().get_groups().has("player")
#			print(on_wall)
	else:
		on_wall = ray_left.is_colliding()
#		if on_wall:
#			next_to_player = ray_left.get_collider().get_groups().has("player")
#			print(on_wall)
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
	if is_shield_up:
		print(_by_who, "'s ", _by_what, " has bounced off of ", player, "'s Shield")
	else:
		print("ive been hit. I'm player ",player)
		let_go()
		emit_signal("explode_p", player, self.position, _by_who, _by_what)
		queue_free()

func killed_by_map(_by_who, _by_what, _damage_type, _damage):
	emit_signal("explode_p", player, self.position, _by_who, _by_what)
	queue_free()

func game_over(_winner):
	print("game_over in player. won by ",_winner)

func put_shield_up(_how_long):
	is_shield_up = true 
	shield_timer.wait_time = _how_long
	shield_timer.start()

func _on_Shield_Timer_timeout():
	is_shield_up = false 

func put_speed_up(_how_long):
	if !is_speed_up:
		walk_speed += 20
		move_step = walk_speed / move_speed_time_needed
		dec_step = walk_speed / deceleration_time_needed
		is_speed_up = true
	speed_timer.wait_time = _how_long
	speed_timer.start()

func _on_Speed_Timer_timeout():
	is_speed_up = false 
	walk_speed = starting_walk_speed
	move_step = walk_speed / move_speed_time_needed
	dec_step = walk_speed / deceleration_time_needed

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

func _on_Grab_Area2D_body_entered(body):
	if body.get_groups().has("PickUp"):
		wep_array.append(body)

func _on_Grab_Area2D_body_exited(body):
	if body.get_groups().has("PickUp"):
		wep_array.erase(body)