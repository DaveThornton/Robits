extends 'res://Scripts/Guns/Pick/W_00_Bomb_Pick.gd'

onready var sprite = $Sprite
onready var shape = $Big_CollisionShape2D
onready var ray_up = $Raycast/Up
onready var ray_left = $Raycast/Left
onready var ray_right = $Raycast/Right
onready var ray_down = $Raycast/Down

var armed = false

func set_dir(_is_right, _dir): self.rotation_degrees = 0
func call_if_armed(): armed = true
func _physics_process(_delta):
	if armed:
		self.rotation_degrees = 0
		if ray_up.is_colliding():
			var a = ray_up.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 0)
			queue_free()
			return
		if ray_left.is_colliding():
			var a = ray_left.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, -90)
			queue_free()
			return
		if ray_right.is_colliding():
			var a = ray_right.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 90)
			queue_free()
			return
		if ray_down.is_colliding():
			var a = ray_down.get_collision_point()
			var b = FX.misc.armed_mine().instance()
			Map_Hand.add_kid_to_map(b)
			b.init(player, damage, a, 180)
			queue_free()
			return