extends KinematicBody2D

export(PackedScene) var projectile
export(PackedScene) var explode
export var right = true
export var idle = true
export var just_stand = false
export var speed = 6500
export var damage = 20
export var health = 5
export var armor = 3
export var go_off_edge = true
export var points = 2

onready var grfx = $Anim_BG_03
onready var ray_down_r = $Raycasts/Down_Right
onready var ray_down_l = $Raycasts/Down_Left
onready var ray_right = $Raycasts/Right
onready var ray_left = $Raycasts/Left
onready var ray_shoot_right = $Raycasts/Shoot_Right
onready var ray_shoot_left = $Raycasts/Shoot_Left
onready var ray_shoot_up = $Raycasts/Shoot_Up
onready var ray_shoot_down = $Raycasts/Shoot_Down
onready var ray_shoot_up_right = $Raycasts/Shoot_Right_Up
onready var ray_shoot_up_left = $Raycasts/Shoot_Left_Up
onready var ray_shoot_down_right = $Raycasts/Shoot_Right_Down
onready var ray_shoot_down_left = $Raycasts/Shoot_Left_Down
onready var ray_shoot_right_prone = $Raycasts/Shoot_Right_Prone
onready var ray_shoot_left_prone = $Raycasts/Shoot_Left_Prone
onready var ray_edge_right = $Raycasts/Right_Edge
onready var ray_edge_left = $Raycasts/Left_Edge
onready var shoot_timer = $Timer_Shoot
onready var pos_right = $Shoot_Pos/Right
onready var pos_left = $Shoot_Pos/Left
onready var pos_up = $Shoot_Pos/Up
onready var pos_down = $Shoot_Pos/Down
onready var pos_up_right = $Shoot_Pos/Right_Up
onready var pos_up_left = $Shoot_Pos/Left_Up
onready var pos_down_right = $Shoot_Pos/Right_Down
onready var pos_down_left = $Shoot_Pos/Left_Down
onready var pos_right_prone = $Shoot_Pos/Right_Prone
onready var pos_left_prone = $Shoot_Pos/Left_Prone

var shoot_spot
var shoot_num
var grav: = 900.0
var on_floor: = false
var on_ladder: = false
var vel: = Vector2(0, 0)
var terminal_vel: = 6
var can_shoot = true
var player = -1

func _ready():
	if right:
		grfx.scale.x = 1
	else:
		grfx.scale.x = -1

func _physics_process(delta):
	_on_floor()
	if can_shoot:
		_shoot()
	if !go_off_edge:
		_on_edge()
	if !just_stand:
		if !idle:
			_move_x(delta)
	vel += Vector2(0 , (grav * int(!on_floor) * delta))
	if vel.y > terminal_vel:
		vel.y = terminal_vel
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(vel.x,0))
	move_and_collide(Vector2(0,vel.y))

func _shoot():
	if ray_shoot_right_prone.is_colliding():
		var body = ray_shoot_right_prone.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = true
				grfx.scale.x = 1
				shoot_spot = pos_right_prone
				shoot_num = 6
	if ray_shoot_left_prone.is_colliding():
		var body = ray_shoot_left_prone.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = false
				grfx.scale.x = -1
				shoot_spot = pos_left_prone
				shoot_num = 6
	if ray_shoot_up.is_colliding():
		var body = ray_shoot_up.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				shoot_spot = pos_up
				shoot_num = 1
	if ray_shoot_up_right.is_colliding():
		var body = ray_shoot_up_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = true
				grfx.scale.x = 1
				shoot_spot = pos_up_right
				shoot_num = 2
	if ray_shoot_up_left.is_colliding():
		var body = ray_shoot_up_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = false
				grfx.scale.x = -1
				shoot_spot = pos_up_left
				shoot_num = 2
	if ray_shoot_down_right.is_colliding():
		var body = ray_shoot_down_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = true
				grfx.scale.x = 1
				shoot_spot = pos_down_right
				shoot_num = 4
	if ray_shoot_down_left.is_colliding():
		var body = ray_shoot_down_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = false
				grfx.scale.x = -1
				shoot_spot = pos_down_left
				shoot_num = 4
	if ray_shoot_down.is_colliding():
		var body = ray_shoot_down.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				shoot_spot = pos_down
				shoot_num = 5
	if ray_shoot_right.is_colliding():
		var body = ray_shoot_right.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = true
				grfx.scale.x = 1
				shoot_spot = pos_right
				shoot_num = 3
	if ray_shoot_left.is_colliding():
		var body = ray_shoot_left.get_collider()
		if is_instance_valid(body):
			if body.get_groups().has("player"):
				right = false
				grfx.scale.x = -1
				shoot_spot = pos_left
				shoot_num = 3
	if shoot_spot:
		if can_shoot:
			grfx.play_anim("shoot", shoot_num)
			vel.x = 0
			can_shoot = false 
			var new_projectile = projectile.instance()
			get_tree().get_current_scene().add_child(new_projectile)
			var _ss = shoot_spot.global_position
			var _sr = shoot_spot.global_rotation
			var _sss = shoot_spot.scale
			new_projectile.start(_sr , _ss, _sss, 0, damage)
			SFX.play("Laser_Shoot")
			shoot_timer.start()
#			print("shoot")
			idle = false
			can_shoot = false
			shoot_spot = null

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	if health <= 0:
		Player_Stats.add_score(_by_who, points)
		print("Open Gunner dead BG-03")
		call_deferred("_explode")
		call_deferred("free")

func _on_edge():
	if right:
		if !ray_edge_right.is_colliding():
			right = false
	else:
		if !ray_edge_left.is_colliding():
			right = true

func _explode():
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)

func stop():
	idle = true
	
func go():
	idle = false

func _move_x(delta):
	if can_shoot:
		if right:
			if ray_right.is_colliding():
				right = false
			else:
				vel.x = speed * delta
				grfx.scale.x = 1
				grfx.play_anim("Run-Mid",3)
		else:
			if ray_left.is_colliding():
				right = true
			else:
				vel.x = -speed * delta
				grfx.scale.x = -1
				grfx.play_anim("Run-Mid",3)

func _on_floor():
	if ray_down_l.is_colliding() || ray_down_r.is_colliding():
		on_floor = true
		vel.y = 0
	else:
		on_floor = false

func _on_Timer_Shoot_timeout():
	can_shoot = true
