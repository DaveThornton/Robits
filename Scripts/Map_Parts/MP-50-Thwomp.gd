extends Node2D
export var hit_on_second = 1

onready var cast_down = $RayCast2D
onready var trigger = $"Area2D-Bottom/Area2D-Trigger" 
onready var hammer = $KinematicBody2D
onready var bottom = $"Area2D-Bottom"


var current_count = 0
var slamming = false
var speed = Vector2(0, 50)
func _ready():
	self.get_tree().get_current_scene().connect("second", self, "second")
	cast_down.force_raycast_update()
	if cast_down.is_colliding():
		bottom.global_position = cast_down.get_collision_point()

func _process(delta):
	if slamming:
		hammer.move_and_collide(speed)
		pass
#	pass

func slam():
	slamming = true

func second():
	current_count += 1
	if current_count == hit_on_second:
		slam()
		print("second called in thwomp second ", current_count)
	if current_count >= 4:
		current_count = 0