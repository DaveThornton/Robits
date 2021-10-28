extends KinematicBody2D

export(PackedScene) var projectile
# export(PackedScene) var explode
export var armor = 0
export var active = true
export var active_number = 1
export var find_all = false
export var points = 3

onready var anim = $AnimationPlayer3
onready var sprite = $Sprite
onready var cast_down = $Casts/RayCast2D_Down 
#onready var sfx = $SFX_Lib
onready var shoot_timer = $Timer_Shoot

onready var s_pos_up_l = $"Casts/Shoot_Casts/Shoot-Up-Left-Pos"
onready var s_pos_up_r = $"Casts/Shoot_Casts/Shoot-Up-Right-Pos"
onready var s_pos_down_l = $"Casts/Shoot_Casts/Shoot-Down-Left-Pos"
onready var s_pos_down_r = $"Casts/Shoot_Casts/Shoot-Down-Right-Pos"
onready var s_pos_left = $"Casts/Shoot_Casts/Shoot-Left-Pos"
onready var s_pos_right = $"Casts/Shoot_Casts/Shoot-Right-Pos"
onready var s_pos_left_u = $"Casts/Shoot_Casts/Shoot-Left-Up-Pos"
onready var s_pos_right_u = $"Casts/Shoot_Casts/Shoot-Right-Up-Pos"
onready var s_pos_left_d = $"Casts/Shoot_Casts/Shoot-Left-Down-Pos"
onready var s_pos_right_d= $"Casts/Shoot_Casts/Shoot-Right-Down-Pos"

onready var cast_shoot_right = $"Casts/Shoot_Casts/Shoot-Right-RayCast2D"
onready var cast_shoot_left = $"Casts/Shoot_Casts/Shoot-Left-RayCast2D"
onready var cast_shoot_up = $"Casts/Shoot_Casts/Shoot-Up-RayCast2D"
onready var cast_shoot_down = $"Casts/Shoot_Casts/Shoot-Down-RayCast2D"
onready var cast_shoot_left_up = $"Casts/Shoot_Casts/Shoot-LeftUp-RayCast2D"
onready var cast_shoot_right_up = $"Casts/Shoot_Casts/Shoot-RightUp-RayCast2D"
onready var cast_shoot_left_down = $"Casts/Shoot_Casts/Shoot-LeftDown-RayCast2D"
onready var cast_shoot_right_down = $"Casts/Shoot_Casts/Shoot-RightDown-RayCast2D"

#onready var cast_bg_right_top = $"Casts/BG_Casts/RayCast2D-Right_Top"
#onready var cast_bg_right_bot = $"Casts/BG_Casts/RayCast2D-Right_Bot"
#onready var cast_bg_left_top = $"Casts/BG_Casts/RayCast2D-Left_Top"
#onready var cast_bg_left_bot = $"Casts/BG_Casts/RayCast2D-Left_Bot"
#onready var cast_bg_up = $"Casts/BG_Casts/RayCast2D-Up"
#onready var cast_bg_down = $"Casts/BG_Casts/RayCast2D-Down"

var path : = PoolVector2Array() setget set_path
var nav_system
var damage = 20
var last_anim = "Idle-Mid"
var last_pos : = Vector2()
var speed : = 60.0
var current_speed_x = 0.0
var current_speed_y = 0.0
#var started = false
var on_floor = false
var on_ladder = false
var up_ladder  = false
var over_ladder = false
var ladder_count = 0
var can_shoot = true
var is_right = true
var health = 50
var player = -1
var can_move = false
var time_to_check = .5
var current_time_to_check = 0
var hunted = []
var hunted_all = []

func _ready():
	last_pos = self.global_position
	randomize()
	time_to_check = rand_range(.5, .75)

func _process(delta: float) -> void:
#	if on_ladder:
#		if up_ladder == true && cast_bg_up.is_colliding():
#			can_move = false
#			print(can_move)
#		elif up_ladder == true && !cast_bg_up.is_colliding():
#			can_move = true
#			print(can_move)
#		if up_ladder == false && cast_bg_down.is_colliding():
#			can_move = false
#			print(can_move)
#		elif up_ladder == false && !cast_bg_down.is_colliding():
#			can_move = true
#			print(can_move)
#	else:
#		if is_right:
#			if cast_bg_right_top.is_colliding() || cast_bg_right_bot.is_colliding():
#				can_move = false
#				print(can_move)
#			else:
#				can_move = true
#				print(can_move)
#		else:
#			if cast_bg_left_top.is_colliding() || cast_bg_left_bot.is_colliding():
#				can_move = false
#				print(can_move)
#			else:
#				can_move = true
#				print(can_move)
	current_time_to_check += delta
	var shot = _get_shot()
	if shot != 0 && !on_ladder && on_floor:
		if can_shoot:
			can_move = false
			var _shoot_anim = _get_shoot_anim(shot)
			_animation(_shoot_anim)
			var _pos_shot = _change_shoot_pos(shot)
			shoot(_pos_shot)
	else:
		can_move = true
		if !nav_system:
#			if self.get_tree().get_current_scene().map.nav_system:
			if Map_Hand.map.nav_system:
				nav_system = Map_Hand.map.nav_system
				var map = Map_Hand.map
				map.connect("activate", self, "activate")
				print("nav system found ", nav_system)
				nav_system.found_me()
		else:
			if current_time_to_check >= time_to_check:
#				print(path)
#				print(hunted[0].global_position)
				current_time_to_check = 0.0
				if !find_all:
					remove_dead(hunted)
					hunted.sort_custom(self, "sort_distance")
					if hunted.size() > 0:
#						print(hunted[0].global_position)
						nav_system.find_path(self, hunted[0])
					else:
						active = false
				else:
					var g = self.get_tree().get_current_scene().pawns.get_child_count()
#					print(g)
					if g > 0:
						remove_dead(hunted_all)
						hunted_all = null
						hunted_all = []
						for h in g:
							hunted_all.append(self.get_tree().get_current_scene().pawns.get_child(h))
#							print("adding to hunted_all (open gunner - 01)")
						hunted_all.sort_custom(self, "sort_distance")
						nav_system.find_path(self, hunted_all[0])
#						print(hunted_all[0],hunted_all[0].global_position)
					else:
						active = false
	_on_floor()
	_over_ladders()

func _physics_process(delta):
	if can_move:
		var move_distance = speed * delta
		if active:
			move_along_path(move_distance)
# warning-ignore:return_value_discarded
			move_and_slide(Vector2(current_speed_x, current_speed_y))
		
		if last_pos == global_position:
			_animation("Idle-Mid")
		elif int(last_pos.x) != int(global_position.x):
			_animation("Run-Mid")
	#		elif int(last_pos.y) != int(global_position.y):
		elif int(last_pos.y) > int(global_position.y):
			if over_ladder:
				_animation("Ladder-Up")
			else:
				_animation("Jump-Up")
		elif int(last_pos.y) < int(global_position.y):
			if over_ladder:
				_animation("Ladder-Up")
			else:
				_animation("Jump-Down")
	
func move_along_path(distance : float) -> void:
	var start_point : = position
# warning-ignore:unused_variable
	for i in range (path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
#		print(distance_to_next)
		var hor_move = int(self.global_position.x) - int(path[0].x)
		var vert_move = int(self.global_position.y) - int(path[0].y)
		if hor_move < 0:# && !cast_bg_right_top.is_colliding() && !cast_bg_right_bot.is_colliding():
			_go_right(distance)
		elif hor_move > 0:# && !cast_bg_left_top.is_colliding() && !cast_bg_left_bot.is_colliding():
			_go_left(distance)
		elif vert_move > 0:# && !cast_bg_up.is_colliding():
			if over_ladder:
				_go_up_ladder(distance)
			else:
				_go_jump_up(distance)
		elif vert_move < 0:# && !cast_bg_down.is_colliding():#
			if over_ladder:
				_go_down_ladder(distance)
			else:
				_go_jump_down(distance)
		else:
			_go_no_where(distance)

		if distance <= distance_to_next and distance >= 0.0:
			if (distance * distance_to_next) != 0:
				can_move = true
				position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return

func _animation(_current):
	if last_anim != _current:
		anim.play(_current)
		last_anim = _current
	last_pos = global_position

func _get_shoot_anim(_shoot_pos):
	if _shoot_pos == 1:
		return "Shoot-Up"
	elif _shoot_pos == 2:
		is_right = true
		sprite.scale.x = 1
		return "Shoot-Right-Up"
	elif _shoot_pos == 3:
		is_right = true
		sprite.scale.x = 1
		return "Shoot-Right"
	elif _shoot_pos == 4:
		is_right = true
		sprite.scale.x = 1
		return "Shoot-Right-Down"
	elif _shoot_pos == 5:
		return "Shoot-Down"
	elif _shoot_pos == 6:
		is_right = false
		sprite.scale.x = -1
		return "Shoot-Right-Down"
	elif _shoot_pos == 7:
		is_right = false
		sprite.scale.x = -1
		return "Shoot-Right"
	elif _shoot_pos == 8:
		is_right = false
		sprite.scale.x = -1
		return "Shoot-Right-Up"

func shoot(_pos_shoot):
	can_shoot = false 
	var new_projectile = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile)
	var _ss = _pos_shoot.global_position
	var _sr = _pos_shoot.global_rotation
	var _sss = _pos_shoot.scale
	new_projectile.start(_sr , _ss, _sss, player, damage)
	SFX.play("Laser_Shoot")
	shoot_timer.start()

func _go_right(_s):
	is_right = true
	sprite.scale = Vector2(1, 1)
	current_speed_x = _s
	current_speed_y = 0

func _go_left(_s):
	is_right = false
	sprite.scale = Vector2(-1, 1)
	current_speed_x = -_s
	current_speed_y = 0

func _go_jump_up(_s):
	current_speed_y = -_s
	current_speed_x = 0
	position.y -= 3
	
func _go_jump_down(_s):
	current_speed_y = _s * .5
	current_speed_x = 0
	position.y += 2

func _go_up_ladder(_s):
#	on_ladder = true
	up_ladder = true
	current_speed_y = -_s 
	current_speed_x = 0
	
func _go_down_ladder(_s):
#	on_ladder = true
	up_ladder = false
	current_speed_y = _s *.5
	current_speed_x = 0
	position.y += .5

func _go_no_where(_s):
	current_speed_y = 0
	current_speed_x = 0

func hit(_by_who, _by_what, _damage_type, _damage):
	Player_Stats.add_score(_by_who, points)
	health -= (_damage - armor)
	if health <= 0:
		print("Open Gunner dead")
		FX.explode(-7, 1, self.position, "Open Gunner #2 Self Destruct System", 0, 0)
		# call_deferred("_explode")
		call_deferred("free")

# func _explode():
# 	var e = explode.instance()
# 	Map_Hand.add_kid_to_map(e)
# #	get_tree().get_current_scene().map.add_child(x)
# 	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)

func _on_floor():
	on_floor = cast_down.is_colliding()
#	print(on_floor)

func _over_ladders():
	if ladder_count > 0:
		over_ladder = true
	else:
		over_ladder = false
		on_ladder = false

func _change_shoot_pos(_pos_num):
	if _pos_num == 1:
		if is_right:
			return s_pos_up_r
		else:
			return s_pos_up_l
	elif _pos_num == 2:
		return s_pos_right_u
	elif _pos_num == 3:
		return s_pos_right
	elif _pos_num == 4:
		return s_pos_right_d
	elif _pos_num == 5:
		if is_right:
			return s_pos_down_r
		else:
			return s_pos_down_l
	elif _pos_num == 6:
		return s_pos_left_d
	elif _pos_num == 7:
		return s_pos_left
	elif _pos_num == 8:
		return s_pos_left_u

func _get_shot():
#	if !cast_shoot_up.is_colliding() && !cast_shoot_left_up.is_colliding() && !cast_shoot_right_up.is_colliding() && !cast_shoot_down.is_colliding() && !cast_shoot_left_down.is_colliding() && !cast_shoot_right_down.is_colliding() && !cast_shoot_left.is_colliding() && !cast_shoot_right.is_colliding():
#		return 0
	if cast_shoot_left.is_colliding():
		var body = cast_shoot_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 7
	if cast_shoot_right.is_colliding():
		var body = cast_shoot_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 3
	if cast_shoot_left_up.is_colliding():
		var body = cast_shoot_left_up.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 8
	if cast_shoot_right_up.is_colliding():
		var body = cast_shoot_right_up.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 2
	if cast_shoot_left_down.is_colliding():
		var body = cast_shoot_left_down.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 6
	if cast_shoot_right_down.is_colliding():
		var body = cast_shoot_right_down.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 4
	if cast_shoot_up.is_colliding():
		var body = cast_shoot_up.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 1
	if cast_shoot_down.is_colliding():
		var body = cast_shoot_down.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				activate_add_to_front(0, body)
				return 5
	return 0

func _on_Timer_Shoot_timeout():
	can_shoot = true

# warning-ignore:unused_argument
func _on_Area2DOn_Ladder_body_entered(body):
#	print(body.position)
	ladder_count += 1

# warning-ignore:unused_argument
func _on_Area2DOn_Ladder_body_exited(body):
#	print(body.position)
	ladder_count -= 1
	
func activate(_num, _player):
	if _num == active_number || _num == 0:
		active = true
		if !hunted.has(_player):
			hunted.append(_player)

func activate_add_to_front(_num, _player):
	if _num == active_number || _num == 0:
		active = true
		if !hunted.has(_player):
			hunted.append(_player)
		else:
			hunted.push_front(_player)
		
func sort_distance(_a, _b):
	if (abs(_a.global_position.x - self.global_position.x) + abs(_a.global_position.y - self.global_position.y)) < (abs(_b.global_position.x - self.global_position.x) + abs(_b.global_position.y - self.global_position.y)):
		return true
	else:
		return false

func remove_dead(_array):
	var h_size = (_array.size() - 1)
	for h in _array.size():
#		print(h, h_size, hunted.size())
		if !is_instance_valid(_array[h_size - h]):
			_array.remove(h_size - h)
#	print(hunted.size())
