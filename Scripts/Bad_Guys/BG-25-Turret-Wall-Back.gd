extends StaticBody2D

export var activate_self = true
export var activation_num = 0
export var armor = 0

onready var area = $Area2D/CollisionShape2D
# onready var light_color = $"BG-25-Turret-Wall-Back-Turret/BG-25-Turret-Wall-Back-Light"
# onready var light_white = $"BG-25-Turret-Wall-Back-Turret/BG-25-Turret-Wall-Back-White"
onready var anim_gun = $AnimationPlayer_Gun
onready var anim_door = $AnimationPlayer_Door
onready var gun_arm = $"Bg-25-Turret-Wall"
onready var shoot_cast = $"Bg-25-Turret-Wall/RayCast2D"
onready var shoot_timer = $Timer

var activated = false
var can_shoot = false
var damage = 20
var ex_dmg = 25
var health = 75
var player = -1
var bodies_in_range = []
var current_look_time = 0
var look_time = .25
var hit_time = 0
var gun_num = 10

func _ready():
	if activate_self:
		Map_Hand.connect_activate(self, activation_num)

func _process(delta):
	# if hit_time > 0:
	# 	hit_time -= delta
	# 	# light_color.visible = false
	# 	# light_white.visible = true
	# else:
	# 	# light_color.visible = true
	# 	# light_white.visible = false
	current_look_time += delta
	if current_look_time > look_time:
		current_look_time = 0
		if bodies_in_range.size() > 0:
			remove_dead()
			if bodies_in_range.size() > 0:
				if bodies_in_range.size() > 1:
					bodies_in_range.sort_custom(self, "sort_distance")
				gun_arm.look_at(bodies_in_range[0].global_position + Vector2(0, -30))
				if can_shoot:
					if shoot_cast.is_colliding():
						if shoot_cast.get_collider().get_groups().has("player"):
							_shoot(gun_arm)

func set_activation_num(_num :int): activation_num = _num

func set_activation_self(_act :bool): activate_self = _act

func activate(_body):
	if !activated:
		activated = true
		anim_door.play("Open")
		shoot_timer.start()
		# can_shoot = true

func self_destruct():
	explode()
	call_deferred("free")

func _shoot(_pos):
	can_shoot = false 
	var _ss = _pos.global_position
	var _sr = _pos.global_rotation
	_sr = _pos.global_rotation
	var _sss = _pos.scale
	FX.proj_bad(gun_num, _sr , _ss, _sss, -1, damage)
	SFX.projectile(gun_num)
	anim_gun.play("Shoot")
	# SFX.play("Laser_Shoot")
	shoot_timer.start()

func set_can_shoot(_can): can_shoot = _can

func hit(_by_who, _by_what, _damage_type, _damage):
	if activated:
		health -= (_damage - armor)
		hit_time = .15
		if health <= 0:
			print_debug("BG-20-Turrent-Ground dead")
			explode()
			# call_deferred("_explode")
			call_deferred("free")

func explode(): FX.explode(2, player, self.position, 225, player, ex_dmg)

func sort_distance(_a, _b):
	if (abs(_a.global_position.x - self.global_position.x) + abs(_a.global_position.y - self.global_position.y)) < (abs(_b.global_position.x - self.global_position.x) + abs(_b.global_position.y - self.global_position.y)):
		return true
	else:
		return false

func _on_Area2D_body_entered(body): bodies_in_range.append(body)

func _on_Area2D_body_exited(body): bodies_in_range.erase(body)

func _on_Timer_timeout(): can_shoot = true

func remove_dead():
	var h_size = (bodies_in_range.size() - 1)
	for h in  bodies_in_range.size():
		if !is_instance_valid( bodies_in_range[h_size - h]):
			 bodies_in_range.remove(h_size - h)
