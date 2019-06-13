extends StaticBody2D
#test upload from laptop  now change on desktop trying to figure out merge
export(PackedScene) var projectile
export(PackedScene) var explode

onready var sfx = $SFX_Lib
onready var sprite = $Sprite
onready var shoot_timer = $Timer_shoot
onready var anim = $AnimationPlayer

onready var look_cast_left = $"Casts/Look-Cast-Left"
onready var look_cast_right = $"Casts/Look-Cast-Right"
onready var look_cast_up = $"Casts/Look-Cast-Up"
onready var look_cast_up_left = $"Casts/Look-Cast-Up-Left"
onready var look_cast_up_right = $"Casts/Look-Cast-Up-Right"

onready var shoot_cast_left = $"Casts/Shoot-Cast-Left"
onready var shoot_cast_right = $"Casts/Shoot-Cast-Right"
onready var shoot_cast_up = $"Casts/Shoot-Cast-Up"
onready var shoot_cast_up_left = $"Casts/Shoot-Cast-Up-Left"
onready var shoot_cast_up_right = $"Casts/Shoot-Cast-Up-Right"

onready var shoot_pos_left = $"Shoot_Spots/Position2D-Left"
onready var shoot_pos_right = $"Shoot_Spots/Position2D-Right"
onready var shoot_pos_up = $"Shoot_Spots/Position2D-Up"
onready var shoot_pos_up_left = $"Shoot_Spots/Position2D-Up-Left"
onready var shoot_pos_up_right = $"Shoot_Spots/Position2D-Up-Right"

var shoot_poss = []
#var current_shoot_pos
var can_shoot = true
var player = -1
var damage = 3
var health = 100

func _ready():
	shoot_poss.append(shoot_pos_left)
	shoot_poss.append(shoot_pos_up_left)
	shoot_poss.append(shoot_pos_up)
	shoot_poss.append(shoot_pos_up_right)
	shoot_poss.append(shoot_pos_right)

# warning-ignore:unused_argument
func _process(delta):
	if can_shoot:
		if _is_look_col():
			if _is_shoot_col():
				var shoot_spot= _shoot_where()
				sprite.frame = shoot_spot
				_animation(shoot_spot)
#				anim.play("Shoot_0")
				_shoot(shoot_poss[shoot_spot])
#				_shoot(shoot_poss[3])
			else:
				sprite.frame = _look_where()
#				print(_look_where())

func _shoot(_pos):
	can_shoot = false 
	var new_projectile = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile)
	var _ss = _pos.global_position
	var _sr = _pos.global_rotation
#	if is_right:
	_sr = _pos.global_rotation
#	else:
#		_sr = _pos.global_rotation * -1
	var _sss = _pos.scale
	new_projectile.start(_sr , _ss, _sss, player, damage)
	sfx.play("Laser_Shoot")
	shoot_timer.start()

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= _damage
	if health <= 0:
		print("BG-20-Turrent-Ground dead")
		call_deferred("_explode")
		call_deferred("free")

func _explode():
	var x = explode.instance()
	get_tree().get_current_scene().map.add_child(x)
	x.init(9, self.position, str("player ", x, "'s destruct system"))

func _is_look_col():
	if look_cast_left.is_colliding() || look_cast_right.is_colliding()  || look_cast_up.is_colliding()  || look_cast_up_left.is_colliding()  || look_cast_up_right.is_colliding() :
		return true
	else:
		return false

func _is_shoot_col():
	if shoot_cast_left.is_colliding() || shoot_cast_right.is_colliding()  || shoot_cast_up.is_colliding()  || shoot_cast_up_left.is_colliding()  || shoot_cast_up_right.is_colliding() :
		return true
	else:
		return false

func _look_where():
	if look_cast_left.is_colliding():
		return 0
	elif look_cast_right.is_colliding():
		return 4
	elif look_cast_up.is_colliding():
		return 2
	elif look_cast_up_right.is_colliding():
		return 3
	elif look_cast_up_left.is_colliding():
		return 1

func _shoot_where():
	if shoot_cast_left.is_colliding():
		return 0
	elif shoot_cast_right.is_colliding():
		return 4
	elif shoot_cast_up.is_colliding():
		return 2
	elif shoot_cast_up_right.is_colliding():
		return 3
	elif shoot_cast_up_left.is_colliding():
		return 1

func _animation(_spot):
	if _spot == 0 :
		anim.play("Shoot_0")
	elif _spot == 1:
		anim.play("Shoot_1")
	elif _spot == 2:
		anim.play("Shoot_2")
	elif _spot == 3:
		anim.play("Shoot_3")
	elif _spot == 4:
		anim.play("Shoot_4")
	else:
		print("error in BG-20 animation shoot spot not valid")

func _on_Timer_shoot_timeout():
	can_shoot = true
#	_shoot(shoot_poss[1])
