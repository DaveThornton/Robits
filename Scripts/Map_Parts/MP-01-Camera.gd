extends Camera2D

export var can_move = false
export var zoom_offset : float = 0.2
export var rect_offset = 960
onready var static_sprite = $SpriteStatic
onready var effect = $CRT/ColorRect
onready var noise_gen = OpenSimplexNoise.new()

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
var can_go_forward = true
var can_go_backward = true

var camera_rect : = Rect2()
var viewport_rect : = Rect2()
var pawns

func _ready():
	viewport_rect = get_viewport_rect()
	pawns  = get_tree().get_current_scene().get_pawns()
	print(pawns)
#	set_process()
	randomize()
	noise_gen.seed = randi()
	noise_gen.period = 4
	noise_gen.octaves = 2

func _process(delta):
	if can_move:
		if !pawns:
			pawns  = get_tree().get_current_scene().get_pawns()
		else:
			if pawns.get_child_count() > 0 :
				camera_rect = Rect2(pawns.get_child(0).global_position + Vector2(50,0), Vector2())
				for index in pawns.get_child_count():
#					print(pawns.get_child(index))
#					if index ==0:
#						continue
					camera_rect = camera_rect.expand(pawns.get_child(index).global_position)# + Vector2(-1960,0))
		#		print(pawns.get_child_count())
				position = cal_center(camera_rect)
#				draw_rect(camera_rect,Color8(255,255,255,255),false)
#				zoom = cal_zoom(camera_rect,viewport_rect.size)
		if position.x < 0: self.position.x = 0
		HUD.set_position(self.position)
		
	if trauma > 0.0:
		noise_y += 1
		_c_shake(delta)
		_c_rotate(delta)
		_c_static(delta)
		trauma = max(trauma - trauma_depletion * delta,0)

func _draw():
	draw_rect(camera_rect,Color8(255,255,255,255),false)

func cal_center(rect: Rect2) -> Vector2:
	return Vector2(
		rect.position.x + rect.size.x + -rect_offset / 2,0)
#		rect.position.y + rect.size.y / 2)

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
	print("trauma added ", _amount, " amount in MP-01-Camera")
	trauma += _amount * 0.2
	trauma = clamp(trauma,0,.4)
	print(trauma)

func _c_shake(_delta):
	var amount = pow(trauma,trauma_power)
	offset_h = max_c_off.x * amount * noise_gen.get_noise_2d(noise_gen.seed, noise_y)
	offset_v = max_c_off.y * amount * noise_gen.get_noise_2d(noise_gen.seed*2, noise_y)

func _c_rotate(_delta):
	var amount = pow(trauma,trauma_power) * 10
	var _rot = max_c_rot * amount * noise_gen.get_noise_2d(noise_gen.seed*3, noise_y)
	rotation = clamp(_rot, -max_c_rot, max_c_rot)

func _c_static(_delta):
	var amount = pow(trauma,trauma_power) * 10 * max_c_static
# warning-ignore:narrowing_conversion
	static_sprite.modulate = Color8(255,255,255,clamp(amount, min_c_static ,max_c_static))
