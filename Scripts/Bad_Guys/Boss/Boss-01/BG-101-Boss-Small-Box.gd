extends Node2D

export(PackedScene) var projectile
export(PackedScene) var explode
export var light_color = Color8(255, 255, 255, 255)
export var hit_color = Color8(255, 255, 255, 255)
export var speed = 6500
export var damage = 20
export var health = 150
export var armor = 3
export var can_shoot = false

onready var light = $"BG-101-Boss-Small-Box-Light"
onready var anim = $AnimationPlayer
onready var shoot_timer = $Timer
onready var shoot_spot_1 = $Shoot_Spots/Pos_Shoot_01
onready var shoot_spot_2 = $Shoot_Spots/Pos_Shoot_02
onready var shoot_spot_3 = $Shoot_Spots/Pos_Shoot_03

var activated = false
var hit_time = 0.0
var open = false

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
	if hit_time > 0.0:
		hit_time -= delta
		light.self_modulate = hit_color
	else:
		light.self_modulate = light_color

func shoot():
	var new_projectile1 = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile1)
	var _ss = shoot_spot_1.global_position
	var _sr = shoot_spot_1.global_rotation
	var _sss = shoot_spot_1.scale
	new_projectile1.start(_sr , _ss, _sss, 0, damage)
	
	var new_projectile2 = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile2)
	var _ss2 = shoot_spot_2.global_position
	var _sr2 = shoot_spot_2.global_rotation
	var _sss2 = shoot_spot_2.scale
	new_projectile2.start(_sr2 , _ss2, _sss2, 0, damage)
	
	var new_projectile3 = projectile.instance()
	get_tree().get_current_scene().add_child(new_projectile3)
	var _ss3 = shoot_spot_3.global_position
	var _sr3 = shoot_spot_3.global_rotation
	var _sss3 = shoot_spot_3.scale
	new_projectile3.start(_sr3 , _ss3, _sss3, 0, damage)
	SFX.play("Laser_Shoot")

func hit(_by_who, _by_what, _damage_type, _damage):
	if open:
		hit_time += .1
		health -= (_damage - armor)
		if health <= 0:
			print("small box in bg 101 boss killed")
			call_deferred("_explode")
			call_deferred("free")
		
func _explode():
	var e = explode.instance()
	Map_Hand.add_kid_to_map(e)
	e.init(9, self.position, str("player ", e, "'s destruct system"), 0, 0)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open_Can_Shoot":
		shoot_timer.start()

func _on_Timer_timeout():
	anim.play("Open_Can_Shoot")

func set_open(_open:bool):
	open = _open
