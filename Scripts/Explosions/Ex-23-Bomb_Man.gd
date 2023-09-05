extends Node2D

onready var ray_right = $RayCasts/RayCast2D_Right
onready var ray_left = $RayCasts/RayCast2D_Left
onready var ray_up = $RayCasts/RayCast2D_Up
onready var ray_down = $RayCasts/RayCast2D_Down
onready var ray_sit_right = $RayCasts/RayCast2D_Sit_Right
onready var ray_sit_left = $RayCasts/RayCast2D_Sit_Left
onready var ray_sit_up = $RayCasts/RayCast2D_Sit_Up
onready var ray_sit_down = $RayCasts/RayCast2D_Sit_Down


onready var fire_right = $Ex23Mid/EX_23_Length_128_Right
onready var fire_left = $Ex23Mid/EX_23_Length_128_Left
onready var fire_up = $Ex23Mid/EX_23_Length_128_Up
onready var fire_down = $Ex23Mid/EX_23_Length_128_Down

onready var area_right = $Area2D/CollisionShape2D_Right
onready var area_left = $Area2D/CollisionShape2D_Left
onready var area_up = $Area2D/CollisionShape2D_Up
onready var area_down = $Area2D/CollisionShape2D_Down

onready var anim = $AnimationPlayer

export var trauma = 0.0

var is_ready = false
var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage = 75
var damage_type = "Explosion"
var gun_num = 0
var time = 0
var free_time = .5

func _ready():
	is_ready = true

func init(_owner, _pos, _weap_name: int, _pawn_num, _dmg):
	owned = _owner
	self.global_position = _pos
	gun_num = _weap_name
	damage = _dmg
	ray_sit_up.force_raycast_update()
	ray_sit_down.force_raycast_update()
	ray_sit_left.force_raycast_update()
	ray_sit_right.force_raycast_update()
	if ray_sit_down.is_colliding():
		var spoty = ray_sit_down.get_collision_point().y - 16
		self.global_position.y = spoty
	elif ray_sit_up.is_colliding():
		var spoty = ray_sit_up.get_collision_point().y + 16
		self.global_position.y = spoty
	
	if ray_sit_right.is_colliding():
		var spotx = ray_sit_right.get_collision_point().x - 16
		self.global_position.x = spotx
	elif ray_sit_left.is_colliding():
		var spotx = ray_sit_left.get_collision_point().x + 16
		self.global_position.x = spotx
	# kick_area.set_size(ex_size)

	ex_sfx()
	FX.add_trauma(trauma)

func _process(delta):
	time += delta
	if time >= free_time:
		call_deferred("free")
	if is_ready == true:
		is_ready = false
		play()
		if ray_right.is_colliding():
			var r_dis = (ray_right.get_collision_point().x - self.global_position.x)
			fire_right.set_length(clamp((abs(r_dis) - 24.0),0.0,142.0))
			area_right.shape.extents.x = r_dis / 2
			area_right.position.x = r_dis / 2
		else:
			var r_dis = 142
			fire_right.set_length(abs(r_dis) - 24)
			area_right.shape.extents.x = r_dis / 2
			area_right.position.x = r_dis / 2

		if ray_left.is_colliding():
			var l_dis = (ray_left.get_collision_point().x - self.global_position.x)
			fire_left.set_length(clamp((abs(l_dis) - 24.0),0.0,142.0))
			area_left.shape.extents.x = l_dis / 2
			area_left.position.x = l_dis / 2
		else:
			var l_dis = -142
			fire_left.set_length(abs(l_dis) - 24)
			area_left.shape.extents.x = l_dis / 2
			area_left.position.x = l_dis / 2

		if ray_up.is_colliding():
			var u_dis = (ray_up.get_collision_point().y - self.global_position.y)
			fire_up.set_length(clamp((abs(u_dis) - 24.0),0.0,142.0))
			area_up.shape.extents.y = u_dis / 2
			area_up.position.y = u_dis / 2
		else:
			var u_dis = -142
			fire_up.set_length(abs(u_dis) - 24)
			area_up.shape.extents.y = u_dis / 2
			area_up.position.y = u_dis / 2

		if ray_down.is_colliding():
			var d_dis = (ray_down.get_collision_point().y - self.global_position.y)
			fire_down.set_length(clamp((abs(d_dis) - 24.0),0.0,142.0))
			area_down.shape.extents.y = d_dis / 2
			area_down.position.y = d_dis / 2
		else:
			var d_dis = 142
			fire_down.set_length(abs(d_dis) - 24)
			area_down.shape.extents.y = d_dis / 2
			area_down.position.y = d_dis / 2

func play():
	fire_right.play()
	fire_left.play()
	fire_up.play()
	fire_down.play()
	anim.play("Fire")

func ex_sfx():
	SFX.explosion(2)

func _on_Area2D_body_entered(body:Node):
	if body.get_groups().has("hittable"):
		body.hit(owned, gun_num, damage_type, damage)
