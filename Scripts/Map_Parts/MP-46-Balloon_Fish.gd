extends Node2D
onready var fish = $"MP-46-Balloon_Fish"
onready var top_pos = $Top_Position2D
onready var bot_pos = $Bot_Position2D
onready var mouth_pos = $"MP-46-Balloon_Fish/Mouth_Area2D/CollisionShape2D"
var moving_up = false
var moving_down = false
var bite = false
var bitten
var speed = 300
# func _ready():
# 	pass # Replace with function body.

func _process(delta):
	if !bite && moving_up && fish.global_position.y > top_pos.global_position.y:
		go_up(delta)
	elif !bite && moving_down && fish.global_position.y < bot_pos.global_position.y:
		go_down(delta)
	elif bite && bitten:
		bitten.global_position = mouth_pos.global_position
		go_down(delta/2)


func go_up(delta):
	fish.global_position.y = fish.global_position.y + -speed * delta

func go_down(delta):
	fish.global_position.y = fish.global_position.y + speed * delta


func _on_Area2D_body_entered(_body):
	moving_up = true
	moving_down = false

func _on_Area2D_body_exited(_body):
	moving_up = false 
	moving_down = true


func _on_Mouth_Area2D_body_entered(_body):
	if _body.get_groups().has("player"):
		bite = true
		bitten = _body
		
func _on_Mouth_Area2D_body_exited(_body):
	bite = false
	bitten = null
