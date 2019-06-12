extends KinematicBody2D

export(PackedScene) var projectile
export(PackedScene) var explode
onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var cast_down = $Casts/RayCast2D_Down 
onready var pos_shoot = $Position2D
onready var sfx = $SFX_Lib
onready var shoot_timer = $Timer_Shoot
onready var cast_shoot_right = $"Casts/Shoot_Casts/Shoot-Right-RayCast2D"

var path : = PoolVector2Array() setget set_path
var nav_system
var damage = 20
var last_anim = "Idle-Aim-Mid"
var last_pos : = Vector2()
var speed : = 60.0
var current_speed_x = 0.0
var current_speed_y = 0.0
var started = false
var on_floor = false
var on_ladder = false
var over_ladder = false
var ladder_count = 0
var can_shoot = true
var is_right = true
var health = 50
var player = -1
var can_move = false

func _ready():
#	print("changing anim")
#	anim = anim1.duplicate(bg_anim_num)
#	anim = anim1
	last_pos = self.global_position

func _process(delta: float) -> void:
	if cast_shoot_right.is_colliding():
		if can_shoot:
			shoot()
		if last_pos == global_position:
			_animation("Idle-Aim-Mid")
	else:
		if !nav_system:
			if self.get_tree().get_current_scene().map.nav_system:
				nav_system = self.get_tree().get_current_scene().map.nav_system
				print("nav system found ", nav_system)
				nav_system.found_me()
		else:
			if self.get_tree().get_current_scene().pawns.get_children().size() > 0:
				nav_system.find_path(self, self.get_tree().get_current_scene().pawns.get_child(0))
#			var move_distance : = speed * delta
#			move_along_path(move_distance)
#		if last_pos == global_position:
#			_animation("Idle-Mid")
#		elif int(last_pos.x) != int(global_position.x):
#			_animation("Run-Mid")
##		elif int(last_pos.y) != int(global_position.y):
#		elif int(last_pos.y) > int(global_position.y):
#			if over_ladder:
#				_animation("Ladder-Up")
#			else:
#				_animation("Jump-Up")
#		elif int(last_pos.y) < int(global_position.y):
#			if over_ladder:
#				_animation("Ladder-Up")
#			else:
#				_animation("Jump-Down")
#	_on_floor()
	_over_ladders()
#	move_and_slide(Vector2(current_speed_x, current_speed_y))

func _physics_process(delta):
	var move_distance = speed * delta
	move_along_path(move_distance)
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
		var hor_move = int(self.global_position.x) - int(path[0].x)
		var vert_move = int(self.global_position.y) - int(path[0].y)
		if hor_move < 0:
			_go_right(distance)
		elif hor_move > 0:
			_go_left(distance)
		elif vert_move > 0:
			if over_ladder:
				_go_up_ladder(distance)
			else:
				_go_jump_up(distance)
		elif vert_move < 0:#
			if over_ladder:
				_go_down_ladder(distance)
			else:
				_go_jump_down(distance)
		else:
			_go_no_where(distance)

		if distance <= distance_to_next and distance >= 0.5:
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

func shoot():
	can_shoot = false 
	var new_projectile = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile)
	var _ss = pos_shoot.global_position
	var _sr = pos_shoot.global_rotation
	if is_right:
		_sr = pos_shoot.global_rotation
	else:
		_sr = pos_shoot.global_rotation * -1
	var _sss = pos_shoot.scale
	new_projectile.start(_sr , _ss, _sss, player, damage)
	sfx.play("Laser_Shoot")
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
	current_speed_y = -_s 
	current_speed_x = 0
	
func _go_down_ladder(_s):
	current_speed_y = _s *.5
	current_speed_x = 0
	position.y += .5

func _go_no_where(_s):
	current_speed_y = 0
	current_speed_x = 0

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0:
		print("Open Gunner dead")
		call_deferred("_explode")
		call_deferred("free")

func _explode():
	var x = explode.instance()
	get_tree().get_current_scene().map.add_child(x)
	x.init(9, self.position, str("player ", x, "'s destruct system"))

func _on_floor():
	on_floor = cast_down.is_colliding()

func _over_ladders():
	if ladder_count > 0:
		over_ladder = true
	else:
		over_ladder = false
		on_ladder = false

func _on_Timer_Shoot_timeout():
	can_shoot = true

# warning-ignore:unused_argument
func _on_Area2DOn_Ladder_body_entered(body):
	ladder_count += 1

# warning-ignore:unused_argument
func _on_Area2DOn_Ladder_body_exited(body):
	ladder_count -= 1
