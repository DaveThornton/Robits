extends Node2D

#onready var block_solid = $RigidBody2D2
#onready var block_solid_shape = $RigidBody2D2/CollisionShape2D
onready var block_fall = $RigidBody2D
onready var block_fall_shape = $RigidBody2D/CollisionShape2D
onready var area = $Area2D
onready var area_shape = $Area2D/CollisionShape2D

var falling = false

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if falling:
		block_fall.position.y += -1

func _on_Area2D_area_entered(_area):
	print_debug("mp 30 entered area")
	falling = true
#	call_deferred("_start")
#
#func _start():
#	area_shape.disabled = true
#	block_fall_shape.disabled = false
#	block_solid_shape.disabled = true
#	block_fall.gravity_scale = 1