extends Node2D

onready var anim = $AnimationPlayer
onready var b_radius = $"Area2D2-inner/CollisionShape2D-inner".shape.radius

var owned = 0
var my_name = "Explosion"
var damage1 = 25
#var damage2 = 75
var damage_type = "Explosion"
var blast_dis = 1.5

func _ready():
	print(b_radius)
	
	pass

func init(_owner, _pos):
	owned = _owner
	anim.play("Explode")
	self.global_position = _pos

func start( _sr , _ss, _sss, _player):
	owned = _player
	self.position = _ss

func _on_Area2Douter_body_entered(body):
	_body_entered(body)

func _body_entered(body):
	if body.get_groups().has("hittable"):
		body.hit(owned, my_name, damage_type, damage1)
	elif body.get_groups().has("FX"):
#		print("hit FX")
		var r = rand_range(.25, 2)
#		var a = Vector2( 0, 0)
#		var b = self.position
		var f = body.global_position - self.global_position
		f.y = -(abs(f.y))
		
#		var e = self.global_position - body.global_position
		var ex = 0
		var ey = 0

		if f.x <= 0:
			if f.x < -(b_radius / 10):
#				print("less than -90")
				ex = -(blast_dis/ .1)
			elif f.x < -((b_radius / 10)*2):
#				print("less than -80")
				ex = -((blast_dis/ .1)* 2)
			elif f.x < -((b_radius / 10)*3):
#				print("less than -70")
				ex = -((blast_dis/ .1)* 3)
			elif f.x < -((b_radius / 10)*4):
#				print("less than -60")
				ex = -((blast_dis/ .1)* 4)
			elif f.x < -((b_radius / 10)*5):
#				print("less than -50")
				ex = -((blast_dis/ .1)* 5)
			elif f.x < -((b_radius / 10)*6):
#				print("less than -40")
				ex = -((blast_dis/ .1)* 6)
			elif f.x < -((b_radius / 10)*7):
#				print("less than -30")
				ex = -((blast_dis/ .1)* 7)
			elif f.x < -((b_radius / 10)*8):
#				print("less than -20")
				ex = -((blast_dis/ .1)* 8)
			elif f.x < -((b_radius / 10)*9):
#				print("less than -10")
				ex = -((blast_dis/ .1)* 9)
			else:
				print("error pushing it to 100 in small 20x20 FX in -f.x")
				ex = -blast_dis
		else:
			if f.x > (b_radius / 10):
#				print("more than 90")
				ex = (blast_dis/ .1)
			elif f.x > ((b_radius / 10)*2):
#				print("more than 80")
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*3):
#				print("m
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*4):
#				print("more than 60")
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*5):
#				print("more than 50")
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*6):
#				print("more than 40")
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*7):
#				print("more than 30")7
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*8):
#				print("more than 20")
				ex = ((blast_dis/ .1)* 2)
			elif f.x > ((b_radius / 10)*9):
#				print("more than 10")
				ex = ((blast_dis/ .1)* 2)
			else:
				print("error pushing it to 100 in f.x")
				ex = blast_dis
		
		if f.y <= 0:
			if f.y < -(b_radius / 10):
#				print("less than -90")
				ey = -(blast_dis/ .1)
			elif f.y < -((b_radius / 10)*2):
#				print("less than -80")
				ey = -((blast_dis/ .1)* 2)
			elif f.y < -((b_radius / 10)*3):
#				print("less than -70")
				ey = -((blast_dis/ .1)* 3)
			elif f.y < -((b_radius / 10)*4):
#				print("less than -60")
				ey = -((blast_dis/ .1)* 4)
			elif f.y < -((b_radius / 10)*5):
#				print("less than -50")
				ey = -((blast_dis/ .1)* 5)
			elif f.y < -((b_radius / 10)*6):
#				print("less than -40")
				ey = -((blast_dis/ .1)* 6)
			elif f.y < -((b_radius / 10)*7):
#				print("less than -30")
				ey = -((blast_dis/ .1)* 7)
			elif f.y < -((b_radius / 10)*8):
#				print("less than -20")
				ey = -((blast_dis/ .1)* 8)
			elif f.y < -((b_radius / 10)*9):
#				print("less than -10")
				ey = -((blast_dis/ .1)* 9)
			else:
				print("error pushing it to 100 in small 20x20 FX in -f.y")
				ey = -blast_dis
		else:
			if f.y > (b_radius / 10):
#				print("more than 90")
				ey = (blast_dis/ .1)
			elif f.y > ((b_radius / 10)*2):
#				print("more than 80")
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*3):
#				print("m
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*4):
#				print("more than 60")
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*5):
#				print("more than 50")
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*6):
#				print("more than 40")
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*7):
#				print("more than 30")7
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*8):
#				print("more than 20")
				ey = ((blast_dis/ .1)* 2)
			elif f.y > ((b_radius / 10)*9):
#				print("more than 10")
				ey = ((blast_dis/ .1)* 2)
			else:
				print("error pushing it to 100 in -f.y")
				ey = blast_dis
		body.apply_impulse(Vector2(), Vector2((ex * 2) * r, (ey * 2) * r))

func _on_Area2D2inner_body_entered(body):
	_body_entered(body)
#	if body.get_groups().has("player"):
#		body.hit(owned, my_name, damage_type, damage2)

func _on_Timer_timeout():
	anim.play("fade")

func _on_Timer2_timeout():
	queue_free()