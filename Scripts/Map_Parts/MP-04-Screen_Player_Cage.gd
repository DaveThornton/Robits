extends KinematicBody2D

onready var right_edge = $CollisionShape2D_Right
onready var left_edge = $CollisionShape2D_Left

var right_edge_off = false
var left_edge_off = false

func _ready():
	update_edge()

# func _process(_delta):
# 	if !right_edge_off || !left_edge_off:
# 		self.global_position = FX.CAMERA.get_position()

# func set_edge(_right, _left):
# 	right_edge_off = _right
# 	left_edge_off = _left
# 	update_edge()

func move(x_pos):
	self.global_position.x = x_pos

func update_edge():
	right_edge.disabled = right_edge_off
	left_edge.disabled = left_edge_off

func turn_on(_on):
	right_edge_off = _on
	left_edge_off = _on
	if _on:
		self.global_position.y = 0
	else:
		self.global_position.y = 1080
	update_edge()

# func turn_off():
# 	right_edge_off = true
# 	left_edge_off = true
# 	self.global_position.y = 0
# 	update_edge()