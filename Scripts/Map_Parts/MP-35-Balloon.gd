extends KinematicBody2D
onready var ray_down = $RayCast2D_down
onready var balloon_01 = $"MP-35-Balloon_01-01"
onready var balloon_02 = $"MP-35-Balloon_01-02"
export var color_set = 1

var speed = 15
var occ_player_array = []
var not_top = true
var top_pos = 0.0

func _ready():
	top_pos = self.global_position.y
	if color_set > 1 && color_set < 5:
		balloon_01.frame = color_set
		balloon_02.frame = color_set + 4

func _process(delta):
	if self.global_position.y > top_pos: 
		not_top = true
	else:
		not_top = false
	
	if occ_player_array.size() > 0 && !ray_down.is_colliding():
		move_down(delta)
	elif occ_player_array.size() == 0 && not_top == true:
		move_up(delta)

func move_up(delta):
	self.position.y -= speed * delta * 5

func move_down(delta):
	self.position.y += speed * delta * occ_player_array.size()

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		occ_player_array.append(body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		occ_player_array.erase(body)