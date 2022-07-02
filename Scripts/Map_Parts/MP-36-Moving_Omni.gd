extends Node2D

export var up = false
export var kill_up_on = false
export var down = false
export var kill_down_on = false
export var left = false
export var kill_left_on = false
export var right = false
export var kill_right_on = false

export var how_far = 300
export var speed = 75
export var delay_start = false
export var start_time = 1.0
export var wait = true
export var wait_time = 1

onready var plat = $Plat

onready var kill_plat_shape = $"Plat/Area2D-Kill-plat/CollisionShape2D"
onready var kill_up_shape = $"Area2D-Kill-Up/CollisionShape2D"
onready var kill_down_shape = $"Area2D-Kill-Down/CollisionShape2D"
onready var kill_left_shape = $"Area2D-Kill-Left/CollisionShape2D"
onready var kill_right_shape = $"Area2D-Kill-Right/CollisionShape2D"

var started = true

var going_up = false
var going_down = false
var going_left = false
var going_right = false

var waiting = false
var is_waiting = true
var wait_count = 0
var occ_array = []
var kill_array = []
var last_move = true
var move = false

func _ready():
	var con = self.get_tree().get_current_scene().connect("second", self, "second")
	if con != 0:
		print_debug("error on connecting second to second in MP-36-Moving omni")
	if !kill_up_on && !kill_down_on && !kill_left_on && !kill_right_on:
		kill_plat_shape.disabled = true
		kill_up_shape.disabled = true
		kill_down_shape.disabled = true
		kill_left_shape.disabled = true
		kill_right_shape.disabled = true
#		pass
	else:
		if !kill_up_on:
			kill_up_shape.disabled = true
		else:
			kill_up_shape.disabled = false
			if up:
				kill_up_shape.position.y -= how_far
				print_debug(position)
			
		if !kill_down_on:
			kill_down_shape.disabled = true
		else:
			kill_down_shape.disabled = false
			if down:
				kill_down_shape.position.y += how_far
				print_debug(position)
			
		if !kill_left_on:
			kill_left_shape.disabled = true
		else:
			kill_left_shape.disabled = false
			if left:
				kill_left_shape.position.x -= how_far
				print_debug(position)
			
		if !kill_right_on:
			kill_right_shape.disabled = true
		else:
			kill_right_shape.disabled = false
			if right:
				kill_right_shape.position.x += how_far
				print_debug(position)
	
	if wait:
		waiting = true

func _physics_process(delta):
	if started:
		if !waiting:
			if up && !down:
				if plat.position.y < (-1 * how_far):
					going_up = false
					going_down = true
					last_move = false
				elif plat.position.y >= 0:
					going_up = true
					going_down = false
					last_move = true
			elif !up && down:
				if plat.position.y <= 0:
					going_up = false
					going_down = true
					last_move = false
				elif plat.position.y > how_far:
					going_up = true
					going_down = false
					last_move = true
			elif !up && !down:
				pass
			else:
				print_debug("error in moving plat. cant be both up and down choose one damnit")
			
			if left && !right:
				if plat.position.x < (-how_far):
					going_left = false
					going_right = true
					last_move = false
				elif plat.position.x >= 0:
					plat.position.x = 0
					going_left = true
					going_right = false
					last_move = true
			elif !left && right:
				if plat.position.x <= 0:
					going_left = false
					going_right = true
					last_move = false
				elif plat.position.x > how_far:
					going_left = true
					going_right = false
					last_move = true
			elif !left && !right:
				pass
			else:
				print_debug("error in moving plat. cant be both left and right choose one damnit")
			
			if going_up && !going_down:
				plat.position.y -= delta * speed
			elif !going_up && going_down:
				plat.position.y += delta * speed
			
			if going_left && !going_right:
				plat.position.x -= delta * speed
			elif !going_left && going_right:
				plat.position.x += delta * speed
				
			if wait:
				if last_move != move:
					waiting = true
				move = last_move
			if !occ_array.empty():
				for j in range(occ_array.size()):
					_move_player(j,delta)

func _move_player(array_num, delta):
	var p = occ_array[array_num]
	
	if going_up && !going_down:
		p.position.y -= delta * speed
	elif !going_up && going_down:
		p.position.y += delta * speed
	
	if going_left && !going_right:
		p.position.x -= delta * speed
	elif !going_left && going_right:
		p.position.x += delta * speed

func second():
	if waiting:
		wait_count += 1
		if wait_time == wait_count:
			wait_count = 0
			waiting = false

func _on_Area2D_Player_body_entered(body):
	if body.get_groups().has("player"):
		print_debug("player entered platform")
		occ_array.append(body)
		body.vel.y = 0

func _on_Area2D_Player_body_exited(body):
	if body.get_groups().has("player"):
		print_debug("player exited platform")
		occ_array.erase(body)

func _check_add_body(body):
	if body.get_groups().has("player"):
		if kill_array.has(body):
			body.killed_by_map(0, "map", "map", 100)
		else:
			kill_array.append(body)

func _remove_body(body):
	if body.get_groups().has("player"):
		kill_array.erase(body)

func set_start():
	started = true

func _on_Area2DKillplat_body_entered(body):
	_check_add_body(body)

func _on_Area2DKillplat_body_exited(body):
	_remove_body(body)

func _on_Area2DKillUp_body_entered(body):
	_check_add_body(body)

func _on_Area2DKillUp_body_exited(body):
	_remove_body(body)

func _on_Area2DKillDown_body_entered(body):
	_check_add_body(body)

func _on_Area2DKillDown_body_exited(body):
	_remove_body(body)

func _on_Area2DKillLeft_body_entered(body):
	_check_add_body(body)

func _on_Area2DKillLeft_body_exited(body):
	_remove_body(body)

func _on_Area2DKillRight_body_entered(body):
	_check_add_body(body)

func _on_Area2DKillRight_body_exited(body):
	_remove_body(body)
