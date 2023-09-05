extends StaticBody2D

export var armor = 0
export var far_disabled = false
export var area_1_disabled = false
export var area_2_disabled = false
export var area_3_disabled = false
export var area_4_disabled = false

onready var area_1 = $Area2D/Area_1
onready var area_2 = $Area2D/Area_2
onready var area_3 = $Area2D/Area_3
onready var area_4 = $Area2D/Area_4

onready var area_5 = $Area2D/Area_5
onready var area_6 = $Area2D/Area_6
onready var area_7 = $Area2D/Area_7
onready var area_8 = $Area2D/Area_8

onready var anim = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var gun_arm = $Gun_Arm
onready var shoot_cast = $Gun_Arm/RayCast2D
onready var shoot_timer = $Timer_Shoot

var can_shoot = true
var damage = 20
var ex_dmg = 25
var health = 75
var player = -1
var bodies_in_range = []
var current_look_time = 0
var look_time = .25
var gun_num = 10

func _ready():
	area_1.disabled = area_1_disabled
	area_5.disabled = area_1_disabled
	area_2.disabled = area_2_disabled
	area_6.disabled = area_2_disabled
	area_3.disabled = area_3_disabled
	area_7.disabled = area_3_disabled
	area_4.disabled = area_4_disabled
	area_8.disabled = area_4_disabled
	if far_disabled:
		area_5.disabled = true
		area_6.disabled = true
		area_7.disabled = true
		area_8.disabled = true
	else:
		area_1.disabled = true
		area_2.disabled = true
		area_3.disabled = true
		area_4.disabled = true

# warning-ignore:unused_argument
func _process(delta):
	current_look_time += delta
	if current_look_time > look_time:
		current_look_time = 0
		if bodies_in_range.size() > 0:
			remove_dead()
			if bodies_in_range.size() > 0:
				if bodies_in_range.size() > 1:
					bodies_in_range.sort_custom(self, "sort_distance")
				gun_arm.look_at(bodies_in_range[0].global_position)
				if can_shoot:
					if shoot_cast.is_colliding():
						if shoot_cast.get_collider().get_groups().has("player"):
							_shoot(gun_arm)

func _shoot(_pos):
	can_shoot = false 
	var _ss = _pos.global_position
	var _sr = _pos.global_rotation
	_sr = _pos.global_rotation
	var _sss = _pos.scale
	FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
	anim.play("Shoot")
	# SFX.play("Laser_Shoot")
	shoot_timer.start()

func hit(_by_who, _by_what, _damage_type, _damage):
	health -= (_damage - armor)
	anim2.play("Hit")
	if health <= 0:
		print_debug("BG-20-Turrent-Ground dead")
		FX.explode(2,player, self.position, 222, player, ex_dmg)
		call_deferred("free")

func sort_distance(_a, _b):
	if (abs(_a.global_position.x - self.global_position.x) + abs(_a.global_position.y - self.global_position.y)) < (abs(_b.global_position.x - self.global_position.x) + abs(_b.global_position.y - self.global_position.y)):
		return true
	else:
		return false

func _on_Area2D_body_entered(body):
	bodies_in_range.append(body)

func _on_Area2D_body_exited(body):
	bodies_in_range.erase(body)

func _on_Timer_Shoot_timeout():
	can_shoot = true

func remove_dead():
	var h_size = (bodies_in_range.size() - 1)
	for h in  bodies_in_range.size():
		if !is_instance_valid( bodies_in_range[h_size - h]):
			 bodies_in_range.remove(h_size - h)
