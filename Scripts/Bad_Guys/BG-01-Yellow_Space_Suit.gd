extends KinematicBody2D

const FLOOR = Vector2(0, -1)
const speed = 6000

export(PackedScene) var projectile

export var going_right = true
export var damage = 21

onready var cast_look_right = $RayCast_Look_Right
onready var cast_look_left = $RayCast_Look_Left
onready var cast_down = $RayCast2D
onready var cast_up_r = $RayCast2D_Up_R
onready var cast_up_l = $RayCast2D_Up_L
onready var shoot_cast = $Sprite/RayCast_Shoot
onready var stop_cast = $Sprite/RayCast_Stop
onready var bg_check_cast = $Sprite/RayCast2D_BG_Check
onready var melee_cast = $Sprite/RayCast_Melee
onready var cast_bump_r = $RayCast_Bump_R
onready var cast_bump_l = $RayCast_Bump_L
onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var shoot_timer = $Timer_Shoot
onready var pos_shoot = $Sprite/Pos_Shoot

var grav = 10
var terminal_vel = 9
var current_anim = "Run"
var last_anim = "Run"
var current_speed = 0
var vel = Vector2()
var started = false
var on_floor = false
var can_shoot = true
var is_right = true
var health = 50
# warning-ignore:unused_class_variable
var player = 0
var armor = 0

func _ready():
	anim.play("Idle")

func _physics_process(delta):
#func _process(delta):
	if started:
		if shoot_cast.is_colliding():
			if shoot_cast.get_collider().get_groups().has("hittable"):
#				print_debug("its hittable yellow suit")
				if can_shoot:
					shoot()
		if stop_cast.is_colliding():
			current_speed = 0
		else:
			var right_player_pos
			var left_player_pos
			if cast_look_right.is_colliding():
				if cast_look_right.get_collider().get_groups().has("player"):
					right_player_pos = cast_look_right.get_collision_point()
			if cast_look_left.is_colliding():
				if cast_look_left.get_collider().get_groups().has("player"):
					left_player_pos = cast_look_left.get_collision_point()
			if right_player_pos && left_player_pos:
				var rpp = right_player_pos - self.position
				var lpp = left_player_pos - self.position
				if abs(rpp.x) < abs(lpp.x):
					_go_right(delta)
				else:
					_go_left(delta)
			elif right_player_pos && !left_player_pos:
				_go_right(delta)
			elif !right_player_pos && left_player_pos:
				_go_left(delta)
			else:
				if cast_bump_r.is_colliding():
					going_right = false
				elif cast_bump_l.is_colliding():
					going_right = true
				_go_some_where(delta)

		if bg_check_cast.is_colliding():
			current_speed = 0

		if cast_up_l.is_colliding():
			var _body = cast_up_l.get_collider()
			if _body.get_groups().has("player"):
				_body.vel.y += -1
		if cast_up_r.is_colliding():
			var _body = cast_up_r.get_collider()
			if _body.get_groups().has("player"):
				_body.vel.y += -1
		if vel.x != 0:
			current_anim = "Run"
		else:
			current_anim = "Idle"
		if current_anim != last_anim:
			anim.play(current_anim)
			last_anim = current_anim
		vel.x = current_speed
	var movement = Vector2(vel.x * delta , (vel.y + (grav * delta)))
	vel = movement
	_on_floor()
	if on_floor:
		vel.y = vel.y / 1.1
	if vel.y > terminal_vel:
		vel.y = terminal_vel
# warning-ignore:return_value_discarded
	move_and_collide(Vector2(0,vel.y))
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(vel.x,0))

func shoot():
	if !melee_cast.is_colliding():
		can_shoot = false
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		if is_right:
			_sr = pos_shoot.global_rotation
		else:
			_sr = pos_shoot.global_rotation * -1
		var _sss = pos_shoot.scale
		FX.proj_bad(4, _sr , _ss, _sss, -1, damage)
		SFX.play("Laser_Shoot")
		shoot_timer.start()
	else:
		var _body = melee_cast.get_collider()
		if _body.get_groups().has("player"):
			_body.knock_back(1600, .4)
			_body.stun(01)
			_body.hit(9, "Bad Guy", "Melee", 10)
		can_shoot = false
		shoot_timer.start()

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	if health <= 0:
		FX.explode(2,9, self.position, 201, 0, 0)
		call_deferred("free")

func _on_floor():
	on_floor = cast_down.is_colliding()

func _on_Timer_Shoot_timeout():
	can_shoot = true

func _go_right(_delta):
	is_right = true
	going_right = true
	sprite.scale = Vector2(1, 1)
	current_speed = speed

func _go_left(_delta):
	is_right = false
	going_right = false
	sprite.scale = Vector2(-1, 1)
	current_speed = -speed

func _go_some_where(_delta):
	if going_right:
		_go_right(_delta)
	else:
		_go_left(_delta)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		body.bounce(-100, .1, true)

func _on_Timer_timeout():
	started = true
