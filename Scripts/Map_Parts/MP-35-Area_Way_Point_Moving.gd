tool
extends Area2D

onready var timer = $Timer
onready var waypoints: = get_node(waypoints_path)

export var editor_process: = true setget set_editor_process
export var speed: = 400.0
export var player_area_size = 20.0
export var waypoints_path: = NodePath()

var target_position = Vector2()
var _robits: Array = []

func _ready():
	if not waypoints:
		set_physics_process(false)
		return
	target_position = waypoints.get_start_position()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = (target_position - position).normalized()
	var motion: = direction * speed * delta
	var distance_to_target: = position.distance_to(target_position)
	if motion.length() > distance_to_target:
		position = target_position
		target_position = waypoints.get_next_point_position()
		set_physics_process(false)
		timer.start()
	else:
		position += motion
		if _robits.size() > 0:
			for i in _robits.size():
				_robits[i].position += motion
			print("fix way point MP-35")

func set_editor_process(value:bool):
	editor_process = value
	if not Engine.editor_hint:
		return
	set_physics_process(value)

func _on_MP35Area_Way_Point_Moving_body_entered(body):
	if body.get_groups().has("player"):
		print("player entered platform map part 35")
		_robits.append(body)

func _on_MP35Area_Way_Point_Moving_body_exited(body):
	if body.get_groups().has("player"):
		print("player exited platform map part 35")
		_robits.erase(body)


func _on_Timer_timeout():
	set_physics_process(true)
