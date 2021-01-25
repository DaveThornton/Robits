extends Node2D
export var my_pipe_number = 0
export var go_to_pipe_number = 0

onready var timer = $Timer
onready var timer_clear = $Timer_clear_space
onready var clear_area = $Area2D_Clear_Space/CollisionShape2D
onready var pos_out = $"Position2D-Outside"
onready var pos_in = $"Position2D-Inside"

var partner
var occ_player_array_in = []
var occ_player_array_in_remove = []
var occ_player_array_out = []
var occ_player_array_out_remove = []
var speed = 100
var clearing = false

var test_num = 0

func _ready():
	get_partner()

func _process(delta):
	if occ_player_array_out.size() > 0:
		call_deferred("move_players_out",delta)

#	if occ_player_array_out.size() > 0:
#		print("next")
#		for p in occ_player_array_out.size():
#			if occ_player_array_out[p]:
#				occ_player_array_out[p].global_position.x -= speed * delta
#				occ_player_array_out[p].global_position.y = pos_out.global_position.y
#				if occ_player_array_out[p].global_position.x < pos_out.global_position.x:
#					occ_player_array_out[p].can_move = true
#					occ_player_array_out.remove(p)
#			else:
#				occ_player_array_out.remove(p)


#	if occ_player_array_in.size() > 0:
#		for p in occ_player_array_in.size():
#			if occ_player_array_in[p] != null:
#				if occ_player_array_in[p].is_down:
#					if (pos_out.global_position.y - occ_player_array_in[p].global_position.x) < 0:
#						occ_player_array_in[p].global_position.y -= (speed / 4) * delta
#					if (pos_out.global_position.y - occ_player_array_in[p].global_position.x) > 0:
#						occ_player_array_in[p].global_position.y += (speed / 4) * delta
#			else:
#				occ_player_array_in.remove(p)


#	test_num += delta
#	if test_num > 1:
#		print("in ", occ_player_array_in, "           out", occ_player_array_out, "                     mp 42")
#		test_num = 0


func move_players_out(_delta):
		for p in occ_player_array_out.size():
			if occ_player_array_out[p] != null:
				var s = occ_player_array_out[p]
				s.global_position.x -= speed * _delta
				s.global_position.y = pos_out.global_position.y
				if s.global_position.x < pos_out.global_position.x:
					s.can_move = true
					remove_out(s)
					add_to_in(s)
#					occ_player_array_out.remove(p)
			else:
				occ_player_array_out.remove(p)

#---------------------------------------------------------------trasnportation
func transport_here(_body):
	clearing = true
	clear_area.disabled = false
	timer_clear.start()
	add_to_out(_body)
	_body.global_position = pos_in.global_position
	
#	if occ_player_array_out.find(_body) == -1:
#		add_to_out(_body)
#		occ_player_array_out.append(_body)
	for p in occ_player_array_in.size():
		if occ_player_array_in[p] != null:
			occ_player_array_in[p].knock_dir(500, .2, 3, true)

func transport_there(_body):
	print("transport there")
	_body.can_move = false
	if partner:
		partner.transport_here(_body)
	else:
		print("cant find partner in mp 42")

#---------------------------------------------------------------get partner pipe
func get_partner():
	timer.start()

func _on_Timer_timeout():
	var m = Map_Hand.map.get_pipe(go_to_pipe_number)
	if m == null:
		print(go_to_pipe_number," not a pipe number to go to. deleting self MP-42")
		call_deferred("queue_free")
	else:
		print(my_pipe_number," ", m," ", go_to_pipe_number," ", m.my_pipe_number," MP-42")
		partner = m

#-----------------------------------------------------------------bodies entered
func _on_Area2DOutside_body_entered(body):
	if body.get_groups().has("player"):
		add_to_in(body)
		
func _on_Area2DOutside_body_exited(body):
	if body.get_groups().has("player"):
		remove_in(body)

func _on_Area2DInside_body_entered(body):
	if body.get_groups().has("player"):
		if occ_player_array_in.find(body) != -1 && occ_player_array_out.find(body) == -1:
			remove_in(body)
			transport_there(body)

func _on_Area2DInside_body_exited(body):
	if body.get_groups().has("player"):
		remove_in(body)
#		transport_there(body)
#-----------------------------------------------------------------extra funcs

func _on_Timer_clear_space_timeout():
	clearing = false
	clear_area.disabled = true

#--------------------------------------------------------------------add/remove
func add_to_in(_body):
	print("add to in")
	if occ_player_array_in.find(_body) == -1:
		occ_player_array_in.append(_body)
	if!_body.is_connected("explode_p", self, "remove_in"):
		_body.connect("explode_p", self, "remove_in")

func remove_in(_body):
	if occ_player_array_in.find(_body) != -1:
		occ_player_array_in.erase(_body)
		_body.disconnect("explode_p", self, "remove_in")

func just_remove():#write a func for removing from both with all 4 arguments
	pass

func add_to_out(_body):
	if occ_player_array_out.find(_body) == -1:
		occ_player_array_out.append(_body)
	if !_body.is_connected("explode_p", self, "remove_out"):
		_body.connect("explode_p", self, "remove_out")

func remove_out(_body):
	var b = occ_player_array_out.find(_body)
	if b != -1:
		occ_player_array_out.remove(b)
		_body.disconnect("explode_p", self, "remove_out")
