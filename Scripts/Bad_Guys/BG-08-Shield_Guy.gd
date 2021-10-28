extends RigidBody2D

export(PackedScene) var projectile
# export(PackedScene) var explode
export var health = 200
export var armor = 10
export var damage = 50
export var shoot_speed = 2.0
export var is_right = true
onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var collsion_shape = $CollisionShape2D
onready var pos = $Position2D_Shoot

var time_to_shoot = 0.0
var exp_damage = 20
var my_name = "Shield Gunner"

func _ready():
	if is_right:
		self.scale.x = -1


func _process(delta):
	time_to_shoot += delta
	if time_to_shoot >= shoot_speed:
		print(time_to_shoot)
		time_to_shoot = 0.0
		shoot()

func shoot():
	var new_projectile = projectile.instance()
	Map_Hand.add_kid_to_map(new_projectile)
	var _ss = pos.global_position
	var _sr = pos.global_rotation
	_sr = pos.global_rotation
	var _sss = pos.scale
	new_projectile.start(_sr , _ss, _sss, 9, damage)
	anim.play("Shoot")

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	anim2.play("Hit")
	if health <= 0:
		print("BG-08-Shield_Guy dead")
		FX.explode(7, -1, self.position,my_name, 0, exp_damage)
		# call_deferred("_explode")
		call_deferred("free")

# func _explode():
# 	var x = explode.instance()
# 	Map_Hand.add_kid_to_map(x)
# 	x.init(9, self.position,my_name, 0, exp_damage)
