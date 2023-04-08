extends Area2D

onready var c_up = $RayCasts/RayCast2D_Up
onready var c_ur = $RayCasts/RayCast2D_UR
onready var c_rt = $RayCasts/RayCast2D_RT
onready var c_dr = $RayCasts/RayCast2D_DR
onready var c_dn = $RayCasts/RayCast2D_DN
onready var c_dl = $RayCasts/RayCast2D_DL
onready var c_lt = $RayCasts/RayCast2D_LT
onready var c_ul = $RayCasts/RayCast2D_UL
onready var shape = $CollisionPolygon2D

export var size = 100
export var buffer_distance = 5
var shape_vec = Array()

var dag_size = .75

signal obj_entered

func set_size(_size):
	size = _size

func set_pos(_pos):
	self.global_position = _pos

func update_shape():
	call_deferred("_update_shape")
func _update_shape():
	shape_vec.clear()
	var p1 = Vector2(0,-size)
	var p2 = Vector2(size * dag_size, -size * dag_size)
	var p3 = Vector2(size,0)
	var p4 = Vector2(size * dag_size, size * dag_size)
	var p5 = Vector2(0,size)
	var p6 = Vector2(-size * dag_size, size * dag_size)
	var p7 = Vector2(-size,0)
	var p8 = Vector2(-size * dag_size, -size * dag_size)

	c_up.cast_to.y = -size
	c_ur.cast_to.y = -size * dag_size
	c_ur.cast_to.x = size * dag_size
	c_rt.cast_to.x = size
	c_dr.cast_to.y = size * dag_size
	c_dr.cast_to.x = size * dag_size
	c_dn.cast_to.y = size
	c_dl.cast_to.y = size * dag_size
	c_dl.cast_to.x = -size * dag_size
	c_lt.cast_to.x = -size
	c_ul.cast_to.y = -size * dag_size
	c_ul.cast_to.x = -size * dag_size

	c_up.force_raycast_update()
	c_ur.force_raycast_update()
	c_rt.force_raycast_update()
	c_dr.force_raycast_update()
	c_dn.force_raycast_update()
	c_dl.force_raycast_update()
	c_lt.force_raycast_update()
	c_ul.force_raycast_update()

	if c_up.is_colliding():
		p1 = to_local(c_up.get_collision_point())
	if c_ur.is_colliding():
		p2 = to_local(c_ur.get_collision_point())	
	if c_rt.is_colliding():
		p3 = to_local(c_rt.get_collision_point())
	if c_dr.is_colliding():
		p4 = to_local(c_dr.get_collision_point())
	if c_dn.is_colliding():
		p5 = to_local(c_dn.get_collision_point())
	if c_dl.is_colliding():
		p6 = to_local(c_dl.get_collision_point())
	if c_lt.is_colliding():
		p7 = to_local(c_lt.get_collision_point())
	if c_ul.is_colliding():
		p8 = to_local(c_ul.get_collision_point())

	shape_vec.append(p1)
	shape_vec.append(p2)
	shape_vec.append(p3)
	shape_vec.append(p4)
	shape_vec.append(p5)
	shape_vec.append(p6)
	shape_vec.append(p7)
	shape_vec.append(p8)
	shape.set_polygon(shape_vec)

func disable_shape(dis):
	shape.disabled = dis

func _on_EX_Part_Damage_Area_body_entered(body:Node):
	if body.get_groups().has("hittable"):
		var dis = self.global_position.distance_to(body.global_position)
		var per = abs((dis / (size + buffer_distance))) #clamp(size / dis * 100,15.0,100.0)
		emit_signal("obj_entered", body, per)
