extends KinematicBody2D

export var speed = 75

var up_down = true
var left_right = false
var robits_going_up = []
var going_right = false
var going_up = true

func _ready():
	pass # Replace with function body.

func _process(delta):
	if up_down:
		if going_up: self.global_position.y -= delta * speed
		else: self.global_position.y += delta * speed
	if left_right:
		if going_right: self.global_position.x += delta * speed
		else: self.global_position.x -= delta * speed


func change_dir(_up_down, _left_right):
	up_down = _up_down
	left_right = _left_right

func switch_dir():
	if up_down:
		if going_up: going_up = false
		else: going_up = true
	if left_right:
		if going_right: going_right = false
		else: going_right = true


func _on_Area2D_body_entered(body:Node):
	pass # Replace with function body.


func _on_Area2D_body_exited(body:Node):
	pass # Replace with function body.
