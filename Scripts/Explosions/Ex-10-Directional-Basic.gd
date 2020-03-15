extends Node2D

onready var anim = $AnimationPlayer

# top right is 1 count clockwise around
#inner cast
onready var cast_in1 = $Raycasts/Inner/RayCast2D
onready var cast_in2 = $Raycasts/Inner/RayCast2D2
onready var cast_in3 = $Raycasts/Inner/RayCast2D3
onready var cast_in4 = $Raycasts/Inner/RayCast2D4
onready var cast_in5 = $Raycasts/Inner/RayCast2D5
onready var cast_in6 = $Raycasts/Inner/RayCast2D6
onready var cast_in7 = $Raycasts/Inner/RayCast2D7
onready var cast_in8 = $Raycasts/Inner/RayCast2D8
#outer cast
onready var cast_out1 = $Raycasts/Outer/RayCast2D
onready var cast_out2 = $Raycasts/Outer/RayCast2D2
onready var cast_out3 = $Raycasts/Outer/RayCast2D3
onready var cast_out4 = $Raycasts/Outer/RayCast2D4
onready var cast_out5 = $Raycasts/Outer/RayCast2D5
onready var cast_out6 = $Raycasts/Outer/RayCast2D6
onready var cast_out7 = $Raycasts/Outer/RayCast2D7
onready var cast_out8 = $Raycasts/Outer/RayCast2D8
#inner blast area
onready var shape_in1 = $"Area2D-Inner/CollisionPolygon2D"
onready var shape_in2 = $"Area2D-Inner/CollisionPolygon2D2"
onready var shape_in3 = $"Area2D-Inner/CollisionPolygon2D3"
onready var shape_in4 = $"Area2D-Inner/CollisionPolygon2D4"
onready var shape_in5 = $"Area2D-Inner/CollisionPolygon2D5"
onready var shape_in6 = $"Area2D-Inner/CollisionPolygon2D6"
onready var shape_in7 = $"Area2D-Inner/CollisionPolygon2D7"
onready var shape_in8 = $"Area2D-Inner/CollisionPolygon2D8"
#outer blast area
onready var shape_out1 = $"Area2D-Outer/CollisionPolygon2D"
onready var shape_out2 = $"Area2D-Outer/CollisionPolygon2D2"
onready var shape_out3 = $"Area2D-Outer/CollisionPolygon2D3"
onready var shape_out4 = $"Area2D-Outer/CollisionPolygon2D4"
onready var shape_out5 = $"Area2D-Outer/CollisionPolygon2D5"
onready var shape_out6 = $"Area2D-Outer/CollisionPolygon2D6"
onready var shape_out7 = $"Area2D-Outer/CollisionPolygon2D7"
onready var shape_out8 = $"Area2D-Outer/CollisionPolygon2D8"


var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 50
var damage2 = 100
var damage_type = "Explosion"

#func _ready():
##	my_name = weap_name
#	pass

func init(_owner, _pos, _weap_name, _pawn_num, _dmg):
	damage1 = (_dmg * .5)
	damage2 = _dmg
	self.global_position = _pos
	owned = _owner
	weap_name = _weap_name
	_check_dir()
	anim.play("Explode")
	SFX.play("EX_Standard")
	FX.add_trauma(2)

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2DOuter_body_entered(body):
	if body.get_groups().has("player"):
		Player_Stats.add_hit(owned,1)
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		body.hit(owned, weap_name, damage_type, damage1)

func _on_Area2DInner_body_entered(body):
	if body.get_groups().has("player"):
		Player_Stats.add_hit(owned,1)
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		print("trying to call hit on something hittable ex-02")
#		Player_Stats.add_hit(owned,1)
		body.hit(owned, weap_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("Fade")

func _on_Timer2_timeout():
	queue_free()

func _on_Timer3_timeout():
	shape_in1.disabled = true
	shape_in2.disabled = true
	shape_in3.disabled = true
	shape_in4.disabled = true
	shape_in5.disabled = true
	shape_in6.disabled = true
	shape_in7.disabled = true
	shape_in8.disabled = true
	shape_out1.disabled = true
	shape_out2.disabled = true
	shape_out3.disabled = true
	shape_out4.disabled = true
	shape_out5.disabled = true
	shape_out6.disabled = true
	shape_out7.disabled = true
	shape_out8.disabled = true

func _check_dir():
	cast_in1.force_raycast_update()
	cast_in2.force_raycast_update()
	cast_in3.force_raycast_update()
	cast_in4.force_raycast_update()
	cast_in5.force_raycast_update()
	cast_in6.force_raycast_update()
	cast_in7.force_raycast_update()
	cast_in8.force_raycast_update()
	
	cast_out1.force_raycast_update()
	cast_out2.force_raycast_update()
	cast_out3.force_raycast_update()
	cast_out4.force_raycast_update()
	cast_out5.force_raycast_update()
	cast_out6.force_raycast_update()
	cast_out7.force_raycast_update()
	cast_out8.force_raycast_update()
	
	if !cast_in1.is_colliding():
		shape_in1.disabled = false
	if !cast_in2.is_colliding():
		shape_in2.disabled = false
	if !cast_in3.is_colliding():
		shape_in3.disabled = false
	if !cast_in4.is_colliding():
		shape_in4.disabled = false
	if !cast_in5.is_colliding():
		shape_in5.disabled = false
	if !cast_in6.is_colliding():
		shape_in6.disabled = false
	if !cast_in7.is_colliding():
		shape_in7.disabled = false
	if !cast_in8.is_colliding():
		shape_in8.disabled = false
	
	if !cast_out1.is_colliding():
		shape_out1.disabled = false
	if !cast_out2.is_colliding():
		shape_out2.disabled = false
	if !cast_out3.is_colliding():
		shape_out3.disabled = false
	if !cast_out4.is_colliding():
		shape_out4.disabled = false
	if !cast_out5.is_colliding():
		shape_out5.disabled = false
	if !cast_out6.is_colliding():
		shape_out6.disabled = false
	if !cast_out7.is_colliding():
		shape_out7.disabled = false
	if !cast_out8.is_colliding():
		shape_out8.disabled = false
