extends KinematicBody2D

onready var timer = $Timer

export var speed = 60

export var up_down = true
export var left_right = false
export var going_right = false
export var going_up = true

var save_state = []
var robits_in_area = []

func _ready():
	pass # Replace with function body.

func _process(delta):
	if up_down:
		if going_up: self.global_position.y -= delta * speed
		else: self.global_position.y += delta * speed
	if left_right:
		if going_right: self.global_position.x += delta * speed
		else: self.global_position.x -= delta * speed
	if !robits_in_area.empty()&& left_right:
		for j in range(robits_in_area.size()):
			_move_player(j,delta)
			# _move_player_to_plat(j)	

func stop():
	change_dir(false,false,false,false)

func change_dir(_up_down, _left_right, _going_up, _going_right):
	up_down = _up_down
	left_right = _left_right
	going_up = _going_up
	going_right = _going_right

func switch_dir():
	save_state.clear()
	save_state.append(up_down)
	save_state.append(left_right)
	save_state.append(going_up)
	save_state.append(going_right)	
	stop()
	timer.start()

func now_switch():
	up_down = save_state[0]
	left_right = save_state[1]
	going_up = save_state[2]
	going_right = save_state[3]
	if up_down:
		if going_up: going_up = false
		else: going_up = true
		# for j in range(robits_in_area.size()):
		# 	_move_player_to_plat(j)
	if left_right:
		if going_right: going_right = false
		else: going_right = true


func _on_Area2D_body_exited(body:Node):
	if body.get_groups().has("player"):
		call_deferred("remove_robit_from_area_count",body)

func _on_Area2D_body_entered(body:Node):
	if body.get_groups().has("player"):
		call_deferred("add_robit_to_area_count",body)

func add_robit_to_area_count(_body):
	if robits_in_area.find(_body) == -1:
		robits_in_area.append(_body)
	if!_body.is_connected("explode_p", self, "remove_robit_from_area_count"):
		_body.connect("explode_p", self, "remove_robit_from_area_count")

func remove_robit_from_area_count(_body):
	if robits_in_area.find(_body) != -1:
		robits_in_area.erase(_body)
		_body.disconnect("explode_p", self, "remove_robit_from_area_count")

func _move_player(array_num, delta):
	var p = robits_in_area[array_num]
	if left_right:
		if going_right:
			p.position.x += delta * speed
		else:
			p.position.x -= delta * speed

func _move_player_to_plat(array_num):
	var p = robits_in_area[array_num]
	if going_up:
		p.position.y = self.position.y
	else:
		p.position.y = self.position.y

func _on_Timer_timeout():
	now_switch()
