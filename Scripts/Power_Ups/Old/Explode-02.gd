extends Node2D

onready var anim = $AnimationPlayer

var owned = 0
var my_name = "Explosion"
var damage1 = 25
var damage2 = 75
var damage_type = "Explosion"
#var damage_from = "basic"

func _ready():
	pass

func init(_owner, _pos):
	owned = _owner
	anim.play("Explode")

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	if body.get_groups().has("hittable"):
		body.hit(owned, my_name, damage_type, damage1)
	elif body.get_groups().has("FX"):
#		print_debug("hit Pick Up")
#		var a = Vector2( 0, 0)
#		var b = self.position
		var f = body.global_position - self.global_position
		f.y =abs(f.y)
#		var e = self.global_position - body.global_position
		var ex = 0
		var ey = 0

		if f.x <= 0:
			if f.x < -90:
#				print_debug("less than -90")
				ex = -10
			elif f.x < -80:
#				print_debug("less than -80")
				ex = -20
			elif f.x < -70:
#				print_debug("less than -70")
				ex = -30
			elif f.x < -60:
#				print_debug("less than -60")
				ex = -40
			elif f.x < -50:
#				print_debug("less than -50")
				ex = -50
			elif f.x < -40:
#				print_debug("less than -40")
				ex = -60
			elif f.x < -30:
#				print_debug("less than -30")
				ex = -70
			elif f.x < -20:
#				print_debug("less than -20")
				ex = -80
			elif f.x < -10:
#				print_debug("less than -10")
				ex = -90
			else:
				print_debug("error pushing it to 100")
				ex = -100
		else:
			if f.x > 90:
#				print_debug("more than 90")
				ex = 10
			elif f.x > 80:
#				print_debug("more than 80")
				ex = 20
			elif f.x > 70:
#				print_debug("more than 70")
				ex = 30
			elif f.x > 60:
#				print_debug("more than 60")
				ex = 40
			elif f.x > 50:
#				print_debug("more than 50")
				ex = 50
			elif f.x > 40:
#				print_debug("more than 40")
				ex = 60
			elif f.x > 30:
#				print_debug("more than 30")
				ex = 70
			elif f.x > 20:
#				print_debug("more than 20")
				ex = 80
			elif f.x > 10:
#				print_debug("more than 10")
				ex = 90
			else:
				print_debug("error pushing it to 100")
				ex = 100
		
		if f.y <= 0:
			if f.y < -90:
#				print_debug("less than -90")
				ey = -10
			elif f.y < -80:
#				print_debug("less than -80")
				ey = -20
			elif f.y < -70:
#				print_debug("less than -70")
				ey = -30
			elif f.y < -60:
#				print_debug("less than -60")
				ey = -40
			elif f.y < -50:
#				print_debug("less than -50")
				ey = -50
			elif f.y < -40:
#				print_debug("less than -40")
				ey = -60
			elif f.y < -30:
#				print_debug("less than -30")
				ey = -70
			elif f.y < -20:
#				print_debug("less than -20")
				ey = -80
			elif f.y < -10:
#				print_debug("less than -10")
				ey = -90
			else:
				print_debug("error pushing it to 100")
				ey = -100
		else:
			if f.y > 90:
#				print_debug("more than 90")
				ey = 10
			elif f.y > 80:
#				print_debug("more than 80")
				ey = 20
			elif f.y > 70:
#				print_debug("more than 70")
				ey = 30
			elif f.y > 60:
#				print_debug("more than 60")
				ey = 40
			elif f.y > 50:
#				print_debug("more than 50")
				ey = 50
			elif f.y > 40:
#				print_debug("more than 40")
				ey = 60
			elif f.y > 30:
#				print_debug("more than 30")
				ey = 70
			elif f.y > 20:
#				print_debug("more than 20")
				ey = 80
			elif f.y > 10:
#				print_debug("more than 10")
				ey = 90
			else:
				print_debug("error pushing it to 100")
				ey = 100
		body.apply_impulse(Vector2(), Vector2(ex * 2, ey * 2))

func _on_Area2D2inner_body_entered(body):
	if body.get_groups().has("player"):
		body.hit(owned, my_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	call_deferred("free")#queue_free()
