extends Node2D

onready var camera = $Camera
onready var static_sprite = $Camera/SpriteStatic

onready var noise_gen = OpenSimplexNoise.new()
var noise_y = 0

var trauma: = 0.0
var trauma_power: = 3
var trauma_depletion: = 0.4

var max_c_off: = Vector2(50, 25)
var max_c_rot: = 0.9
var max_c_static: = 255
var min_c_static: = 15


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

#TODO ADD all this to effect in FX singlton connect 
func add_trauma(_amount):
	print("trauma added ", _amount, " amount")
	trauma += _amount * 0.1
	print(trauma)

# warning-ignore:unused_argument
func _c_shake(delta):
	var amount = pow(trauma,trauma_power)
	camera.offset_h = max_c_off.x * amount * noise_gen.get_noise_2d(noise_gen.seed, noise_y)
	camera.offset_v = max_c_off.y * amount * noise_gen.get_noise_2d(noise_gen.seed*2, noise_y)
	
# warning-ignore:unused_argument
func _c_rotate(delta):
	var amount = pow(trauma,trauma_power) * 20
	camera.rotation = max_c_rot * amount * noise_gen.get_noise_2d(noise_gen.seed*3, noise_y)
	
# warning-ignore:unused_argument
func _c_static(delta):
	var amount = pow(trauma,trauma_power) * 100 * max_c_static
# warning-ignore:narrowing_conversion
	static_sprite.modulate = Color8(255,255,255,clamp(amount, min_c_static ,max_c_static))
