extends Node2D

export var can_move = false

onready var camera = $Camera
onready var static_sprite = $Camera/SpriteStatic
onready var effect = $Camera/CRT/ColorRect
onready var noise_gen = OpenSimplexNoise.new()
onready var front_area = $"Area2D-F"
onready var back_area = $"Area2D-B"
onready var front_area2 = $"Area2D-F2"
onready var back_area2 = $"Area2D-B2"

var speed = 0
var max_speed = 6
var noise_y = 0
var trauma: = 0.0
var trauma_power: = 3
var trauma_depletion: = 0.4
var max_c_off: = Vector2(35, 20)#was 50 25
var max_c_rot: = 0.4
var max_c_static: = 200
var min_c_static: = 3
var body_count_f = 0
var body_count_b = 0
var body_count_f2 = 0
var body_count_b2 = 0

func _ready():
	randomize()
	noise_gen.seed = randi()
	noise_gen.period = 4
	noise_gen.octaves = 2

func _process(delta):
	if can_move:
#		pass
#	if false:
		if body_count_f > body_count_b:
			speed = 2
#			speed += .1
			if body_count_f2 > body_count_b2:
				speed += 3
#			self.position.x += 5 * body_count_f
#			self.position.x += clamp(speed, -max_speed, max_speed)
#			HUD.set_position(self.position)
#			print("move right body F ",body_count_f, "body B ",body_count_b)
		elif body_count_b > body_count_f:
			speed = -2
#			speed -= .1
			if body_count_b2 > body_count_f2:
				speed -= 3
#			self.position.x -= 5 * body_count_b
#			self.position.x += clamp(speed, -max_speed, max_speed)
#			if self.position.x < 0:
#				self.position.x = 0
#			[HUD.set_position(self.position)]
		else:
			if speed > 1 && speed < 1:
				speed = 0
			elif speed > 0:
				speed -= 1
			elif speed < 0:
				speed += 1
		self.position.x += clamp(speed, -max_speed, max_speed)
		if self.position.x < 0:
			self.position.x = 0
		HUD.set_position(self.position)
			
#			print("move left body F ",body_count_f, "body B ",body_count_b)
	
	if trauma > 0.0:
		noise_y += 1
		_c_shake(delta)
		_c_rotate(delta)
		_c_static(delta)
		trauma = max(trauma - trauma_depletion * delta,0)

func static_on():
	static_sprite.visible = true
func static_off():
	static_sprite.visible = false
func static_set_amount(_amount):
	min_c_static = _amount
	static_sprite.modulate = Color8(255,255,255,_amount)

func crt_on():
	effect.visible = true
func crt_off():
	effect.visible = false

func add_trauma(_amount):
	print("trauma added ", _amount, " amount in MP-01-Camera")
	trauma += _amount * 0.2
	trauma = clamp(trauma,0,.4)
	print(trauma)

func _c_shake(_delta):
	var amount = pow(trauma,trauma_power)
	camera.offset_h = max_c_off.x * amount * noise_gen.get_noise_2d(noise_gen.seed, noise_y)
	camera.offset_v = max_c_off.y * amount * noise_gen.get_noise_2d(noise_gen.seed*2, noise_y)

func _c_rotate(_delta):
	var amount = pow(trauma,trauma_power) * 10
	var _rot = max_c_rot * amount * noise_gen.get_noise_2d(noise_gen.seed*3, noise_y)
	camera.rotation = clamp(_rot, -max_c_rot, max_c_rot)

func _c_static(_delta):
	var amount = pow(trauma,trauma_power) * 10 * max_c_static
# warning-ignore:narrowing_conversion
	static_sprite.modulate = Color8(255,255,255,clamp(amount, min_c_static ,max_c_static))

func _on_Area2DF_body_entered(body):
	if body.get_groups().has("player"):
		body_count_f += 1

func _on_Area2DF_body_exited(body):
	if body.get_groups().has("player"):
		body_count_f -= 1

func _on_Area2DB_body_entered(body):
	if body.get_groups().has("player"):
		body_count_b += 1

func _on_Area2DB_body_exited(body):
	if body.get_groups().has("player"):
		body_count_b -= 1


func _on_Area2DF2_body_entered(body):
	if body.get_groups().has("player"):
		body_count_f2 += 1

func _on_Area2DF2_body_exited(body):
	if body.get_groups().has("player"):
		body_count_f2 -= 1

func _on_Area2DB2_body_entered(body):
	if body.get_groups().has("player"):
		body_count_b2 += 1

func _on_Area2DB2_body_exited(body):
	if body.get_groups().has("player"):
		body_count_b2 -= 1
