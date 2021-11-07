extends Node2D

export(PackedScene) var projectile
export var damage =100

onready var pos = $Position2D
onready var anim = $AnimationPlayer
onready var shoot_timer = $Timer
onready var raycast = $RayCast2D

var player = -1
var can_shoot = false
var ring_count = 0
var gun_num = 103
func _ready():
	pass

func shoot():
	can_shoot = false 
	var _ss = pos.global_position
	var _sr = pos.global_rotation
	_sr = pos.global_rotation
	var _sss = pos.scale
	FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
	anim.play("Shoot")
	SFX.play("Laser_Shoot")
	shoot_timer.start()
	print("BG 103 barrel shoot: BANG!!!!")

func _process(_delta):
	if can_shoot:
		if raycast.is_colliding():
			if ring_count >= 3:
				shoot()
				ring_count = -2
			elif ring_count ==2:
				ring_count += 1
				anim.play("Three")
				can_shoot = false
				shoot_timer.start()
			elif ring_count == 1:
				ring_count += 1
				anim.play("Two")
				can_shoot = false
				shoot_timer.start()
			elif ring_count == 0:
				ring_count += 1
				anim.play("One")
				can_shoot = false
				shoot_timer.start()
			elif ring_count < 0:
				ring_count += 1
				can_shoot = false
				shoot_timer.start()
		
func _on_Timer_timeout():
	can_shoot = true
