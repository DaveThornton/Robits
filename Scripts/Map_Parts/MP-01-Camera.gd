extends Camera2D
# static was done by myself thats why its trashy
onready var static_sprite: = $SpriteStatic
var _static_bottom: = 13
var _static_timer: = 0.0
# this code is from godot(Q&A) OG by Hammer Bro. moded by batmanasb (shake)
var _shake_duration = 0.0
var _shake_period_in_ms = 0.0
var _shake_amplitude = 0.0
var _shake_timer = 0.0
var _last_shook_timer = 0
var _previous_x = 0.0
var _previous_y = 0.0
var _last_offset = Vector2(0, 0)

func _ready():
	set_process(true)
	add_static(0,10)
	_static_bottom = static_sprite.modulate.a8

# Shake with decreasing intensity while there's time remaining.
func _process(delta):
#	print(static_sprite.modulate.a8)
	if _shake_timer == 0 && _static_timer == 0:
		set_offset(Vector2())
		set_static(Color8(255,255,255,_static_bottom))
		set_process(false)
		return
	elif _shake_timer == 0:
		set_offset(Vector2())
		_p_static(delta)
		return
	elif _static_timer == 0:
		set_static(Color8(255,255,255,_static_bottom))
		_p_shake(delta)
		return
	_p_shake(delta)
	_p_static(delta)
	return

func _p_shake(delta):
	# Only shake on certain frames.
	_last_shook_timer = _last_shook_timer + delta
	# Be mathematically correct in the face of lag; usually only happens once.
	while _last_shook_timer >= _shake_period_in_ms:
		_last_shook_timer = _last_shook_timer - _shake_period_in_ms
		# Lerp between [amplitude] and 0.0 intensity based on remaining shake time.
		var intensity = _shake_amplitude * (1 - ((_shake_duration - _shake_timer) / _shake_duration))
		# Noise calculation logic from http://jonny.morrill.me/blog/view/14
		var new_x = rand_range(-1.0, 1.0)
		var x_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
		var new_y = rand_range(-1.0, 1.0)
		var y_component = intensity * (_previous_y + (delta * (new_y - _previous_y)))
		_previous_x = new_x
		_previous_y = new_y
		# Track how much we've moved the offset, as opposed to other effects.
		var new_offset = Vector2(x_component, y_component)
		set_offset(get_offset() - _last_offset + new_offset)
		_last_offset = new_offset
	# Reset the offset when we're done shaking.
	_shake_timer = _shake_timer - delta
	if _shake_timer <= 0:
		_shake_timer = 0
		set_offset(get_offset() - _last_offset)

func _p_static(delta):
	var _less_static = (static_sprite.modulate.a8 - _static_bottom) / (_static_timer * 60)
	set_static_alpha(static_sprite.modulate.a8 - _less_static)
	_static_timer -= delta
	if _static_timer < 0.0:
		_static_timer = 0.0

# Kick off a new screenshake effect.
func add_shake(duration, frequency, amplitude):
	# Don't interrupt current shake duration
	if(_shake_timer != 0):
		return
	# Initialize variables.
	_shake_duration = duration
	_shake_timer = duration
	_shake_period_in_ms = 1.0 / frequency
	_shake_amplitude = amplitude
	_previous_x = rand_range(-1.0, 1.0)
	_previous_y = rand_range(-1.0, 1.0)
	# Reset previous offset, if any.
	set_offset(get_offset() - _last_offset)
	_last_offset = Vector2(0, 0)
	set_process(true)

# Kick off a new stadic effect.
func add_static(duration, ampitude):
	_static_timer += duration
	set_static_alpha(ampitude)
#	set_static(static_sprite.modulate + Color8(0,0,0,ampitude))
#	static_sprite.modulate += Color8(0,0,0,ampitude)
#	static_sprite.modulate = Color8(255,255,255,100)
#	print(static_sprite.modulate)
	set_process(true)

func set_static(_color):
	static_sprite.modulate = _color

func set_static_alpha(_a8):
	static_sprite.modulate.a8 = _a8
