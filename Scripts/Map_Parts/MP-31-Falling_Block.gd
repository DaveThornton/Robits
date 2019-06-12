extends Node2D

export var start_speed = 150
export var respawn = true
export var respawn_time = 15.0

onready var plat = $KinematicBody2D
onready var timer = $Timer
onready var start_timer = $Start_Timer
onready var anim = $AnimationPlayer

var speed = 0
var started = false
var occ_array = []
var check = true
var check_times = 0
var check_limit = 5

func _ready():
	speed = start_speed

func _physics_process(delta):
	if check:
		if !occ_array.empty():
			check = false
			timer.start()
			anim.play("Warning")
		else:
			check_times = 0
			anim.play("Start")
	if started:
		plat.position.y += delta * speed
		if !occ_array.empty():
			for j in range(occ_array.size()):
				_move_player(j,delta)
		speed += speed / 2 * delta
		speed = clamp(speed,0,260)
		if plat.position.y >= 1300:
			speed = 0
			started = false
			print("stopped falling block off screen hopefully")
			if respawn:
				start_timer.wait_time = respawn_time
				start_timer.start()

func _move_player(array_num, delta):
	var p = occ_array[array_num]
	p.position.y += delta * speed

func _on_Area2D_Player_body_entered(body):
	if body.get_groups().has("player"):
		occ_array.append(body)
		body.vel.y = 0

func _on_Area2D_Player_body_exited(body):
	if body.get_groups().has("player"):
		occ_array.erase(body)

func _on_Timer_timeout():
	check = true
	check_times += 1
	if check_times == check_limit:
		started = true
		check = false
		anim.play("Falling")

func _on_Start_Timer_timeout():
	check = true
	plat.position.y = 0
	speed = start_speed

func set_start():
	started = true