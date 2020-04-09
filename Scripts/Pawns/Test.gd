extends Node2D

onready var line = $Line2D
onready var path = $Line2D/Path2D
onready var head = $Sprite/Sprite2
onready var pos = $Line2D/Position2D
onready var anim = $AnimationPlayer
func _ready():
	anim.play("Run")
	pass
#	line.global_position = head.global_position
#	line.add_point(pos.position)
#	path.curve.add_point(head.global_position)
#	path.curve.add_point(pos.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line.set_point_position(1,pos.position)
	line.set_point_position(0,head.position)
