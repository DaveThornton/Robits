tool
extends Node2D

export var editor_process: = true setget set_editor_process

export var line_color: = Color(.250,.01,.01,.5)
export var tri_color: = Color(.9,.01,.01,1)
export var line_width: = 10.0

var _active_point_index: = 0

func _ready() -> void:
	if not Engine.editor_hint:
		set_process(false)
	
func _process(_delta: float) -> void:
	update()

func _draw() -> void:
	if !Engine.editor_hint:
		return
	if !get_child_count() > 1:
		return
	var points: = PoolVector2Array()
	var triangles= []
	var last_point: = Vector2.ZERO
	
	for child in get_children():
		points.append(child.position)
		if points.size() > 1:
			var center: Vector2 = (child.position + last_point) /2
			var angle: = last_point.angle_to_point(child.position)
			triangles.append({center=center,angle=angle}) 
		last_point = child.position
	points.append(get_child(0).position)
	
	draw_polyline(points, line_color, line_width, true)
	for triangle in triangles:
		draw_triangle(triangle["center"], triangle["angle"],line_width * 2.0)

func get_start_position() -> Vector2:
	return get_child(0).global_position
	
func get_current_point_position() -> Vector2:
	return get_child(_active_point_index).global_position

func get_next_point_position():
	_active_point_index = (_active_point_index + 1 ) % get_child_count()
	return get_current_point_position()

func draw_triangle(center:Vector2, angle:float, radius:float) -> void:
	var points: = PoolVector2Array()
	var colors: = PoolColorArray([tri_color])
	for i in range(3):
		var angle_point: = angle + i * 2.0 * PI / 3.0 + PI
		var offset: = Vector2(radius * cos(angle_point), radius * sin(angle_point))
		var point: = center +offset
		points.append(point)
	draw_polygon(points, colors)

func set_editor_process(value:bool):
	editor_process = value
	if not Engine.editor_hint:
		return
	set_physics_process(value)
