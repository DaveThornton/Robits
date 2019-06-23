extends Node2D
export var hit_on_second = 1
export var count_to_second = 4
export var trigger_on_prox = false

onready var cast_down = $RayCast2D
onready var trigger = $"Area2D-Bottom/Area2D-Trigger" 
onready var hammer = $KinematicBody2D
onready var bottom = $"Area2D-Bottom"
onready var timer = $Timer

var current_count = 0
var slamming = false
var area_slam = false
var speed_down = Vector2(0, 20)
var speed_up = Vector2(0, -20)

func _ready():
#	if !trigger_on_prox:
	self.get_tree().get_current_scene().connect("second", self, "second")
	cast_down.force_raycast_update()
	if cast_down.is_colliding():
		bottom.global_position = cast_down.get_collision_point()

func _process(delta):
	if slamming:
		var j = hammer.move_and_collide(speed_down)
#		print(j, slamming, current_count)
#		timer.start()
	else:
		hammer.move_and_collide(speed_up)
#	pass

func slam():
	slamming = true

func second():
	current_count += 1
	if current_count == hit_on_second:
		slam()
#		print("second called in thwomp second ", current_count)
	else:
		slamming = false
	if current_count >= count_to_second:
		current_count = 0

func _on_Timer_timeout():
	print("timeout", slamming)
	slamming = false

func _on_Area2DThuwmp_body_entered(body):
	if slamming:
		if body.get_groups().has("hittable") || body.get_groups().has("player"):
#			print("hit")
			body.hit(-1, "Thowmp", "Impact", 1000)
#			pass


func _on_Area2DTrigger_body_entered(body):
#	slam()
#	timer.start()
	pass
