extends Area2D

# export(PackedScene) var hit_anim_map
# export(PackedScene) var hit_anim_move

onready var ray = $RayCast2D
onready var timer = $Timer
var speed = 1000
var player = 1
var my_name = "Crossbow Bolt"
var damage = 0
var damage_type = "Arrow"

func start(_rot, _pos, _scale, _owner, _dmg):
	timer.start()
	rotation = _rot + rand_range(-.01, .01)
	position = _pos
	scale = _scale
	player = _owner
	damage = _dmg
	if _scale.y < 0:
		rotation *= -1

func _physics_process(delta):
	if ray.is_colliding():
		if ray.get_collider().get_groups().has("map"):
			var spot = ray.get_collision_point()
			var x = FX.stuck_bolt().instance()
			Map_Hand.add_kid_to_map(x)
			x.init(player, damage, spot, rotation, scale, 2)
			print("map")
		else:
			if ray.get_collider().get_groups().has("player"):
				Player_Stats.add_hit(player,1)
			var spot = ray.get_collision_point()
			print(spot)
			var x = FX.stuck_bolt().instance()
			ray.get_collider().add_child(x)
			x.init(player, damage, spot, rotation, scale, 2)
			print("not map")
		call_deferred("free")
	move_local_x(speed * delta)

func set_layer(_bit):
	self.set_collision_layer(_bit)
	self.set_collision_mask(_bit)
	ray.set_collision_mask(_bit)

func _on_Timer_timeout():
	call_deferred("free")
