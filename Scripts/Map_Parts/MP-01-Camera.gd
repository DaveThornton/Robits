extends Camera2D

export var can_move = false
export var zoom_offset : float = 0.2
export var rect_offset = 960

onready var static_sprite = $SpriteStatic
onready var effect = $CRT/ColorRect
onready var noise_gen = OpenSimplexNoise.new()
onready var cage = $"MP-04-Screen_Player_Cage"

var speed = 0
var max_speed = 6
var noise_y = 0
var trauma: = 0.0
var trauma_power: = 3
var trauma_depletion: = 0.2
var stop_trauma = false
var max_c_off: = Vector2(35, 20)#was 50 25
var max_c_rot: = 0.4
var max_c_static: = 120
var min_c_static: = 6
var juice_on = true
var juice_amount = 0.1
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
	static_sprite.modulate = Color8(255,255,255,min_c_static)
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

func get_position(): return self.global_position

func stop():
	move(false)
	cage_on(true)

func go():
	move(true)
	cage_on(false)

func move(_move):
	can_move = _move
	cage.move(global_position.x)

func cage_on(_on): cage.turn_on(_on)

func static_on(): static_sprite.visible = true
func static_off(): static_sprite.visible = false

func set_min_static(_amount):
# func static_set_amount(_amount):
	print_debug("setting min static amount to ", _amount)
	min_c_static = _amount
	static_sprite.modulate = Color8(255,255,255,_amount)

func set_max_static(_amount):
	print_debug("setting max static amount to ", _amount)
	max_c_static = _amount

func get_static_status(): return static_sprite.visible

func crt_on():
	effect.visible = true
func crt_off():
	effect.visible = false
func get_crt_status(): return effect.visible

func add_trauma(_amount):
	if juice_on && !stop_trauma:
		trauma += _amount * juice_amount
		trauma = clamp(trauma,0,(juice_amount * 4))

func set_stop_trauma(_stop): stop_trauma = _stop #set in m30 to keep end screen readable

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

func set_juice_on(_on):
	juice_on = _on
	print_debug("juice turned ", _on, " in camera")
	if juice_on:
		add_trauma(5)

func get_juice_on(): return juice_on

func set_juice_amount(_amount):
	juice_amount = _amount
	print_debug("juice_amount changed in camera  ", _amount)

func get_juice_amount(): return juice_amount

func reset():
	position.x = 0
	HUD.set_position(self.position)
