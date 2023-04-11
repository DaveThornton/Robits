extends Area2D


onready var shape = $CollisionShape2D

export var size = 100
export var buffer_distance = 5
var shape_vec = Array()

var dag_size = .75

signal obj_entered

func set_size(_size):
	size = _size
	update_shape()

func update_shape():
	shape.shape.radius = size

func disable_shape(dis):
	shape.disabled = dis

func _on_EX_Part_Damage_Area_body_entered(body:Node):
	var dis = self.global_position.distance_to(body.global_position)
	var per = abs((dis / (size + buffer_distance)))
	emit_signal("obj_entered", body, per)