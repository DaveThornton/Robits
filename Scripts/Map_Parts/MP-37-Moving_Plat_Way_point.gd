tool
extends KinematicBody2D

onready var timer = $Timer
onready var waypoints: = get_node(waypoints_path)
onready var move_area: = $Area2D
onready var player_area_shape = $Area2D/CollisionShape2D

export var editor_process: = true setget set_editor_process
export var speed: = 400.0
export var player_area_size = 20.0
export var waypoints_path: = NodePath()

var target_position = Vector2()
var _robits: Array = []


func _ready() -> void:
	if not waypoints:
		set_physics_process(false)
		return
	target_position = waypoints.get_start_position()
	player_area_shape = player_area_size

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
			print_debug("fix way point MP-37")

func set_editor_process(value:bool):
	editor_process = value
	if not Engine.editor_hint:
		return
	set_physics_process(value)
#	timer.stop()

#func _process(delta):
#	pass

func _on_Timer_timeout():
	set_physics_process(true)

func _on_Area2D_body_entered(body):
	if body.get_groups().has("player"):
		print_debug("player entered platform map part 37")
		_robits.append(body)

func _on_Area2D_body_exited(body):
	if body.get_groups().has("player"):
		print_debug("player exited platform map part 37")
		_robits.erase(body)
