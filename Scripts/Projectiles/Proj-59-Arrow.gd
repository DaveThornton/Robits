extends Area2D

onready var ray = $RayCast2D
onready var timer = $Timer
var speed = 800
var player = 1
var damage = 50
var damage_type = "Arrow"
var gun_num = 0

func start(_gun_num,_rot, _pos, _scale, _owner, _dmg):
	gun_num = _gun_num
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	player = _owner
	ray.set_collision_mask_bit(Player_Stats.get_player_collision_layer(_owner) - 1, false)
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if ray.is_colliding():
		if ray.get_collider().get_groups().has("map"):
			var spot = ray.get_collision_point()
			var x = FX.stuck_arrow().instance()
			Map_Hand.add_kid_to_map(x)
			x.init(player, damage, spot, rotation, scale, 2)
			print_debug("map")
		else:
			if ray.get_collider().get_groups().has("player"):
				Player_Stats.add_hit(player,1)
				ray.get_collider().hit(player, gun_num, damage_type, damage)
			var spot = ray.get_collision_point()
			print_debug(spot)
			var x = FX.stuck_arrow().instance()
			ray.get_collider().add_child(x)
			x.init(player, damage, spot, rotation, scale, 2)
			print_debug("not map")
		call_deferred("free")
	move_local_x(speed * delta)


func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	ray.set_collision_mask(_bit)

func _on_Timer_timeout():
	call_deferred("free")
