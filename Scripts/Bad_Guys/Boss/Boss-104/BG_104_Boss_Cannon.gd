extends Node2D

# export(PackedScene) var boom
export(PackedScene) var projectile

onready var sprite = $BG_104_Boss_Cannon_01
onready var pos_shoot = $Position2D
onready var anim = $AnimationPlayer
onready var anim_hit = $AnimationPlayer_Hit
onready var timer = $Timer

export var cannon_num = 1
export var health = 100
export var armor = 2
export var time = 1.0
export var damage = 40
export var points = 3

var gun_num = 104
var can_shoot = true
var dead = false
signal cannon_death

func _ready():
	pass

func start(_time):
	anim.play("Shoot")
	timer.wait_time = _time

func shoot():
	if can_shoot && !dead:
		var _ss = pos_shoot.global_position
		var _sr = pos_shoot.global_rotation
		var _sss = pos_shoot.scale
		FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
		SFX.play("Laser_Shoot")
		timer.start()

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			FX.explode(104, -1, self.global_rposition,"cannons destruct system", 0, 0)
			dead = true
			Player_Stats.add_score(_by_who, points)
			emit_signal("dead_hit_spot")
			dead = true
			self.visible = false
			anim_hit.play("Dead")
			emit_signal("cannon_death",cannon_num)


func set_can_shoot(_can):
	can_shoot = _can
	if _can:
		timer.start()

func explode():
	dead = true
	self.visible = false
	anim_hit.play("Dead")
	emit_signal("cannon_death",cannon_num)

func start_timer():
	timer.start()

func _on_Timer_timeout():
	anim.play("Shoot")
































