extends StaticBody2D

export var light_color = Color8(255, 255, 255, 255)
export var hit_color = Color8(255, 255, 255, 255)
export var speed = 6500
export var damage = 20
export var health = 5
export var armor = 5
export var can_shoot = false

onready var timer = $Timer
onready var light = $"BG-101-Boss-Small-Box-Light"
onready var anim = $AnimationPlayer
onready var shoot_timer = $Timer
onready var shoot_spot_1 = $Shoot_Spots/Pos_Shoot_01
onready var shoot_spot_2 = $Shoot_Spots/Pos_Shoot_02
onready var shoot_spot_3 = $Shoot_Spots/Pos_Shoot_03
onready var hit_box = $CollisionShape2D

var gun_num = 10
var activated = false
var dead = false
var hit_time = 0.0
var open = false

signal dead

func _ready():
	light.self_modulate = light_color

func activate():
	if !activated:
		activated = true
		if can_shoot:
			shoot_timer.start()
		else:
			anim.play("Open_Cant_Shoot")
			open = true
		

func _process(delta):
	if !dead:
		if hit_time > 0.0:
			hit_time -= delta
			light.self_modulate = hit_color
		else:
			light.self_modulate = light_color

func shoot():
	var _ss = shoot_spot_1.global_position
	var _sr = shoot_spot_1.global_rotation
	var _sss = shoot_spot_1.scale
	FX.proj_bad(gun_num, _sr, _ss, _sss, -1, damage)

	var _ss2 = shoot_spot_2.global_position
	var _sr2 = shoot_spot_2.global_rotation
	var _sss2 = shoot_spot_2.scale
	FX.proj_bad(gun_num, _sr2 , _ss2, _sss2, -1, damage)

	var _ss3 = shoot_spot_3.global_position
	var _sr3 = shoot_spot_3.global_rotation
	var _sss3 = shoot_spot_3.scale
	FX.proj_bad(gun_num, _sr3 , _ss3, _sss3, -1, damage)
	# SFX.play("Laser_Shoot")

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		if open:
			hit_time += .1
			health -= (_damage - armor)
			if health <= 0:
				FX.explode(2, -1, self.position, 301, 0, 0)
				broken()

func broken():
	emit_signal("dead")
	timer.stop()
	dead = true
	anim.play("Broken")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open_Can_Shoot":
		shoot_timer.start()

func _on_Timer_timeout():
	anim.play("Open_Can_Shoot")

func set_open(_open:bool):
	open = _open
