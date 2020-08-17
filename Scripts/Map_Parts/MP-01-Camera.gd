extends Node2D

onready var camera = $Camera
onready var static_sprite = $Camera/SpriteStatic
onready var effect = $Camera/CRT/ColorRect
onready var noise_gen = OpenSimplexNoise.new()

var noise_y = 0
var trauma: = 0.0
var trauma_power: = 3
var trauma_depletion: = 0.4
var max_c_off: = Vector2(40, 20)#was 50 25
var max_c_rot: = 0.5
var max_c_static: = 220
var min_c_static: = 5

func _ready():
	randomize()
	noise_gen.seed = randi()
	noise_gen.period = 4
	noise_gen.octaves = 2

func _process(delta):
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
	print("trauma added ", _amount, " amount")
	trauma += _amount * 0.2
	trauma = clamp(trauma,0,.4)
	print(trauma)

func _c_shake(delta):
	var amount = pow(trauma,trauma_power)
	camera.offset_h = max_c_off.x * amount * noise_gen.get_noise_2d(noise_gen.seed, noise_y)
	camera.offset_v = max_c_off.y * amount * noise_gen.get_noise_2d(noise_gen.seed*2, noise_y)
	

func _c_rotate(_delta):
	var amount = pow(trauma,trauma_power) * 10
	var _rot = max_c_rot * amount * noise_gen.get_noise_2d(noise_gen.seed*3, noise_y)
	camera.rotation = clamp(_rot, -max_c_rot, max_c_rot)


func _c_static(delta):
	var amount = pow(trauma,trauma_power) * 10 * max_c_static
	static_sprite.modulate = Color8(255,255,255,clamp(amount, min_c_static ,max_c_static))
