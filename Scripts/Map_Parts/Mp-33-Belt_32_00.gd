extends Node2D

# export var right = false
# export var mode = 1
onready var anim = $AnimationPlayer
onready var move_area = $Area2D

var right = true
var mode = 0
var speed = 42
var occ_player_array = []

func _ready():
	pass
# 		Map_Hand.map.connect("start",self ,"start")

func start():
	print_debug("start ",mode,"   ", right)
	if right:
		# move_area.set_gravity_vector(Vector2(self.position.x + 32, self.position.y - 16))
		move_right()
	else:
		# move_area.set_gravity_vector(Vector2(self.position.x - 32, self.position.y  - 16))
		move_left()

func _process(delta):
	if !occ_player_array.empty():
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func setup(_mode, _right):
	print_debug("set_up  ",_mode,"   ",  _right)
	mode = _mode
	right = _right
	call_deferred("start")
	# start()

	# call_deferred("set_mode", _mode)
	# # set_mode(_mode)
	# # right = _right
	# if _right:
	# 	call_deferred("move_right")
	# else:
	# 	call_deferred("move_left")

func set_mode(new_mode):
	# if new_mode >= 0 && new_mode <= 3:
		# print_debug("mode set to ", new_mode)
	mode = new_mode

func move_right():
	print_debug("move_right   ", mode)
	right = true
	match mode:
		0: anim.play("Left")
		1: anim.play("Mid")
		2: anim.play("Mid")
		3: anim.play("Right")

func move_left():
	print_debug("move_left   ", mode)
	right = false
	match mode:
		0: anim.play_backwards("Left")
		1: anim.play_backwards("Mid")
		2: anim.play_backwards("Mid")
		3: anim.play_backwards("Right")

func stop():
	anim.stop()

func switch_dir():
	if right:
		move_left()
	else:
		move_right()

func _move_player(array_num, delta):
	var p = occ_player_array[array_num]
	if right:
		p.position.x += delta * speed
	else:
		p.position.x -= delta * speed

func _on_Area2D_body_entered(body:Node):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_body_exited(body:Node):
	if body.get_groups().has("player"):
		occ_player_array.erase(body)
