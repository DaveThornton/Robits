extends StaticBody2D
#test upload from laptop  now change on desktop trying to figure out merge
export(PackedScene) var projectile
export(PackedScene) var explode

onready var sfx = $SFX_Lib
onready var sprite = $Sprite
onready var sprite2 = $Sprite2
onready var shoot_timer = $Timer_shoot
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2

onready var look_cast_0 = $"Casts/Look-Cast-0"
onready var look_cast_1 = $"Casts/Look-Cast-1"
onready var look_cast_2 = $"Casts/Look-Cast-2"
onready var look_cast_3 = $"Casts/Look-Cast-3"
onready var look_cast_4 = $"Casts/Look-Cast-4"
onready var look_cast_5 = $"Casts/Look-Cast-5"
onready var look_cast_6 = $"Casts/Look-Cast-6"
onready var look_cast_7 = $"Casts/Look-Cast-7"
onready var look_cast_8 = $"Casts/Look-Cast-8"

onready var shoot_cast_0 = $"Casts/Shoot-Cast-0"
onready var shoot_cast_1 = $"Casts/Shoot-Cast-1"
onready var shoot_cast_2 = $"Casts/Shoot-Cast-2"
onready var shoot_cast_3 = $"Casts/Shoot-Cast-3"
onready var shoot_cast_4 = $"Casts/Shoot-Cast-4"
onready var shoot_cast_5 = $"Casts/Shoot-Cast-5"
onready var shoot_cast_6 = $"Casts/Shoot-Cast-6"
onready var shoot_cast_7 = $"Casts/Shoot-Cast-7"
onready var shoot_cast_8 = $"Casts/Shoot-Cast-8"

onready var shoot_pos_0 = $"Shoot_Spots/Position2D-0"
onready var shoot_pos_1 = $"Shoot_Spots/Position2D-1"
onready var shoot_pos_2 = $"Shoot_Spots/Position2D-2"
onready var shoot_pos_3 = $"Shoot_Spots/Position2D-3"
onready var shoot_pos_4 = $"Shoot_Spots/Position2D-4"
onready var shoot_pos_5 = $"Shoot_Spots/Position2D-5"
onready var shoot_pos_6 = $"Shoot_Spots/Position2D-6"
onready var shoot_pos_7 = $"Shoot_Spots/Position2D-7"
onready var shoot_pos_8 = $"Shoot_Spots/Position2D-8"

var shoot_poss = []
#var current_shoot_pos
var can_shoot = true
var player = -1
var damage = 3
var health = 100

func _ready():
	shoot_poss.append(shoot_pos_0)
	shoot_poss.append(shoot_pos_1)
	shoot_poss.append(shoot_pos_2)
	shoot_poss.append(shoot_pos_3)
	shoot_poss.append(shoot_pos_4)
	shoot_poss.append(shoot_pos_5)
	shoot_poss.append(shoot_pos_6)
	shoot_poss.append(shoot_pos_7)
	shoot_poss.append(shoot_pos_8)
#	sprite.look_at(Vector2(5000,0))

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
	anim2.play("Hit-Orange")
	if health <= 0:
		print("BG-20-Turrent-Ground dead")
		call_deferred("_explode")
		call_deferred("free")

func _explode():
	var x = explode.instance()
	get_tree().get_current_scene().map.add_child(x)
	x.init(9, self.position, str("player ", x, "'s destruct system"))

func _is_look_col():
	if look_cast_0.is_colliding() || look_cast_1.is_colliding()  || look_cast_2.is_colliding()  || look_cast_3.is_colliding()  || look_cast_4.is_colliding() || look_cast_5.is_colliding()  || look_cast_6.is_colliding()  || look_cast_7.is_colliding()  || look_cast_8.is_colliding():
		return true
	else:
		return false

func _is_shoot_col():
	if shoot_cast_0.is_colliding() || shoot_cast_1.is_colliding()  || shoot_cast_2.is_colliding()  || shoot_cast_3.is_colliding()  || shoot_cast_4.is_colliding()  || shoot_cast_5.is_colliding()  || shoot_cast_6.is_colliding()  || shoot_cast_7.is_colliding()  || shoot_cast_8.is_colliding():
		return true
	else:
		return false

func _look_where():
	if look_cast_0.is_colliding():
		return 0
	elif look_cast_8.is_colliding():
		return 8
	elif look_cast_4.is_colliding():
		return 4
	elif look_cast_6.is_colliding():
		return 6
	elif look_cast_2.is_colliding():
		return 2
	elif look_cast_1.is_colliding():
		return 1
	elif look_cast_7.is_colliding():
		return 7
	elif look_cast_5.is_colliding():
		return 5
	elif look_cast_3.is_colliding():
		return 3

func _shoot_where():
	if shoot_cast_0.is_colliding():
		return 0
	elif shoot_cast_8.is_colliding():
		return 8
	elif shoot_cast_4.is_colliding():
		return 4
	elif shoot_cast_6.is_colliding():
		return 6
	elif shoot_cast_2.is_colliding():
		return 2
	elif shoot_cast_1.is_colliding():
		return 1
	elif shoot_cast_7.is_colliding():
		return 7
	elif shoot_cast_5.is_colliding():
		return 5
	elif shoot_cast_3.is_colliding():
		return 3

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
	elif _spot == 5:
		anim.play("Shoot_5")
	elif _spot == 6:
		anim.play("Shoot_6")
	elif _spot == 7:
		anim.play("Shoot_7")
	elif _spot == 8:
		anim.play("Shoot_8")
	else:
		print("error in BG-20 animation shoot spot not valid")

func _on_Timer_shoot_timeout():
	can_shoot = true
#	_shoot(shoot_poss[1])
