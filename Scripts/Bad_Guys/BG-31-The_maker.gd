extends KinematicBody2D

export var going_right = false

onready var anim =$AnimationPlayer
onready var ray_down = $RayCast2D
var my_name = "The Maker"
var dmg_type = "Worm"
var damage = 5000

var speed = 90
var grav = 500
var occ_player_array = []


func _ready():
	if going_right:
		anim.play("Going_Right")
		if speed < 0:
			speed *= -1
	else:
		anim.play("Going_Left")
		if speed > 0:
			speed *= -1

func _physics_process(delta):
	move_and_slide(Vector2(speed * delta * 100,0 ))
	if !ray_down.is_colliding():
		move_and_collide(Vector2(0, grav * delta *10))
	if !occ_player_array.empty():
		for j in range(occ_player_array.size()):
			_move_player(j,delta)

func set_going_right(_right):
	going_right = _right
	if going_right:
		anim.play("Going_Right")
		if speed < 0:
			speed *= -1
	else:
		anim.play("Going_Left")
		if speed > 0:
			speed *= -1

func _move_player(array_num, delta):
	var p = occ_player_array[array_num]
	if going_right:
		p.global_position.x -= delta * speed * 1.6
	else:
		p.global_position.x += delta * speed * 1.6


func _on_Area2D_body_entered(_body:Node):
	if _body.get_groups().has("player"):
		_body.hit(-1, my_name, dmg_type, damage)

func _on_Area2D_Move_body_entered(body:Node):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_Move_body_exited(body:Node):
	if body.get_groups().has("player"):
		occ_player_array.erase(body)
