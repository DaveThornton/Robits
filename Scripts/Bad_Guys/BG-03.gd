extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var grav: = 9.0
var on_floor: = false
var on_ladder: = false
var vel: = Vector2(0, 0)
var terminal_vel: = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var movement = Vector2(0 , ((vel.y + (grav * int(!on_floor)) * delta)) * int(!on_ladder))
	vel = movement
	if on_floor:
		vel.y = vel.y / 1.1
	if vel.y > terminal_vel:
		vel.y = terminal_vel
	move_and_collide(vel)
