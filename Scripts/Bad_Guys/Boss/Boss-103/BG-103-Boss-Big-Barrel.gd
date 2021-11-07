extends KinematicBody2D

onready var shoot_spot = $Position2D
onready var shoot_timer = $Timer
onready var anim_hit = $Anim_Hit
onready var anim_shoot = $Anim_Shoot
onready var shape = $CollisionShape2D

var dead = false
var can_shoot = true
var damage = 45

var health = 200
var armor = 5

signal dead_cannon

func shoot():
	if !dead:
		anim_shoot.play("Shoot")
		can_shoot = false 
		var _ss = shoot_spot.global_position
		var _sr = shoot_spot.global_rotation
		var _sss = shoot_spot.scale
		FX.proj_bad(104, _sr , _ss, _sss, -1, damage)
		SFX.play("Laser_Shoot")
		shoot_timer.start()

func hit(_by_who, _by_what, _damage_type, _damage):
	if !dead:
		anim_hit.play("Hit")
		health -= (_damage - armor)
		if health <= 0:
			emit_signal("dead_cannon")
			FX.explode(2, -1, self.position, str(self, "'s destruct system"), 0, 0)
			dead = true
			shape.disabled = true
			anim_hit.play("Dead")

func _on_Timer_timeout():
	can_shoot = true
	shoot()
