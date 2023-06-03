extends Node2D

onready var anim = $AnimationPlayer
onready var move_area = $Area2D

var right = true
var mode = 0
var speed = 42
var occ_player_array = []

func start():
	if right:
		move_right()
	else:
		move_left()

func _process(delta):
	if !occ_player_array.empty():
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func setup(_mode, _right):
	mode = _mode
	right = _right
	start()

func set_mode(new_mode):
	mode = new_mode

func move_right():
	move_area.gravity_vec.x = 1.4
	right = true
	match mode:
		0: anim.play("Left")
		1: anim.play("Mid")
		2: anim.play("Mid")
		3: anim.play("Right")

func move_left():
	move_area.gravity_vec.x = -1.4
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
