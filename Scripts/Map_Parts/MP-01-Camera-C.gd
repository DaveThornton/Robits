extends Node2D

export var can_move = false
export var zoom_offset : float = 0.2

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
var body_count_f3 = 0
var body_count_b3 = 0
var can_go_forward = true
var can_go_backward = true

var camera_rect : = Rect2()
var viewport_rect : = Rect2()
var pawns

func _ready():
	viewport_rect = get_viewport_rect()
	pawns  = get_tree().get_current_scene().get_pawns()
	print_debug(pawns)
#	set_process()
	randomize()
	noise_gen.seed = randi()
	noise_gen.period = 4
	noise_gen.octaves = 2

func _process(delta):
	if can_move:
		if !pawns:
			pawns  = get_tree().get_current_scene().get_pawns()
		camera_rect = Rect2(get_child(0).global_position, Vector2())
		for index in pawns.get_child_count():
			print_debug(pawns.get_child(index))
			if index ==0:
				continue
			camera_rect = camera_rect.expand(pawns.get_child(index).global_position)
#		print_debug(pawns.get_child_count())
		camera.offset = cal_center(camera_rect)
		camera.zoom = cal_zoom(camera_rect,viewport_rect.size)
	
	
	if false:
		if body_count_f > body_count_b:
			if !body_count_b3 > 0:
				speed += .1
				if body_count_f2 > body_count_b2:
					speed += 2
					if body_count_f3 > body_count_b3:
						speed += 2
#			self.position.x += 5 * body_count_f
#			self.position.x += clamp(speed, -max_speed, max_speed)
		elif body_count_b > body_count_f:
			if !body_count_f3 > 0:
				speed -= .1
				if body_count_b2 > body_count_f2:
					speed -= 2
					if body_count_b3 > body_count_f3:
						speed -= 2
#			self.position.x -= 5 * body_count_b
#			self.position.x += clamp(speed, -max_speed, max_speed)
		else:
			if speed > 1 && speed < -1:
				speed = 0
			elif speed > 0:
				speed -= 1
			elif speed < 0:
				speed += 1
		speed = clamp(speed, -max_speed, max_speed)
		self.position.x += speed #+= clamp(speed, -max_speed, max_speed)
		if self.position.x < 0:
			self.position.x = 0
		HUD.set_position(self.position)
	
	if trauma > 0.0:
		noise_y += 1
		_c_shake(delta)
		_c_rotate(delta)
		_c_static(delta)
		trauma = max(trauma - trauma_depletion * delta,0)

func cal_center(rect: Rect2) -> Vector2:
	return Vector2(
		rect.position.x + rect.size.x / 2,
		rect.position.y + rect.size.y / 2)

func cal_zoom(rect: Rect2, viewport_size:Vector2) -> Vector2:
	var max_zoom = max(
		max(1,rect.size.x / viewport_size.x + zoom_offset),
		max(1,rect.size.y / viewport_size.y + zoom_offset))
	return Vector2(max_zoom, max_zoom)

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
	print_debug("trauma added ", _amount, " amount in MP-01-Camera")
	trauma += _amount * 0.2
	trauma = clamp(trauma,0,.4)
	print_debug(trauma)

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

func _on_Area2DF3_body_entered(body):
	if body.get_groups().has("player"):
		body_count_f3 += 1

func _on_Area2DF3_body_exited(body):
	if body.get_groups().has("player"):
		body_count_f3 -= 1

func _on_Area2DB3_body_entered(body):
	if body.get_groups().has("player"):
		body_count_b3 += 1

func _on_Area2DB3_body_exited(body):
	if body.get_groups().has("player"):
		body_count_b3 -= 1
