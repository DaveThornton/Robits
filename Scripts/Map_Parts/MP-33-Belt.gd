extends Node2D

export var right = false

onready var anim = $AnimationPlayer
onready var move_area = $Area2D
onready var left_pos = $"Position2D-Left"
onready var right_pos = $"Position2D-Right"

var speed = 60
var occ_player_array = []

func _ready():
#	call_deferred("start")
#func start():
	if right:
		move_area.set_gravity_vector(right_pos.position)
#		anim.play("Right")
		anim.play_backwards("Left")
	else:
		move_area.set_gravity_vector(left_pos.position)
		anim.play("Left")
#	print(anim.current_animation)
#	anim.playback_active

func _process(delta):
	if !occ_player_array.empty():
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		occ_player_array.erase(body)

func _move_player(array_num, delta):
	var p = occ_player_array[array_num]
	if right:
		p.position.x += delta * speed
	else:
		p.position.x -= delta * speed
