extends Node2D

onready var anim = $AnimationPlayer
onready var cast_up = $Casts/RayCast2D_Up
onready var cast_right = $Casts/RayCast2D_Right
onready var cast_down = $Casts/RayCast2D_Down
onready var cast_left = $Casts/RayCast2D_Left
onready var area_out = $"Area2D-outer"
onready var poly_up = $"Area2D-outer/CollisionPolygon2D_UP"
onready var poly_right = $"Area2D-outer/CollisionPolygon2D_Right"
onready var poly_down = $"Area2D-outer/CollisionPolygon2D_Down"
onready var poly_left = $"Area2D-outer/CollisionPolygon2D_Left"
#onready var sfx = $SFX_Lib

var hit_already = []
var owned = 0
var my_name = "Explosion"
var weap_name = "Explosion"
var damage1 = 50
var damage2 = 100
var damage_type = "Explosion"

func _ready():
#	my_name = weap_name
	pass

func init(_owner, _pos, _weap_name, _pawn_num, _dmg):
	damage1 = _dmg / 2
	damage2 = _dmg
	print(area_out.get_overlapping_bodies())
	self.global_position = _pos
	owned = _owner
#	_check_dir()
	anim.play("Explode")
	
	print("1 poly up ", poly_up.disabled)
	print("1 poly right ", poly_right.disabled)
	print("1 poly down ", poly_down.disabled)
	print("1 poly left ", poly_left.disabled)
	_check_dir()
	print("2 poly up ", poly_up.disabled)
	print("2 poly right ", poly_right.disabled)
	print("2 poly down ", poly_down.disabled)
	print("2 poly left ", poly_left.disabled)
	
	weap_name = _weap_name
	SFX.play("EX_Standard")
	print(area_out.get_overlapping_bodies())

func _check_dir():
	poly_up.disabled = true
	poly_right.disabled = true
	poly_down.disabled = true
	poly_left.disabled = true
	cast_up.force_raycast_update()
	cast_right.force_raycast_update()
	cast_down.force_raycast_update()
	cast_left.force_raycast_update()
	if !cast_up.is_colliding():
#		print(!cast_up.is_colliding())
#		if cast_up.get_collider().get_groups().has("hittable"):
		poly_up.disabled = false
	if !cast_right.is_colliding():
#		if cast_right.get_collider().get_groups().has("hittable"):
		poly_right.disabled = false
	if !cast_down.is_colliding():
#		print(!cast_down.is_colliding())
#		if cast_down.get_collider().get_groups().has("map"):
		poly_down.disabled = false
	if !cast_left.is_colliding():
#		if cast_left.get_collider().get_groups().has("hittable"):
		poly_left.disabled = false
#	print("cast up  ",cast_up.is_colliding())
#	print("cast right  ",cast_right.is_colliding())
#	print("cast down  ",cast_down.is_colliding())
#	print("cast left  ",cast_left.is_colliding())

func start( _sr , _ss, _sss, _player):
	_check_dir()
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	print("",body)
	if body.get_groups().has("hittable"):

		body.hit(owned, weap_name, damage_type, damage1)
	elif body.get_groups().has("FX"):

		var f = body.global_position - self.global_position
		f.y =abs(f.y)
		var ex = 0
		var ey = 0
		if f.x <= 0:
			if f.x < -90:
				ex = -10
			elif f.x < -80:
#				print("less than -80")
				ex = -20
			elif f.x < -70:
#				print("less than -70")
				ex = -30
			elif f.x < -60:
#				print("less than -60")
				ex = -40
			elif f.x < -50:
#				print("less than -50")
				ex = -50
			elif f.x < -40:
#				print("less than -40")
				ex = -60
			elif f.x < -30:
#				print("less than -30")
				ex = -70
			elif f.x < -20:
#				print("less than -20")
				ex = -80
			elif f.x < -10:
#				print("less than -10")
				ex = -90
			else:
				print("error pushing it to 100")
				ex = -100
		else:
			if f.x > 90:
#				print("more than 90")
				ex = 10
			elif f.x > 80:
#				print("more than 80")
				ex = 20
			elif f.x > 70:
#				print("more than 70")
				ex = 30
			elif f.x > 60:
#				print("more than 60")
				ex = 40
			elif f.x > 50:
#				print("more than 50")
				ex = 50
			elif f.x > 40:
#				print("more than 40")
				ex = 60
			elif f.x > 30:
#				print("more than 30")
				ex = 70
			elif f.x > 20:
#				print("more than 20")
				ex = 80
			elif f.x > 10:
#				print("more than 10")
				ex = 90
			else:
				print("error pushing it to 100")
				ex = 100
		
		if f.y <= 0:
			if f.y < -90:
#				print("less than -90")
				ey = -10
			elif f.y < -80:
#				print("less than -80")
				ey = -20
			elif f.y < -70:
#				print("less than -70")
				ey = -30
			elif f.y < -60:
#				print("less than -60")
				ey = -40
			elif f.y < -50:
#				print("less than -50")
				ey = -50
			elif f.y < -40:
#				print("less than -40")
				ey = -60
			elif f.y < -30:
#				print("less than -30")
				ey = -70
			elif f.y < -20:
#				print("less than -20")
				ey = -80
			elif f.y < -10:
#				print("less than -10")
				ey = -90
			else:
				print("error pushing it to 100")
				ey = -100
		else:
			if f.y > 90:
#				print("more than 90")
				ey = 10
			elif f.y > 80:
#				print("more than 80")
				ey = 20
			elif f.y > 70:
#				print("more than 70")
				ey = 30
			elif f.y > 60:
#				print("more than 60")
				ey = 40
			elif f.y > 50:
#				print("more than 50")
				ey = 50
			elif f.y > 40:
#				print("more than 40")
				ey = 60
			elif f.y > 30:
#				print("more than 30")
				ey = 70
			elif f.y > 20:
#				print("more than 20")
				ey = 80
			elif f.y > 10:
#				print("more than 10")
				ey = 90
			else:
				print("error pushing it to 100")
				ey = 100
		body.apply_impulse(Vector2(), Vector2(ex * 2, ey * 2))

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, str(weap_name, " ", my_name), damage_type, damage2)
	elif body.get_groups().has("hittable"):
		print("trying to call hit on something hittable")
		body.hit(owned, weap_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")

func _on_Timer3_timeout():
	poly_up.disabled = true
	poly_right.disabled = true
	poly_down.disabled = true
	poly_left.disabled = true
