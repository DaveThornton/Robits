extends Camera2D

export var can_move = false
export var zoom_offset : float = 0.2
export var rect_offset = 960
onready var static_sprite = $SpriteStatic
onready var effect = $CRT/ColorRect
onready var noise_gen = OpenSimplexNoise.new()
onready var edge_left = $StaticBody2D/CollisionShape2D_Left
onready var edge_right = $StaticBody2D/CollisionShape2D_Right

var speed = 0
var max_speed = 6
var noise_y = 0
var trauma: = 0.0
var trauma_power: = 3
var trauma_depletion: = 0.2
var max_c_off: = Vector2(35, 20)#was 50 25
var max_c_rot: = 0.4
var max_c_static: = 120
var min_c_static: = 10
var can_go_forward = true
var can_go_backward = true
var max_right = 0
var max_left = 0
var camera_rect : = Rect2()
var viewport_rect : = Rect2()
var pawns

func _ready():
	var test = get_tree().get_current_scene().connect("reset", self, "reset")
	if test != 0:
		print_debug("error camera connecting to reset from world gd")
	viewport_rect = get_viewport_rect()
	pawns  = get_tree().get_current_scene().get_pawns()
	print_debug(pawns)
	randomize()
	noise_gen.seed = randi()
	noise_gen.period = 4
	noise_gen.octaves = 2

func _process(delta):
	if can_move:
		var all_player_pos = 0.0
		if !pawns:
			pawns  = get_tree().get_current_scene().get_pawns()
		else:
			if pawns.get_child_count() > 0 :
				for p in pawns.get_child_count():
					all_player_pos += pawns.get_child(p).position.x
				var new_pos = (all_player_pos / pawns.get_child_count()) - 960
				position.x += (new_pos - position.x) / 4
		if position.x < max_left: position.x = max_left # keep camera from going to far left
		elif position.x > max_right: position.x = max_right
		HUD.set_position(self.position)
		
	if trauma > 0.0:
		noise_y += 1
		_c_shake(delta)
		_c_rotate(delta)
		_c_static(delta)
		trauma = max(trauma - trauma_depletion * delta,0)


func move(_move):
	print_debug("camera move ",!_move)
	can_move = _move
	edge_left.disabled = !_move
	edge_right.disabled = !_move

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
#	print_debug("trauma added ", _amount, " amount in MP-01-Camera")
	trauma += _amount * 0.1
	trauma = clamp(trauma,0,.4)
	# print_debug("trauma :", trauma, "    in MP-01-Camera")

func _c_shake(_delta):
	var amount = pow(trauma,trauma_power)
	offset_h = max_c_off.x * amount * noise_gen.get_noise_2d(noise_gen.seed, noise_y)
	offset_v = max_c_off.y * amount * noise_gen.get_noise_2d(noise_gen.seed*2, noise_y)

func _c_rotate(_delta):
	var amount = pow(trauma,trauma_power) * 10
	var _rot = max_c_rot * amount * noise_gen.get_noise_2d(noise_gen.seed*3, noise_y)
	rotation = clamp(_rot, -max_c_rot, max_c_rot)

func _c_static(_delta):
	var amount = pow(trauma,trauma_power) * 50 * max_c_static
# warning-ignore:narrowing_conversion
	static_sprite.modulate = Color8(255,255,255,clamp(amount, min_c_static ,max_c_static))

func reset():
	position.x = 0
	HUD.set_position(self.position)
